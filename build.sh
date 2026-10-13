#!/bin/bash
# Usage: ./build.sh filename          -> assemble, then open DOSBox at the prompt
#        ./build.sh filename debug    -> assemble, then open DOSBox with AFD loaded
#
# filename is WITHOUT .asm. Files live in examples/. Max 8 characters.
#
# In DOSBox you land in the examples folder, so you can type:
#   filename.com        run the program (good for display memory output)
#   afd filename.com    debug it in AFD

set -e

if [ -z "$1" ]; then
    echo "Usage: ./build.sh <filename> [debug]"
    exit 1
fi

if ! command -v nasm &> /dev/null; then
    echo "nasm not found. Run ./install.sh first."
    exit 1
fi

FILE="$1"
MODE="$2"
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
ASM_PATH="$REPO_DIR/examples/$FILE.asm"

if [ ! -f "$ASM_PATH" ]; then
    echo "File not found: $ASM_PATH"
    exit 1
fi

echo "Assembling $FILE.asm..."
nasm -f bin "$ASM_PATH" -o "$REPO_DIR/examples/$FILE.com" -l "$REPO_DIR/examples/$FILE.lst"
echo "Assembled OK -> examples/$FILE.com"

CONF="$REPO_DIR/.dosbox_runtime.conf"
cat > "$CONF" <<EOF
[autoexec]
mount c "$REPO_DIR"
c:
set path=c:\tools;%path%
cd examples
EOF

if [ "$MODE" == "debug" ]; then
    echo "afd $FILE.com" >> "$CONF"
fi

DOSBOX_BIN="dosbox"
if ! command -v dosbox &> /dev/null; then
    if [ -f "/Applications/DOSBox.app/Contents/MacOS/DOSBox" ]; then
        DOSBOX_BIN="/Applications/DOSBox.app/Contents/MacOS/DOSBox"
    else
        echo "dosbox not found. Run ./install.sh first, or open a new terminal and retry."
        rm -f "$CONF"
        exit 1
    fi
fi

"$DOSBOX_BIN" -conf "$CONF"
rm -f "$CONF"

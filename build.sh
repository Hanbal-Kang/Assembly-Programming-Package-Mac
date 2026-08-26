#!/bin/bash
# Usage: ./build.sh filename
# filename is WITHOUT the .asm extension. Put your .asm files in examples/
# (or wherever, as long as it's inside this repo folder).
#
# Keep filenames to 8 characters max (DOS 8.3 filename limit).
#
# Assembling happens NATIVELY on macOS (via brew-installed nasm) since
# the original package's nasm.exe is a Windows binary, not DOS, and
# can't run in DOSBox. Only AFD.exe (real DOS binary) runs inside DOSBox.
#
# Inside AFD:
#   F2  - step one instruction
#   F1  - step, but step OVER calls
#   G   - run to completion / next breakpoint
#   B   - set a breakpoint

set -e

if [ -z "$1" ]; then
    echo "Usage: ./build.sh <filename>"
    exit 1
fi

FILE="$1"
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
ASM_PATH="$REPO_DIR/examples/$FILE.asm"

if [ ! -f "$ASM_PATH" ]; then
    echo "File not found: $ASM_PATH"
    exit 1
fi

echo "Assembling $FILE.asm..."
nasm -f bin "$ASM_PATH" -o "$REPO_DIR/examples/$FILE.com"
echo "Assembled OK -> examples/$FILE.com"

CONF="$REPO_DIR/.dosbox_runtime.conf"
cat > "$CONF" <<EOF
[autoexec]
mount c "$REPO_DIR"
c:
set path=c:\tools;%path%
cd examples
afd $FILE.com
EOF

# Find dosbox even if it's not on PATH yet (e.g. install.sh's symlink
# step got skipped or needed a fresh terminal).
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

#!/bin/bash
# Installs everything needed on macOS.
# - NASM: installed natively via Homebrew (assembling happens on macOS
#   directly, not inside DOSBox).
# - DOSBox: installed via Homebrew as a Mac .app, then symlinked into
#   PATH so `dosbox` works as a plain terminal command (the cask alone
#   doesn't do this).

set -e

if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Install it first: https://brew.sh"
    exit 1
fi

echo "Installing NASM (native macOS)..."
brew install nasm

echo "Installing DOSBox..."
brew install --cask dosbox

# Figure out Homebrew's bin dir (Apple Silicon vs Intel) so the symlink
# actually lands somewhere on PATH.
BREW_BIN="$(brew --prefix)/bin"

DOSBOX_APP="/Applications/DOSBox.app/Contents/MacOS/DOSBox"

if [ -f "$DOSBOX_APP" ] && [ ! -e "$BREW_BIN/dosbox" ]; then
    echo "Linking dosbox into $BREW_BIN..."
    ln -sf "$DOSBOX_APP" "$BREW_BIN/dosbox"
fi

if ! command -v dosbox &> /dev/null; then
    echo ""
    echo "WARNING: dosbox still not found on PATH."
    echo "Try opening a new terminal window and running ./build.sh again."
    echo "If it still fails, run:"
    echo "  ln -sf \"$DOSBOX_APP\" \"$BREW_BIN/dosbox\""
    exit 1
fi

echo ""
echo "Done. NASM and DOSBox are ready."
echo "Run ./build.sh <filename-without-extension> to assemble and debug a .asm file."

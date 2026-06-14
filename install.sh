#!/usr/bin/env bash
set -euo pipefail

ASSEMBLINGS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Checking dependencies..."
if ! command -v clang >/dev/null 2>&1; then
    echo "clang not found. Install Xcode Command Line Tools:"
    echo "  xcode-select --install"
    exit 1
fi
echo "  clang $(clang --version | head -1 | awk '{print $4}') found."

if [[ "$(uname -m)" != "arm64" ]]; then
    echo "Warning: assemblings is designed for ARM64 (Apple Silicon)."
    echo "  Current arch: $(uname -m)"
fi

RC=""
if [[ "$SHELL" == */zsh ]]; then RC="$HOME/.zshrc"
elif [[ "$SHELL" == */bash ]]; then RC="$HOME/.bashrc"
else RC="$HOME/.profile"
fi

LINE="export PATH=\"\$PATH:$ASSEMBLINGS_DIR\""
if grep -qF "$ASSEMBLINGS_DIR" "$RC" 2>/dev/null; then
    echo "assemblings already in PATH (found in $RC)"
else
    echo "" >> "$RC"
    echo "# assemblings" >> "$RC"
    echo "$LINE" >> "$RC"
    echo "Added to $RC"
fi

echo ""
echo "Done! Activate with:"
echo "  source $RC"
echo ""
echo "Then start:"
echo "  assemblings"

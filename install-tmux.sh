#!/bin/bash
# Install tmux and Tmux Plugin Manager (TPM)

set -e

echo "Installing tmux..."
yay -S --noconfirm --needed tmux

if ! command -v tmux &>/dev/null; then
    echo "✗ tmux installation failed"
    exit 1
fi

echo "✓ tmux installed successfully"

# Install TPM (Tmux Plugin Manager)
TPM_DIR="$HOME/.tmux/plugins/tpm"

if [ -d "$TPM_DIR" ]; then
    echo "✓ TPM already installed at $TPM_DIR"
else
    echo "Installing TPM (Tmux Plugin Manager)..."
    mkdir -p "$HOME/.tmux/plugins"
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    echo "✓ TPM installed successfully"
    echo ""
    echo "To install tmux plugins:"
    echo "  1. Start tmux"
    echo "  2. Press: Ctrl+s then Shift+i (Note: prefix is Ctrl+s, not Ctrl+b)"
fi

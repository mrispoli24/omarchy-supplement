#!/bin/bash
# Install lazygit TUI for git

echo "Installing lazygit..."
yay -S --noconfirm --needed lazygit

if command -v lazygit &>/dev/null; then
    echo "✓ lazygit installed successfully"
else
    echo "✗ lazygit installation failed"
    exit 1
fi

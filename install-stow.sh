#!/bin/bash
# Install GNU Stow for dotfiles management

echo "Installing GNU Stow..."
yay -S --noconfirm --needed stow

if command -v stow &>/dev/null; then
    echo "✓ GNU Stow installed successfully"
else
    echo "✗ GNU Stow installation failed"
    exit 1
fi

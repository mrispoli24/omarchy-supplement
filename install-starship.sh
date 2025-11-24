#!/bin/bash
# Install Starship prompt

echo "Installing starship..."
yay -S --noconfirm --needed starship

if command -v starship &>/dev/null; then
    echo "✓ starship installed successfully"
else
    echo "✗ starship installation failed"
    exit 1
fi

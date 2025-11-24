#!/bin/bash
# Install Waybar status bar

echo "Installing waybar..."
yay -S --noconfirm --needed waybar

if command -v waybar &>/dev/null; then
    echo "✓ waybar installed successfully"
else
    echo "✗ waybar installation failed"
    exit 1
fi

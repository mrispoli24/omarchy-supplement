#!/bin/bash
# Install Ghostty terminal emulator

echo "Installing Ghostty..."
yay -S --noconfirm --needed ghostty

if command -v ghostty &>/dev/null; then
    echo "✓ Ghostty installed successfully"
else
    echo "✗ Ghostty installation failed"
    exit 1
fi

#!/bin/bash
# Install Simple Scan (scanner utility)

echo "Installing Simple Scan..."
yay -S --noconfirm --needed simple-scan

if command -v simple-scan &>/dev/null; then
    echo "✓ Simple Scan installed successfully"
else
    echo "✗ Simple Scan installation failed"
    exit 1
fi

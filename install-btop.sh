#!/bin/bash
# Install btop system monitor

echo "Installing btop..."
yay -S --noconfirm --needed btop

if command -v btop &>/dev/null; then
    echo "✓ btop installed successfully"
else
    echo "✗ btop installation failed"
    exit 1
fi

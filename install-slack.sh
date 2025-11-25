#!/bin/bash
# Install Slack Desktop

echo "Installing Slack Desktop..."
yay -S --noconfirm --needed slack-desktop

if command -v slack &>/dev/null; then
    echo "✓ Slack Desktop installed successfully"
else
    echo "✗ Slack Desktop installation failed"
    exit 1
fi

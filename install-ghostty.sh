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

# Set Ghostty as default terminal
XDG_TERMINALS_FILE="$HOME/.config/xdg-terminals.list"
if grep -q "com.mitchellh.ghostty.desktop" "$XDG_TERMINALS_FILE" 2>/dev/null; then
    echo "✓ Ghostty already set as default terminal"
else
    echo "Setting Ghostty as default terminal..."
    mkdir -p "$HOME/.config"
    cat > "$XDG_TERMINALS_FILE" << 'EOF'
# Terminal emulator preference order for xdg-terminal-exec
# The first found and valid terminal will be used
com.mitchellh.ghostty.desktop
EOF
    echo "✓ Ghostty set as default terminal"
fi

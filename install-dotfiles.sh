#!/bin/bash
# Clone and stow dotfiles

set -e

# Check if stow is installed
if ! command -v stow &>/dev/null; then
    echo "✗ Error: GNU Stow is not installed"
    echo "  Run: ./install-stow.sh first"
    exit 1
fi

REPO_URL="https://github.com/mrispoli24/dotfiles.git"
REPO_DIR="$HOME/dotfiles"

echo "Setting up dotfiles..."

# Clone repository if it doesn't exist
if [ ! -d "$REPO_DIR" ]; then
    echo "Cloning dotfiles repository..."
    cd "$HOME"
    git clone "$REPO_URL" "$REPO_DIR"
    echo "✓ Repository cloned"

    # Remove conflicting default configs
    echo "Removing default configs..."
    rm -f ~/.bashrc ~/.bashrc.backup 2>/dev/null || true
    rm -rf ~/.config/nvim 2>/dev/null || true
    rm -rf ~/.config/tmux 2>/dev/null || true
    rm -f ~/.config/starship.toml 2>/dev/null || true
    rm -rf ~/.config/ghostty 2>/dev/null || true
    rm -rf ~/.config/lazygit 2>/dev/null || true
    rm -rf ~/.config/btop 2>/dev/null || true
    rm -rf ~/.config/waybar 2>/dev/null || true
    # Note: Not removing ~/.config/hypr as it contains machine-specific files

    echo "✓ Default configs removed"
else
    echo "✓ Repository already exists at $REPO_DIR"
    echo "  Pulling latest changes..."
    cd "$REPO_DIR"
    git pull || echo "  (Could not pull, continuing anyway)"
fi

# Stow all packages
echo "Stowing dotfiles..."
cd "$REPO_DIR"

# List of packages to stow
PACKAGES="bash nvim tmux git starship ghostty lazygit btop waybar hypr"

for package in $PACKAGES; do
    if [ -d "$package" ]; then
        echo "  Stowing $package..."
        stow "$package"
    else
        echo "  ⚠ Package $package not found, skipping"
    fi
done

echo "✓ Dotfiles stowed successfully"
echo ""
echo "Next steps:"
echo "  1. Start tmux and press Ctrl+b then Shift+i to install plugins"
echo "  2. Launch nvim to auto-install plugins"
echo "  3. Configure machine-specific files in ~/.config/hypr/"
echo "     (monitors.conf, hypridle.conf, etc.)"

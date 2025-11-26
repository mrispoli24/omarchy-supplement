#!/bin/bash
# Clone and stow dotfiles

set -e

# Check if stow is installed
if ! command -v stow &>/dev/null; then
    echo "✗ Error: GNU Stow is not installed"
    echo "  Run: ./install-stow.sh first"
    exit 1
fi

REPO_URL="git@github.com:mrispoli24/dotfiles.git"
REPO_DIR="$HOME/dotfiles"

echo "Setting up dotfiles..."

# Clone repository if it doesn't exist
if [ ! -d "$REPO_DIR" ]; then
    echo "Cloning dotfiles repository..."
    cd "$HOME"
    git clone "$REPO_URL" "$REPO_DIR"
    echo "✓ Repository cloned"
else
    echo "✓ Repository already exists at $REPO_DIR"
    echo "  Pulling latest changes..."
    cd "$REPO_DIR"
    git pull || echo "  (Could not pull, continuing anyway)"
fi

# Remove non-symlink files that would conflict with stow
# (symlinks to dotfiles repo are fine, regular files need to be removed)
remove_if_not_symlink() {
    local target="$1"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "  Removing conflicting file: $target"
        rm -rf "$target"
    fi
}

echo "Checking for conflicting configs..."
remove_if_not_symlink ~/.bashrc
remove_if_not_symlink ~/.bashrc.backup
remove_if_not_symlink ~/.config/nvim
remove_if_not_symlink ~/.config/tmux
remove_if_not_symlink ~/.config/git
remove_if_not_symlink ~/.config/starship.toml
remove_if_not_symlink ~/.config/ghostty
remove_if_not_symlink ~/.config/lazygit
remove_if_not_symlink ~/.config/btop
remove_if_not_symlink ~/.config/waybar
# Selectively check only hypr files that should be stowed (not machine-specific ones)
remove_if_not_symlink ~/.config/hypr/bindings.conf
remove_if_not_symlink ~/.config/hypr/hyprland.conf
remove_if_not_symlink ~/.config/hypr/input.conf
remove_if_not_symlink ~/.config/hypr/looknfeel.conf

# Stow all packages
echo "Stowing dotfiles..."
cd "$REPO_DIR"

# List of packages to stow
PACKAGES="bash nvim tmux git starship ghostty lazygit btop waybar hypr"

for package in $PACKAGES; do
    if [ -d "$package" ]; then
        echo "  Stowing $package..."
        stow --restow "$package"
    else
        echo "  ⚠ Package $package not found, skipping"
    fi
done

echo "✓ Dotfiles stowed successfully"

# Reload Hyprland to pick up config changes
if command -v hyprctl &>/dev/null; then
    echo "Reloading Hyprland..."
    hyprctl reload && echo "✓ Hyprland reloaded" || echo "  (Could not reload Hyprland, may not be running)"
fi

echo ""
echo "Next steps:"
echo "  1. Start tmux and press Ctrl+s then Shift+i to install plugins (Note: prefix is Ctrl+s)"
echo "  2. Launch nvim to auto-install plugins"
echo "  3. Configure machine-specific files in ~/.config/hypr/"
echo "     (monitors.conf, hypridle.conf, etc.)"

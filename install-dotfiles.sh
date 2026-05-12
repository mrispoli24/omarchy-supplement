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

# Move non-symlink files that would conflict with stow.
# Symlinks to the dotfiles repo are fine; regular files are backed up.
backup_if_not_symlink() {
    local target="$1"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        local backup="$target.backup.$(date +%Y%m%d%H%M%S)"
        echo "  Backing up conflicting path: $target -> $backup"
        mv "$target" "$backup"
    fi
}

echo "Checking for conflicting configs..."
backup_if_not_symlink ~/.bashrc
backup_if_not_symlink ~/.bashrc.backup
backup_if_not_symlink ~/.config/nvim
backup_if_not_symlink ~/.config/tmux
backup_if_not_symlink ~/.config/git
backup_if_not_symlink ~/.config/starship.toml
backup_if_not_symlink ~/.config/ghostty
backup_if_not_symlink ~/.config/lazygit
backup_if_not_symlink ~/.config/btop
backup_if_not_symlink ~/.config/waybar
# Selectively check only hypr files that should be stowed (not machine-specific ones)
backup_if_not_symlink ~/.config/hypr/bindings.conf
backup_if_not_symlink ~/.config/hypr/hyprland.conf
backup_if_not_symlink ~/.config/hypr/input.conf
backup_if_not_symlink ~/.config/hypr/looknfeel.conf

# Stow all packages
echo "Stowing dotfiles..."
cd "$REPO_DIR"

# List of packages to stow
PACKAGES="bash nvim tmux git starship ghostty lazygit btop waybar hypr bin"

for package in $PACKAGES; do
    if [ -d "$package" ]; then
        echo "  Stowing $package..."
        stow --restow "$package"
    else
        echo "  ⚠ Package $package not found, skipping"
    fi
done

echo "✓ Dotfiles stowed successfully"

# Run the audit after Omarchy updates when no custom post-update hook exists.
HOOK_DIR="$HOME/.config/omarchy/hooks"
HOOK_PATH="$HOOK_DIR/post-update"
mkdir -p "$HOOK_DIR"

if [ ! -e "$HOOK_PATH" ]; then
    echo "Installing Omarchy post-update dotfiles audit hook..."
    ln -s "$HOME/.local/bin/omarchy-dotfiles-audit" "$HOOK_PATH"
elif [ -L "$HOOK_PATH" ]; then
    echo "✓ Omarchy post-update hook already exists as a symlink"
else
    echo "  Omarchy post-update hook already exists; leaving it unchanged"
    echo "  To add the audit manually, run: omarchy-dotfiles-audit"
fi

if command -v omarchy-dotfiles-audit &>/dev/null; then
    echo "Running dotfiles audit..."
    omarchy-dotfiles-audit || echo "  Audit reported warnings or failures; review output above"
fi

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

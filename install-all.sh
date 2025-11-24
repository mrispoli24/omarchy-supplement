#!/bin/bash
# Master installation script - runs all installations in order

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "========================================"
echo "  Omarchy Supplement Installation"
echo "========================================"
echo ""
echo "This will install:"
echo "  - Ghostty terminal"
echo "  - tmux + TPM"
echo "  - btop system monitor"
echo "  - lazygit TUI"
echo "  - Waybar status bar"
echo "  - Starship prompt"
echo "  - GNU Stow"
echo "  - Your dotfiles from GitHub"
echo ""
read -p "Continue? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Installation cancelled"
    exit 0
fi

echo ""
echo "========================================"
echo "Step 1/8: Installing Ghostty..."
echo "========================================"
bash "$SCRIPT_DIR/install-ghostty.sh"

echo ""
echo "========================================"
echo "Step 2/8: Installing tmux..."
echo "========================================"
bash "$SCRIPT_DIR/install-tmux.sh"

echo ""
echo "========================================"
echo "Step 3/8: Installing btop..."
echo "========================================"
bash "$SCRIPT_DIR/install-btop.sh"

echo ""
echo "========================================"
echo "Step 4/8: Installing lazygit..."
echo "========================================"
bash "$SCRIPT_DIR/install-lazygit.sh"

echo ""
echo "========================================"
echo "Step 5/8: Installing Waybar..."
echo "========================================"
bash "$SCRIPT_DIR/install-waybar.sh"

echo ""
echo "========================================"
echo "Step 6/8: Installing Starship..."
echo "========================================"
bash "$SCRIPT_DIR/install-starship.sh"

echo ""
echo "========================================"
echo "Step 7/8: Installing GNU Stow..."
echo "========================================"
bash "$SCRIPT_DIR/install-stow.sh"

echo ""
echo "========================================"
echo "Step 8/8: Installing dotfiles..."
echo "========================================"
bash "$SCRIPT_DIR/install-dotfiles.sh"

echo ""
echo "========================================"
echo "  Installation Complete!"
echo "========================================"
echo ""
echo "Next steps:"
echo "  1. Restart your shell or run: source ~/.bashrc"
echo "  2. Start tmux and press Ctrl+b then Shift+i to install plugins"
echo "  3. Launch nvim to auto-install plugins"
echo "  4. Configure machine-specific Hyprland settings:"
echo "     - Edit ~/.config/hypr/monitors.conf"
echo "     - Edit ~/.config/hypr/hypridle.conf"
echo "     - Edit ~/.config/hypr/autostart.conf"
echo "  5. Reload Hyprland: hyprctl reload"
echo ""
echo "Optional:"
echo "  - Install mise-en-place via omarchy installer for language runtimes"
echo ""

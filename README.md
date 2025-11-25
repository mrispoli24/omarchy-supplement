# Omarchy Supplement

Personal dotfiles installer and configuration supplements for Omarchy Linux.

## What This Installs

This repository provides automated installation scripts for:

- **Ghostty** - Modern terminal emulator (Omarchy default)
- **tmux** - Terminal multiplexer with TPM plugin manager
- **btop** - System monitor
- **lazygit** - Git TUI
- **Waybar** - Status bar
- **Starship** - Cross-shell prompt
- **Slack Desktop** - Team communication
- **Simple Scan** - Scanner utility
- **GNU Stow** - Dotfiles symlink manager
- **Personal dotfiles** - Your configurations from [mrispoli24/dotfiles](https://github.com/mrispoli24/dotfiles)

## Quick Start

### One Command Installation

```bash
git clone https://github.com/YOUR_USERNAME/omarchy-supplement.git
cd omarchy-supplement
chmod +x *.sh
./install-all.sh
```

This will:
1. Install all required packages
2. Clone your dotfiles repository
3. Create symlinks using GNU Stow
4. Set up tmux plugin manager

### Individual Script Installation

Run scripts individually if you only need specific components:

```bash
# Make scripts executable
chmod +x *.sh

# Install individual components
./install-ghostty.sh
./install-tmux.sh
./install-btop.sh
./install-lazygit.sh
./install-waybar.sh
./install-starship.sh
./install-slack.sh
./install-simple-scan.sh
./install-stow.sh
./install-dotfiles.sh
```

## Post-Installation

### 1. Install Tmux Plugins

```bash
# Start tmux
tmux

# Press: Ctrl+b then Shift+i
# TPM will install all plugins defined in your tmux.conf
```

### 2. Install Neovim Plugins

```bash
# Launch nvim
nvim

# lazy.nvim will automatically install plugins on first launch
```

### 3. Configure Machine-Specific Settings

Your dotfiles use GNU Stow with `.stow-local-ignore` for machine-specific files. Configure these for your machine:

```bash
# Edit Hyprland monitor configuration
nvim ~/.config/hypr/monitors.conf

# Edit idle/lock settings (different for laptop vs desktop)
nvim ~/.config/hypr/hypridle.conf
nvim ~/.config/hypr/hyprlock.conf

# Edit autostart applications
nvim ~/.config/hypr/autostart.conf

# Reload Hyprland
hyprctl reload
```

### 4. Reload Your Shell

```bash
source ~/.bashrc
```

## What Gets Synced vs What Doesn't

### Synced Across Machines (via dotfiles)
- Shell configuration (.bashrc)
- Editor config (Neovim)
- Tmux configuration
- Git configuration
- Starship prompt config
- Ghostty terminal config
- Lazygit config
- Btop themes
- Waybar config
- Hyprland keybindings, input, looknfeel

### Machine-Specific (Not Synced)
- Monitor configurations (`monitors.conf`)
- Idle/lock timeouts (`hypridle.conf`, `hyprlock.conf`)
- Autostart applications (`autostart.conf`)
- Environment variables (`envs.conf`)
- Blue light filter settings (`hyprsunset.conf`)
- Plugin installations (auto-installed via TPM and lazy.nvim)

## Optional: Install Language Runtimes

This supplement doesn't install programming language runtimes. To add those:

### Option 1: Use Omarchy Installer (Recommended)
```bash
# Run omarchy's installer and select mise-en-place
# This ensures proper integration with omarchy's hooks
```

### Option 2: Manual Installation
```bash
# Install mise-en-place
curl https://mise.run | sh

# Add to your shell config (already in dotfiles if configured)
echo 'eval "$(mise activate bash)"' >> ~/.bashrc
```

## Repository Structure

```
omarchy-supplement/
├── README.md                 # This file
├── install-all.sh           # Master installation script
├── install-ghostty.sh       # Install Ghostty terminal
├── install-tmux.sh          # Install tmux + TPM
├── install-btop.sh          # Install btop system monitor
├── install-lazygit.sh       # Install lazygit TUI
├── install-waybar.sh        # Install Waybar status bar
├── install-starship.sh      # Install Starship prompt
├── install-slack.sh         # Install Slack Desktop
├── install-simple-scan.sh   # Install Simple Scan
├── install-stow.sh          # Install GNU Stow
└── install-dotfiles.sh      # Clone and stow dotfiles
```

## How It Works

This supplement uses the same pattern as [typecraft-dev/omarchy-supplement](https://github.com/typecraft-dev/omarchy-supplement):

1. **Modular Scripts** - Each component has its own installation script
2. **Idempotent** - Safe to run multiple times, checks if already installed
3. **Arch-Specific** - Uses `yay` package manager with `--noconfirm --needed` flags
4. **Orchestration** - `install-all.sh` runs everything in the correct order
5. **Defensive** - Installs tools even if they're Omarchy defaults (in case defaults change)

## Troubleshooting

### Scripts Not Executable
```bash
chmod +x *.sh
```

### Stow Conflicts
If stow reports conflicts:
```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup

# Re-run install-dotfiles.sh
./install-dotfiles.sh
```

### Git Clone Fails (SSH)
If using SSH keys that aren't set up yet, the installer uses HTTPS. After setup, you can switch to SSH:
```bash
cd ~/dotfiles
git remote set-url origin git@github.com:mrispoli24/dotfiles.git
```

### Hyprland Keybindings Not Working
```bash
# Reload Hyprland config
hyprctl reload
```

### Tmux Plugins Not Loading
```bash
# Make sure TPM is installed
ls ~/.config/tmux/plugins/tpm

# Install plugins: Ctrl+b then Shift+i
```

## Updating Dotfiles

After making changes on any machine:

```bash
cd ~/dotfiles
git add .
git commit -m "Update configs"
git push
```

On other machines:
```bash
cd ~/dotfiles
git pull
# Changes are immediately active (configs are symlinked)
```

## Credits

- Inspired by [typecraft-dev/omarchy-supplement](https://github.com/typecraft-dev/omarchy-supplement)
- Built for [Omarchy](https://github.com/basecamp/omarchy) by DHH
- Uses [GNU Stow](https://www.gnu.org/software/stow/) for dotfiles management

## License

MIT - Feel free to fork and customize for your own setup!

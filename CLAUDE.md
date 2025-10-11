# CLAUDE.md - Project Context for AI Assistance

## Project Overview

**omagnome** is an opinionated GNOME desktop environment configuration that combines GNOME's stability with tiling window management capabilities. The goal is to create a reproducible, efficient desktop setup optimized for productivity.

## Architecture

### Core Components

1. **Installation System** (`install.sh`)
   - Main orchestration script
   - Executes all `gnome/*.sh` scripts for GNOME configuration
   - Executes all `extensions/*.sh` scripts for extension installation
   - Executes `ui/install.sh` for theme and icon installation

2. **GNOME Configuration** (`gnome/`)
   - `shortcuts.sh`: Systematically removes all default GNOME keybindings
   - Clears keybindings across multiple schemas:
     - `org.gnome.desktop.wm.keybindings` (window management)
     - `org.gnome.shell.keybindings` (shell operations)
     - `org.gnome.settings-daemon.plugins.media-keys` (media keys)
     - `org.gnome.mutter.keybindings` (tiling shortcuts)
   - `workspaces.sh`: Configures 5 static workspaces

3. **Extensions** (`extensions/`)
   - Each script installs and configures a specific GNOME extension
   - Uses GNOME Extensions D-Bus API for installation
   - Includes idempotency checks to avoid reinstalling
   - Current extensions:
     - `forge.sh`: Tiling window management with custom keybindings
     - `spacebar.sh`: Workspace management bar
     - `blur-my-shell.sh`: UI blur effects for panel and dock
     - `dim-background-windows.sh`: Dims unfocused windows

4. **UI Theme System** (`ui/`)
   - `install.sh`: Orchestrates theme installation
   - Uses git submodules for theme repositories:
     - Fluent GTK theme (vinceliuice/Fluent-gtk-theme)
     - Qogir icon theme (vinceliuice/Qogir-icon-theme)
   - Automatically applies themes via gsettings

## Known Issues

### To Implement
- Additional extension installations (as needed)
- Custom keybinding configuration beyond Forge defaults
- Extension updates/maintenance automation

## Development Guidelines

### Adding New GNOME Settings
1. Create a new script in `gnome/` directory
2. Use `gsettings set` commands for configuration
3. Include echo statements for user feedback
4. Script will be auto-executed by `install.sh`

### Managing Keyboard Shortcuts
**IMPORTANT**: Whenever you add, remove, or update keyboard shortcuts:
1. Update the shortcuts in the relevant configuration file (`gnome/shortcuts.sh` or `extensions/*.sh`)
2. **ALWAYS** update the "Keyboard Shortcuts" section in `README.md` to reflect the changes
3. Keep the README shortcut list organized by category (General, Forge Tiling, etc.)
4. Use clear, descriptive labels for each shortcut

### Adding New Extensions
1. Create a new script in `extensions/` directory
2. Follow the pattern from existing extension scripts:
   - Check if extension is already installed
   - Use D-Bus API to install: `gdbus call --session --dest org.gnome.Shell.Extensions ...`
   - Enable with `gnome-extensions enable UUID`
   - Optionally configure settings with `dconf write` commands
3. Include proper error handling and user feedback

### Extension Installation via D-Bus
```bash
gdbus call --session \
    --dest org.gnome.Shell.Extensions \
    --object-path /org/gnome/Shell/Extensions \
    --method org.gnome.Shell.Extensions.InstallRemoteExtension \
    "EXTENSION_UUID"
```

## Common Tasks

### Testing Changes
```bash
# Test individual scripts
bash gnome/shortcuts.sh
bash extensions/spacebar.sh

# Full installation test
./install.sh
```

### Checking Current Settings
```bash
# View current keybindings
gsettings list-recursively org.gnome.desktop.wm.keybindings

# List installed extensions
gnome-extensions list

# Check extension status
gnome-extensions info EXTENSION_UUID
```

### Adding New Extensions
To add a new extension:
1. Create `extensions/extension-name.sh`
2. Find the extension UUID from extensions.gnome.org
3. Follow the pattern from existing extension scripts for installation

## Technologies & Dependencies

- **Shell**: Bash scripting for automation
- **GNOME Settings**: `gsettings` and `dconf` (part of GLib)
- **Extension Management**: `gnome-extensions` CLI, D-Bus
- **Desktop Environment**: GNOME Shell 40+
- **Theme Tools**: `sass` for GTK theme compilation
- **Version Control**: Git with submodules for theme management

## File Locations

- Extension installation location: `~/.local/share/gnome-shell/extensions/`
- GNOME settings: dconf database (`~/.config/dconf/user`)
- System extension directory: `/usr/share/gnome-shell/extensions/`
- GTK themes: `~/.themes/` or `~/.local/share/themes/`
- Icon themes: `~/.icons/` or `~/.local/share/icons/`

## Useful Commands for Development

```bash
# Reset all GNOME settings to defaults
dconf reset -f /org/gnome/

# Monitor D-Bus session for debugging
dbus-monitor --session

# Reload GNOME Shell (X11 only)
Alt+F2, then type 'r'

# Restart GNOME Shell (Wayland)
# Log out and log back in

# Export current settings
dconf dump /org/gnome/ > current-settings.dconf

# View extension errors
journalctl -f /usr/bin/gnome-shell
```

## Future Enhancements

1. **Additional Extensions**: Continue adding curated extensions as needed
2. **Custom Keybindings**: Add script to set up additional keybindings beyond Forge defaults
3. **Backup/Restore**: Export current settings before installation
4. **Rollback Capability**: Save previous settings for easy restoration
5. **Validation**: Pre-flight checks for GNOME version compatibility
6. **Extension Updates**: Automation for keeping extensions up to date

## Quick Reference

### What This Project Does
- Removes ALL default GNOME keybindings (clean slate approach)
- Installs and configures curated GNOME extensions:
  - Forge (tiling window management with custom keybindings)
  - Space Bar (workspace management)
  - Blur my Shell (UI blur effects)
  - Dim Background Windows (focus enhancement)
- Installs and applies Fluent GTK theme (light variant)
- Installs and applies Qogir icon theme
- Configures 5 static workspaces
- Provides framework for reproducible GNOME setup

### What This Project Will Do (Future)
- Add more curated extensions as needed
- Configure additional keybindings beyond Forge defaults
- Provide backup/restore and rollback capabilities

### What Users May Want to Customize
- Number of static workspaces (currently 5)
- Forge keybindings (see extensions/forge.sh)
- Theme variants (currently Light, can change to Dark)
- Extension-specific settings
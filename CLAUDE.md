# CLAUDE.md - Project Context for AI Assistance

## Project Overview

**omagnome** is an opinionated GNOME desktop environment configuration that combines GNOME's stability with tiling window management capabilities. The goal is to create a reproducible, efficient desktop setup optimized for productivity.

## Architecture

### Core Components

1. **Installation System** (`install.sh`)
   - Main orchestration script
   - Executes all `gnome/*.sh` scripts for GNOME configuration
   - Executes all `extensions/*.sh` scripts for extension installation
   - Currently has a syntax error on line 21: missing semicolon after `extensions/*.sh`

2. **GNOME Configuration** (`gnome/`)
   - `shortcuts.sh`: Systematically removes all default GNOME keybindings
   - Clears keybindings across multiple schemas:
     - `org.gnome.desktop.wm.keybindings` (window management)
     - `org.gnome.shell.keybindings` (shell operations)
     - `org.gnome.settings-daemon.plugins.media-keys` (media keys)
     - `org.gnome.mutter.keybindings` (tiling shortcuts)

3. **Extensions** (`extensions/`)
   - Each script installs a specific GNOME extension
   - Uses GNOME Extensions D-Bus API for installation
   - Includes idempotency checks to avoid reinstalling
   - Example: `spacebar.sh` installs workspace management extension

## Known Issues

### Critical
- **install.sh:21** - Syntax error: `for extension in extensions/*.sh do` should be `for extension in extensions/*.sh; do`

### To Implement
- Additional extension installations
- Custom keybinding configuration scripts
- UI theme/styling configuration
- Extension configuration/settings automation

## Development Guidelines

### Adding New GNOME Settings
1. Create a new script in `gnome/` directory
2. Use `gsettings set` commands for configuration
3. Include echo statements for user feedback
4. Script will be auto-executed by `install.sh`

### Adding New Extensions
1. Create a new script in `extensions/` directory
2. Follow the pattern from `spacebar.sh`:
   - Check if extension is already installed
   - Use D-Bus API to install: `gdbus call --session --dest org.gnome.Shell.Extensions ...`
   - Enable with `gnome-extensions enable UUID`
3. Include proper error handling

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
- **GNOME Settings**: `gsettings` (part of GLib)
- **Extension Management**: `gnome-extensions` CLI, D-Bus
- **Desktop Environment**: GNOME Shell 40+

## File Locations

- Extension installation location: `~/.local/share/gnome-shell/extensions/`
- GNOME settings: dconf database (`~/.config/dconf/user`)
- System extension directory: `/usr/share/gnome-shell/extensions/`

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

1. **Additional Extensions**: Continue adding curated extensions
2. **Custom Keybindings**: Add script to set up preferred keybindings after clearing defaults
3. **Theme Configuration**: UI/GTK theme setup
4. **Backup/Restore**: Export current settings before installation
5. **Rollback Capability**: Save previous settings for easy restoration
6. **Extension Configuration**: Configure extension settings, not just install them
7. **Validation**: Pre-flight checks for GNOME version compatibility

## Quick Reference

### What This Project Does
- Removes ALL default GNOME keybindings (clean slate approach)
- Installs curated GNOME extensions for enhanced functionality
- Provides framework for reproducible GNOME setup

### What This Project Will Do
- Add more curated extensions
- Configure custom keybindings optimized for productivity
- Apply UI theme and styling
- Configure installed extensions

### What Users Should Do Manually (Currently)
- Configure custom keybindings
- Set up UI themes
- Configure extension preferences
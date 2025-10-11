# omagnome

An opinionated GNOME desktop setup featuring lightweight tiling window management (Forge), custom keybindings, and UI enhancements for a consistent, productive experience.

<img width="5120" height="2880" alt="Screenshot From 2025-10-11 11-57-06" src="https://github.com/user-attachments/assets/fced7185-5383-4432-bc14-474529f6ba59" />

## Features

- **Tiling Window Management**: Lightweight tiling capabilities via [Forge](https://extensions.gnome.org/extension/4481/forge/)
- **UI Enhancements**:
  - [Blur my Shell](https://extensions.gnome.org/extension/3193/blur-my-shell/) - Blurred panel and UI elements
  - [Dim Background Windows](https://extensions.gnome.org/extension/6313/dim-background-windows/) - Dimmed unfocused windows
  - [Space Bar](https://extensions.gnome.org/extension/5090/space-bar/) - Workspace management
- **Modern Theme**: Fluent GTK theme with Qogir icons for a polished look
- **Clean Keybindings**: Removes default GNOME shortcuts to provide a clean slate for custom bindings
- **Automated Setup**: Single script installation for reproducible desktop environment

## Keyboard Shortcuts

### General
- `Super + Tab` - Switch between applications
- `Shift + Super + Tab` - Switch between applications (reverse)
- `Super + Q` - Close/quit active window
- `Print` - Open screenshot/screencast UI

### Forge Tiling (Window Focus)
- `Super + ↑/↓/←/→` - Focus window in direction

### Forge Tiling (Window Movement)
- `Shift + Super + ↑/↓/←/→` - Move window in direction
- `Ctrl + Super + ↑/↓/←/→` - Swap window with another in direction
- `Super + Return` - Swap with last active window

### Forge Tiling (Window Resizing)
- `Alt + Super + ↑/↓/←/→` - Increase window size in direction
- `Shift + Alt + Super + ↑/↓/←/→` - Decrease window size in direction

### Forge Tiling (Window Snapping)
- `Shift + Super + Return` - Snap window to center
- `Shift + Super + H` - Snap window to left 2/3
- `Shift + Super + L` - Snap window to right 2/3
- `Shift + Super + J` - Snap window to left 1/3
- `Shift + Super + K` - Snap window to right 1/3

### Forge Tiling (Layouts & Modes)
- `Super + W` - Toggle tiling mode
- `Shift + Super + W` - Toggle tiling for active workspace
- `Super + C` - Toggle floating mode for window
- `Shift + Super + C` - Toggle always-float for window
- `Super + Z` - Split horizontal
- `Super + V` - Split vertical
- `Super + X` - Toggle split layout

## Installation

```bash
./install.sh
```

This will:
1. Configure GNOME settings and remove default keybindings
2. Install and enable curated extensions

## Requirements

- GNOME Desktop Environment
- `gsettings` command (pre-installed on most GNOME systems)
- `gnome-extensions` CLI tool
- `gnome-shell-extensions` package (for extension installation via D-Bus)
- `sass` (for compiling GTK themes)
- D-Bus session bus access

## Credits

- [Fluent GTK Theme](https://github.com/vinceliuice/Fluent-gtk-theme) by [vinceliuice](https://github.com/vinceliuice)
- [Qogir Icon Theme](https://github.com/vinceliuice/Qogir-icon-theme) by [vinceliuice](https://github.com/vinceliuice)

## License

See [LICENSE](LICENSE) file for details.

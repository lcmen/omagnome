# omagnome

An opinionated GNOME desktop setup featuring lightweight tiling window management (Forge), custom keybindings, and UI enhancements for a consistent, productive experience.

<img width="5120" height="2880" alt="Screenshot From 2025-11-02 19-31-25" src="https://github.com/user-attachments/assets/8b3d906c-ecec-4350-a275-fa752d8b6d2f" />

## Features

- **Tiling Window Management**: Lightweight tiling capabilities via [Forge](https://extensions.gnome.org/extension/4481/forge/)
- **UI Enhancements**:
  - **Dark Top Bar** - A minimal local extension that keeps only the top bar dark with GNOME Shell's Light Style
  - [Dim Background Windows](https://extensions.gnome.org/extension/6313/dim-background-windows/) - Dimmed unfocused windows
  - [Space Bar](https://extensions.gnome.org/extension/5090/space-bar/) - Workspace management
  - [Freon](https://extensions.gnome.org/extension/841/freon/) - System temperature and sensor monitoring
  - [No overview at start-up](https://extensions.gnome.org/extension/4099/no-overview/) - Keeps GNOME out of Overview after login
  - [ArcMenu](https://extensions.gnome.org/extension/3628/arcmenu/) - Keyboard-driven application launcher using its standalone Runner
  - [GNOME Fuzzy App Search](https://extensions.gnome.org/extension/3956/gnome-fuzzy-app-search/) - Fuzzy application matching for GNOME search
- **Modern Theme**: Default libadwaita styling, an adw-gtk3 compatibility theme, small GTK tweaks, and Qogir icons
- **Clean Keybindings**: Removes default GNOME shortcuts to provide a clean slate for custom bindings
- **Automated Setup**: Single script installation for reproducible desktop environment

## Keyboard Shortcuts

### General
- `Super + Tab` - Switch between applications
- `Shift + Super + Tab` - Switch between applications (reverse)
- `Super + Q` - Close/quit active window
- `Print` - Open screenshot/screencast UI

### Workspaces
- `Super + 1…9` - Switch directly to workspace 1…9
- `Super + 0` - Switch directly to workspace 10
- `Shift + Super + 1…9` - Move active window to workspace 1…9
- `Shift + Super + 0` - Move active window to workspace 10

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

### Forge Tiling (Layouts & Modes)
- `Super + W` - Toggle tiling mode
- `Shift + Super + W` - Toggle tiling for active workspace
- `Super + F` - Toggle floating mode for window
- `Shift + Super + F` - Toggle always-float for window
- `Super + Space` - Open ArcMenu Runner
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
3. Install and configure ArcMenu Runner and fuzzy application search

## Requirements

- GNOME Desktop Environment
- `gsettings` command (pre-installed on most GNOME systems)
- `gnome-extensions` CLI tool
- `gnome-shell-extensions` package (for extension installation via D-Bus)
- `adw-gtk3-theme` (Fedora package for libadwaita-style GTK 3 applications)
- `curl`, `unzip`, and `git` (for installing fonts and UI assets)
- D-Bus session bus access

## Credits

- [adw-gtk3](https://github.com/lassekongo83/adw-gtk3) by [lassekongo83](https://github.com/lassekongo83)
- [Qogir Icon Theme](https://github.com/vinceliuice/Qogir-icon-theme) by [vinceliuice](https://github.com/vinceliuice)

## License

See [LICENSE](LICENSE) file for details.

# omagnome

An opinionated GNOME desktop setup featuring lightweight tiling window management (Forge), custom keybindings, and UI enhancements for a consistent, productive experience.

## Features

- **Tiling Window Management**: Lightweight tiling capabilities on top of GNOME
- **Clean Keybindings**: Removes default GNOME shortcuts to provide a clean slate for custom bindings
- **Curated Extensions**: Carefully selected GNOME extensions for enhanced functionality
- **Automated Setup**: Single script installation for reproducible desktop environment

## Installation

```bash
./install.sh
```

This will:
1. Configure GNOME settings and remove default keybindings
2. Install and enable curated extensions

## Project Structure

```
omagnome/
├── install.sh              # Main installation script
├── gnome/
│   └── shortcuts.sh        # Removes default GNOME keybindings
└── extensions/             # GNOME extension installation scripts
    └── *.sh                # Individual extension installers
```

## Requirements

- GNOME Desktop Environment
- `gsettings` command (pre-installed on most GNOME systems)
- `gnome-extensions` CLI tool
- `gnome-shell-extensions` package (for extension installation via D-Bus)
- `sass` (for compiling GTK themes)
- D-Bus session bus access

## License

See [LICENSE](LICENSE) file for details.

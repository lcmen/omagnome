# omagnome

An opinionated GNOME desktop setup featuring lightweight tiling window management (Forge), custom keybindings, and UI enhancements for a consistent, productive experience.

<img width="5120" height="2880" alt="Screenshot from 2025-10-10 20-35-06" src="https://github.com/user-attachments/assets/1963aa1e-dd51-4024-b360-4e1a73df9591" />

## Features

- **Tiling Window Management**: Lightweight tiling capabilities via [Forge](https://extensions.gnome.org/extension/4481/forge/)
- **UI Enhancements**:
  - [Blur my Shell](https://extensions.gnome.org/extension/3193/blur-my-shell/) - Blurred panel and UI elements
  - [Dim Background Windows](https://extensions.gnome.org/extension/6313/dim-background-windows/) - Dimmed unfocused windows
  - [Space Bar](https://extensions.gnome.org/extension/5090/space-bar/) - Workspace management
- **Modern Theme**: Fluent GTK theme with Qogir icons for a polished look
- **Clean Keybindings**: Removes default GNOME shortcuts to provide a clean slate for custom bindings
- **Automated Setup**: Single script installation for reproducible desktop environment

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

#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "[omagnome]  Setting up UI themes and icons..."

if ! rpm -q adw-gtk3-theme > /dev/null 2>&1; then
    echo "[omagnome]  Error: adw-gtk3-theme is required for GTK 3 applications." >&2
    echo "[omagnome]  Install it on Fedora with: sudo dnf install adw-gtk3-theme" >&2
    exit 1
fi

# Check if submodules are already added
if [ ! -d "$SCRIPT_DIR/Qogir-icon-theme" ]; then
    echo "[omagnome]  Adding Qogir icon theme as submodule..."
    git submodule add https://github.com/vinceliuice/Qogir-icon-theme ui/Qogir-icon-theme > /dev/null 2>&1
fi

# Initialize and update all submodules
echo "[omagnome]  Updating UI submodules..."
git submodule update --init --recursive --remote ui/Qogir-icon-theme > /dev/null 2>&1

echo "[omagnome]  Installing GTK customizations..."
install -Dm644 "$SCRIPT_DIR/gtk-3.0/gtk.css" "$HOME/.config/gtk-3.0/gtk.css"
install -Dm644 "$SCRIPT_DIR/gtk-4.0/gtk.css" "$HOME/.config/gtk-4.0/gtk.css"

# Install Qogir icon theme
echo "[omagnome]  Installing Qogir icon theme..."
cd "$SCRIPT_DIR/Qogir-icon-theme"
./install.sh -t default -c standard > /dev/null 2>&1

# Use Qogir's classic terminal icon for Ptyxis, Fedora's default terminal.
echo "[omagnome]  Applying classic terminal icon to Ptyxis..."
cp "$HOME/.local/share/icons/Qogir/scalable/apps/terminal.svg" \
    "$HOME/.local/share/icons/Qogir/scalable/apps/org.gnome.Ptyxis.svg"
gtk-update-icon-cache -f "$HOME/.local/share/icons/Qogir" > /dev/null

# Apply themes to GNOME
echo "[omagnome]  Preferring light application styles..."
gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'

echo "[omagnome]  Applying adw-gtk3 theme to GTK 3 applications..."
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'
gsettings reset org.gnome.shell.extensions.user-theme name 2> /dev/null || true

echo "[omagnome]  Applying Qogir icon theme to GNOME..."
gsettings set org.gnome.desktop.interface icon-theme 'Qogir'

echo "[omagnome]  Applying theme for Flatpak apps..."
flatpak override --user --filesystem=xdg-config/gtk-3.0:ro
flatpak override --user --filesystem=xdg-config/gtk-4.0:ro
flatpak override --user --filesystem="$HOME/.themes:ro"
flatpak override --user --filesystem="$HOME/.icons:ro"
flatpak override --user --unset-env=GTK_THEME
flatpak override --user --env=ICON_THEME=Qogir

echo "[omagnome]  Note: You may need to log out and log back in for all theme changes to take effect."

echo "[omagnome]  UI setup complete."

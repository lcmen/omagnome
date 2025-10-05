#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "[omagnome]  Setting up UI themes and icons..."

# Check if submodules are already added
if [ ! -d "$SCRIPT_DIR/Fluent-gtk-theme" ]; then
    echo "[omagnome]  Adding Fluent GTK theme as submodule..."
    git submodule add https://github.com/vinceliuice/Fluent-gtk-theme ui/Fluent-gtk-theme > /dev/null 2>&1
fi

if [ ! -d "$SCRIPT_DIR/Qogir-icon-theme" ]; then
    echo "[omagnome]  Adding Qogir icon theme as submodule..."
    git submodule add https://github.com/vinceliuice/Qogir-icon-theme ui/Qogir-icon-theme > /dev/null 2>&1
fi

# Initialize and update all submodules
echo "[omagnome]  Updating UI submodules..."
git submodule update --init --recursive --remote ui/Fluent-gtk-theme ui/Qogir-icon-theme > /dev/null 2>&1

# Install Fluent GTK theme
echo "[omagnome]  Installing Fluent GTK theme..."
cd "$SCRIPT_DIR/Fluent-gtk-theme"
./install.sh -t default -c light -s standard -l --tweaks float

# Install Qogir icon theme
echo "[omagnome]  Installing Qogir icon theme..."
cd "$SCRIPT_DIR/Qogir-icon-theme"
./install.sh -t default -c standard

# Apply themes to GNOME
echo "[omagnome]  Applying Fluent GTK theme to GNOME..."
gsettings set org.gnome.desktop.interface gtk-theme 'Fluent-Light'
gsettings set org.gnome.shell.extensions.user-theme name 'Fluent-Light'

echo "[omagnome]  Applying Qogir icon theme to GNOME..."
gsettings set org.gnome.desktop.interface icon-theme 'Qogir'

echo "[omagnome]  Note: You may need to log out and log back in for all theme changes to take effect."

echo "[omagnome]  UI setup complete."

#!/usr/bin/env bash

echo "Configuring GNOME settings..."

echo "  - Disabling mouse acceleration..."
gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'

echo "  - Disabling screen edge tiling..."
gsettings set org.gnome.desktop.wm.preferences edge-tiling false

echo "  - Disabling hot corners..."
gsettings set org.gnome.desktop.interface enable-hot-corners false

echo "  - Disabling auto-maximize (Forge will handle it)..."
gsettings set org.gnome.mutter auto-maximize false

echo "GNOME settings configured successfully!"

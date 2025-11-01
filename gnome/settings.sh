#!/usr/bin/env bash

echo "Configuring GNOME settings..."

# Disable mouse acceleration (use flat acceleration profile)
echo "  - Disabling mouse acceleration..."
gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'

# Disable screen edge tiling
echo "  - Disabling screen edge tiling..."
gsettings set org.gnome.desktop.wm.preferences edge-tiling false

# Disable hot corners
echo "  - Disabling hot corners..."
gsettings set org.gnome.desktop.interface enable-hot-corners false

echo "GNOME settings configured successfully!"
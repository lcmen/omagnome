#!/usr/bin/env bash

echo "Configuring GNOME settings..."

echo "  - Disabling mouse acceleration..."
gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'

echo "  - Disabling screen edge tiling..."
gsettings set org.gnome.mutter edge-tiling false

echo "  - Disabling hot corners..."
gsettings set org.gnome.desktop.interface enable-hot-corners false

echo "  - Disabling auto-maximize (Forge will handle it)..."
gsettings set org.gnome.mutter auto-maximize false

echo "  - Using Left Alt for Polish characters and Right Alt as normal Alt..."
gsettings set org.gnome.desktop.input-sources xkb-options "['lv3:lalt_switch', 'lv3:ralt_alt']"

echo "  - Setting Files to use double-click..."
gsettings set org.gnome.nautilus.preferences click-policy 'double'

echo "GNOME settings configured successfully!"

#!/usr/bin/env bash

set -e

echo "[omagnome]  Configuring UI preferences..."

# Hide minimize and maximize buttons on title bar (only show close button)
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:close'

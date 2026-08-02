#!/usr/bin/env bash

set -e

EXTENSION_UUID="dim-background-windows@stephane-13.github.com"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=extensions/utils.sh
source "$SCRIPT_DIR/utils.sh"
install_and_enable_extension "$EXTENSION_UUID" "Dim Background Windows"

printf "[omagnome]  Configuring Dim Background Windows settings: "

# Transparency and dimming settings
dconf write /org/gnome/shell/extensions/dim-background-windows/brightness 0.90
dconf write /org/gnome/shell/extensions/dim-background-windows/dimming-enabled true
dconf write /org/gnome/shell/extensions/dim-background-windows/toggle-shortcut "['<Super>g']"

printf "done.\n"

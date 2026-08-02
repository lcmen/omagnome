#!/usr/bin/env bash

set -e

EXTENSION_UUID="freon@UshakovVasilii_Github.yahoo.com"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=extensions/utils.sh
source "$SCRIPT_DIR/utils.sh"
install_and_enable_extension "$EXTENSION_UUID" "Freon"

printf "[omagnome]  Configuring Freon settings: "

# Sensor configuration
dconf write /org/gnome/shell/extensions/freon/hot-sensors "['Tccd1', 'edge']"

printf "done.\n"

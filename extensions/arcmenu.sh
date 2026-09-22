#!/usr/bin/env bash

set -e

EXTENSION_UUID="arcmenu@arcmenu.com"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXTENSION_SCHEMA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/gnome-shell/extensions/$EXTENSION_UUID/schemas"

source "$SCRIPT_DIR/utils.sh"

install_and_enable_extension "$EXTENSION_UUID" "ArcMenu"

gsettings --schemadir "$EXTENSION_SCHEMA_DIR" set org.gnome.shell.extensions.arcmenu arcmenu-hotkey "[]"
gsettings --schemadir "$EXTENSION_SCHEMA_DIR" set org.gnome.shell.extensions.arcmenu arcmenu-hotkey-overlay-key-enabled false
gsettings --schemadir "$EXTENSION_SCHEMA_DIR" set org.gnome.shell.extensions.arcmenu runner-hotkey "['<Super>space']"
gsettings --schemadir "$EXTENSION_SCHEMA_DIR" set org.gnome.shell.extensions.arcmenu runner-search-display-style 'List'

printf "[omagnome]  ArcMenu Runner is ready (Super+Space).\n"

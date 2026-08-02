#!/usr/bin/env bash

set -e

EXTENSION_UUID="user-theme@gnome-shell-extensions.gcampax.github.com"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=extensions/utils.sh
source "$SCRIPT_DIR/utils.sh"
install_and_enable_extension "$EXTENSION_UUID" "User Themes"

#!/usr/bin/env bash

set -e

EXTENSION_UUID="gnome-fuzzy-app-search@gnome-shell-extensions.Czarlie.gitlab.com"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/utils.sh"

install_and_enable_extension "$EXTENSION_UUID" "GNOME Fuzzy App Search"

#!/usr/bin/env bash

set -e

EXTENSION_UUID="space-bar@luchrioh"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=extensions/utils.sh
source "$SCRIPT_DIR/utils.sh"
install_and_enable_extension "$EXTENSION_UUID" "Space Bar"

printf "[omagnome]  Configuring Space Bar settings: "

# Behavior settings - disable toggle overview
dconf write /org/gnome/shell/extensions/space-bar/behavior/toggle-overview false

# Match the top bar's regular font weight.
dconf write /org/gnome/shell/extensions/space-bar/appearance/active-workspace-font-weight "'400'"
dconf write /org/gnome/shell/extensions/space-bar/appearance/inactive-workspace-font-weight "'400'"
dconf write /org/gnome/shell/extensions/space-bar/appearance/empty-workspace-font-weight "'400'"

# Shortcuts settings - disable default shortcuts, enable move-to-workspace
dconf write /org/gnome/shell/extensions/space-bar/shortcuts/activate-empty-key "@as []"
dconf write /org/gnome/shell/extensions/space-bar/shortcuts/activate-previous-key "@as []"
dconf write /org/gnome/shell/extensions/space-bar/shortcuts/enable-move-to-workspace-shortcuts true
dconf write /org/gnome/shell/extensions/space-bar/shortcuts/move-workspace-left "@as []"
dconf write /org/gnome/shell/extensions/space-bar/shortcuts/move-workspace-right "@as []"
dconf write /org/gnome/shell/extensions/space-bar/shortcuts/open-menu "@as []"

printf "done.\n"

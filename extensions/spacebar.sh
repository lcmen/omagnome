#!/usr/bin/env bash

EXTENSION_UUID="space-bar@luchrioh"
EXTENSION_URL="https://extensions.gnome.org/extension/5090/space-bar/"

# Check if the extension is installed
if gnome-extensions list | grep -q "$EXTENSION_UUID"; then
    printf "\n[omagnome]  Updating Space Bar GNOME extension: "
else
    printf "\n[omagnome]  Installing Space Bar GNOME extension: "
fi

gdbus call --session \
    --dest org.gnome.Shell.Extensions \
    --object-path /org/gnome/Shell/Extensions \
    --method org.gnome.Shell.Extensions.InstallRemoteExtension \
    "$EXTENSION_UUID" >/dev/null 2>&1

read -p $'\nPress Enter after confirming the installation modal...\n'
printf "done.\n"

printf "[omagnome]  Enabling Space Bar GNOME extension: "

if gnome-extensions enable "$EXTENSION_UUID"; then
    printf "done.\n"
else
    printf "failed.\n"
    exit 1
fi

printf "[omagnome]  Configuring Space Bar settings: "

# Behavior settings - disable toggle overview
dconf write /org/gnome/shell/extensions/space-bar/behavior/toggle-overview false

# Shortcuts settings - disable default shortcuts, enable move-to-workspace
dconf write /org/gnome/shell/extensions/space-bar/shortcuts/activate-empty-key "@as []"
dconf write /org/gnome/shell/extensions/space-bar/shortcuts/activate-previous-key "@as []"
dconf write /org/gnome/shell/extensions/space-bar/shortcuts/enable-move-to-workspace-shortcuts true
dconf write /org/gnome/shell/extensions/space-bar/shortcuts/move-workspace-left "@as []"
dconf write /org/gnome/shell/extensions/space-bar/shortcuts/move-workspace-right "@as []"
dconf write /org/gnome/shell/extensions/space-bar/shortcuts/open-menu "@as []"

printf "done.\n"

#!/usr/bin/env bash

EXTENSION_UUID="space-bar@luchrioh"
EXTENSION_URL="https://extensions.gnome.org/extension/5090/space-bar/"

printf "\n[omagnome]  Installing Space Bar GNOME extension: "

# Check if the extension is installed
if gnome-extensions list | grep -q "$EXTENSION_UUID"; then
    printf "already installed.\n"
else
    gdbus call --session \
        --dest org.gnome.Shell.Extensions \
        --object-path /org/gnome/Shell/Extensions \
        --method org.gnome.Shell.Extensions.InstallRemoteExtension \
        "$EXTENSION_UUID"

    if [ $? -eq 0 ]; then
        printf "done.\n"
    else
        printf "failed.\n"
        exit 1
    fi
fi

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

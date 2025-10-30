#!/usr/bin/env bash

EXTENSION_UUID="dim-background-windows@stephane-13.github.com"
EXTENSION_URL="https://extensions.gnome.org/extension/6313/dim-background-windows/"

printf "\n[omagnome]  Installing Dim Background Windows GNOME extension: "

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

printf "[omagnome]  Enabling Dim Background Windows GNOME extension: "

if gnome-extensions enable "$EXTENSION_UUID"; then
    printf "done.\n"
else
    printf "failed.\n"
    exit 1
fi

printf "[omagnome]  Configuring Dim Background Windows settings: "

# Transparency and dimming settings
dconf write /org/gnome/shell/extensions/dim-background-windows/brightness 0.90
dconf write /org/gnome/shell/extensions/dim-background-windows/dimming-enabled true
dconf write /org/gnome/shell/extensions/dim-background-windows/toggle-shortcut "['<Super>g']"

printf "done.\n"

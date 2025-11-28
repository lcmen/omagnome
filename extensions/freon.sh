#!/usr/bin/env bash

EXTENSION_UUID="freon@UshakovVasilii_Github.yahoo.com"
EXTENSION_URL="https://extensions.gnome.org/extension/841/freon/"

# Check if the extension is installed
if gnome-extensions list | grep -q "$EXTENSION_UUID"; then
    printf "\n[omagnome]  Updating Freon GNOME extension: "
else
    printf "\n[omagnome]  Installing Freon GNOME extension: "
fi

gdbus call --session \
    --dest org.gnome.Shell.Extensions \
    --object-path /org/gnome/Shell/Extensions \
    --method org.gnome.Shell.Extensions.InstallRemoteExtension \
    "$EXTENSION_UUID" >/dev/null 2>&1

read -p $'\nPress Enter after confirming the installation modal...\n'
printf "done.\n"

printf "[omagnome]  Enabling Freon GNOME extension: "

if gnome-extensions enable "$EXTENSION_UUID"; then
    printf "done.\n"
else
    printf "failed.\n"
    exit 1
fi

printf "[omagnome]  Configuring Freon settings: "

# Sensor configuration
dconf write /org/gnome/shell/extensions/freon/hot-sensors "['Tccd1', 'edge']"

printf "done.\n"

#!/usr/bin/env bash

EXTENSION_UUID="freon@UshakovVasilii_Github.yahoo.com"
EXTENSION_URL="https://extensions.gnome.org/extension/841/freon/"

printf "\n[omagnome]  Installing Freon GNOME extension: "

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

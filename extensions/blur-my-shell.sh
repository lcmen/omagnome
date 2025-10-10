#!/usr/bin/env bash

EXTENSION_UUID="blur-my-shell@aunetx"
EXTENSION_URL="https://extensions.gnome.org/extension/3193/blur-my-shell/"

printf "\n[omagnome]  Installing Blur my Shell GNOME extension: "

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

printf "[omagnome]  Enabling Blur my Shell GNOME extension: "

if gnome-extensions enable "$EXTENSION_UUID"; then
    printf "done.\n"
else
    printf "failed.\n"
    exit 1
fi

printf "[omagnome]  Configuring Blur my Shell settings: "

# Configure pipelines
dconf write /org/gnome/shell/extensions/blur-my-shell/pipelines "{'pipeline_default': {'name': <'Default'>, 'effects': <[<{'type': <'native_static_gaussian_blur'>, 'id': <'effect_000000000000'>, 'params': <{'radius': <30>, 'brightness': <0.3>, 'unscaled_radius': <100>}>}>]>}, 'pipeline_default_rounded': {'name': <'Default rounded'>, 'effects': <[<{'type': <'corner'>, 'id': <'effect_000000000002'>, 'params': <{'radius': <8>}>}>, <{'type': <'native_static_gaussian_blur'>, 'id': <'effect_000000000001'>, 'params': <{'radius': <30>, 'brightness': <0.3>, 'unscaled_radius': <0>}>}>]>}}"

# Panel settings - dark panel with blur
dconf write /org/gnome/shell/extensions/blur-my-shell/panel/blur true
dconf write /org/gnome/shell/extensions/blur-my-shell/panel/static-blur true
dconf write /org/gnome/shell/extensions/blur-my-shell/panel/brightness 0.08
dconf write /org/gnome/shell/extensions/blur-my-shell/panel/sigma 40
dconf write /org/gnome/shell/extensions/blur-my-shell/panel/style-panel 2
dconf write /org/gnome/shell/extensions/blur-my-shell/panel/override-background true
dconf write /org/gnome/shell/extensions/blur-my-shell/panel/override-background-dynamically false
dconf write /org/gnome/shell/extensions/blur-my-shell/panel/force-light-text false
dconf write /org/gnome/shell/extensions/blur-my-shell/panel/unblur-in-overview false
dconf write /org/gnome/shell/extensions/blur-my-shell/panel/pipeline "'pipeline_default'"

# Dash-to-dock settings
dconf write /org/gnome/shell/extensions/blur-my-shell/dash-to-dock/blur true
dconf write /org/gnome/shell/extensions/blur-my-shell/dash-to-dock/static-blur true
dconf write /org/gnome/shell/extensions/blur-my-shell/dash-to-dock/brightness 0.6
dconf write /org/gnome/shell/extensions/blur-my-shell/dash-to-dock/sigma 30
dconf write /org/gnome/shell/extensions/blur-my-shell/dash-to-dock/style-dash-to-dock 0
dconf write /org/gnome/shell/extensions/blur-my-shell/dash-to-dock/pipeline "'pipeline_default_rounded'"

# Overview settings
dconf write /org/gnome/shell/extensions/blur-my-shell/overview/blur false
dconf write /org/gnome/shell/extensions/blur-my-shell/overview/style-components 2
dconf write /org/gnome/shell/extensions/blur-my-shell/overview/pipeline "'pipeline_default'"

# Appfolder settings
dconf write /org/gnome/shell/extensions/blur-my-shell/appfolder/blur false
dconf write /org/gnome/shell/extensions/blur-my-shell/appfolder/brightness 0.6
dconf write /org/gnome/shell/extensions/blur-my-shell/appfolder/sigma 30

printf "done.\n"

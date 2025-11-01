#!/usr/bin/env bash

EXTENSION_UUID="forge@jmmaranan.com"
EXTENSION_URL="https://extensions.gnome.org/extension/4481/forge/"

printf "\n[omagnome]  Installing Forge GNOME extension: "

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

printf "[omagnome]  Enabling Forge GNOME extension: "

if gnome-extensions enable "$EXTENSION_UUID"; then
    printf "done.\n"
else
    printf "failed.\n"
    exit 1
fi

printf "[omagnome]  Configuring Forge settings: "

# General settings
dconf write /org/gnome/shell/extensions/forge/focus-border-toggle false
dconf write /org/gnome/shell/extensions/forge/stacked-tiling-mode-enabled false
dconf write /org/gnome/shell/extensions/forge/tabbed-tiling-mode-enabled false
dconf write /org/gnome/shell/extensions/forge/window-gap-size "uint32 4"
dconf write /org/gnome/shell/extensions/forge/window-gap-size-increment "uint32 2"

# Keybindings
dconf write /org/gnome/shell/extensions/forge/keybindings/con-split-horizontal "['<Super>z']"
dconf write /org/gnome/shell/extensions/forge/keybindings/con-split-layout-toggle "['<Super>x']"
dconf write /org/gnome/shell/extensions/forge/keybindings/con-split-vertical "['<Super>v']"
dconf write /org/gnome/shell/extensions/forge/keybindings/con-stacked-layout-toggle "['<Shift><Super>s']"
dconf write /org/gnome/shell/extensions/forge/keybindings/con-tabbed-layout-toggle "['<Shift><Super>t']"
dconf write /org/gnome/shell/extensions/forge/keybindings/con-tabbed-showtab-decoration-toggle "['<Control><Alt>y']"
dconf write /org/gnome/shell/extensions/forge/keybindings/focus-border-toggle "['<Super>x']"
dconf write /org/gnome/shell/extensions/forge/keybindings/prefs-tiling-toggle "['<Super>w']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-focus-down "['<Super>Down']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-focus-left "['<Super>Left']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-focus-right "['<Super>Right']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-focus-up "['<Super>Up']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-gap-size-decrease "@as []"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-gap-size-increase "@as []"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-move-down "['<Shift><Super>Down']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-move-left "['<Shift><Super>Left']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-move-right "['<Shift><Super>Right']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-move-up "['<Shift><Super>Up']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-resize-bottom-decrease "['<Shift><Alt><Super>Down']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-resize-bottom-increase "['<Alt><Super>Down']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-resize-left-decrease "['<Shift><Alt><Super>Left']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-resize-left-increase "['<Alt><Super>Left']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-resize-right-decrease "['<Shift><Alt><Super>Right']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-resize-right-increase "['<Alt><Super>Right']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-resize-top-decrease "['<Shift><Alt><Super>Up']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-resize-top-increase "['<Alt><Super>Up']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-snap-center "['<Shift><Super>Return']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-snap-one-third-left "['<Shift><Super>j']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-snap-one-third-right "['<Shift><Super>k']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-snap-two-third-left "['<Shift><Super>h']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-snap-two-third-right "['<Shift><Super>l']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-swap-down "['<Control><Super>Down']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-swap-last-active "['<Super>Return']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-swap-left "['<Control><Super>Left']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-swap-right "['<Control><Super>Right']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-swap-up "['<Control><Super>Up']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-toggle-always-float "['<Shift><Super>space']"
dconf write /org/gnome/shell/extensions/forge/keybindings/window-toggle-float "['<Super>space']"
dconf write /org/gnome/shell/extensions/forge/keybindings/workspace-active-tile-toggle "['<Shift><Super>w']"

printf "done.\n"

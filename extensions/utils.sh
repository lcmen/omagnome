#!/usr/bin/env bash

extension_is_installed() {
    gnome-extensions list | grep -Fxq -- "$1"
}

request_extension_install() {
    local extension_uuid="$1"
    local install_output

    if ! install_output=$(gdbus call --session \
        --dest org.gnome.Shell.Extensions \
        --object-path /org/gnome/Shell/Extensions \
        --method org.gnome.Shell.Extensions.InstallRemoteExtension \
        "$extension_uuid" 2>&1); then
        printf "failed.\n"
        printf "[omagnome]  Installation error: %s\n" "$install_output" >&2
        return 1
    fi
}

confirm_extension_install() {
    local extension_uuid="$1"
    local extension_name="$2"

    read -r -p $'\nPress Enter after confirming the installation modal...\n'

    if ! extension_is_installed "$extension_uuid"; then
        printf "failed.\n" >&2
        printf "[omagnome]  %s was not installed. The installation may have been cancelled.\n" \
            "$extension_name" >&2
        return 1
    fi

    printf "done.\n"
}

enable_extension() {
    local extension_uuid="$1"
    local extension_name="$2"
    local enable_output

    printf "[omagnome]  Enabling %s GNOME extension: " "$extension_name"

    if ! enable_output=$(gnome-extensions enable "$extension_uuid" 2>&1); then
        printf "failed.\n"
        printf "[omagnome]  Enable error: %s\n" "$enable_output" >&2
        return 1
    fi

    printf "done.\n"
}

install_and_enable_extension() {
    local extension_uuid="$1"
    local extension_name="$2"
    local action="Installing"

    if extension_is_installed "$extension_uuid"; then
        action="Updating"
    fi

    printf "\n[omagnome]  %s %s GNOME extension: " "$action" "$extension_name"

    request_extension_install "$extension_uuid" || return 1
    confirm_extension_install "$extension_uuid" "$extension_name" || return 1
    enable_extension "$extension_uuid" "$extension_name"
}

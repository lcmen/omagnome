#!/usr/bin/env bash

set -e

EXTENSION_UUID="no-overview@fthx"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=extensions/utils.sh
source "$SCRIPT_DIR/utils.sh"

if extension_is_installed "$EXTENSION_UUID"; then
    enable_extension "$EXTENSION_UUID" "No overview at start-up"
    exit 0
fi

printf "\n[omagnome]  Installing No overview at start-up GNOME extension: "

# The Shell extension D-Bus installer can disconnect on some GNOME/Solus
# sessions. Fall back to the official package download in that case.
if ! request_extension_install "$EXTENSION_UUID"; then
    if ! command -v curl > /dev/null 2>&1; then
        printf "[omagnome]  Error: curl is required to download No overview at start-up.\n" >&2
        exit 1
    fi

    extension_zip="$(mktemp "${TMPDIR:-/tmp}/no-overview.XXXXXX.zip")"
    trap 'rm -f "$extension_zip"' EXIT
    curl -fsSL -o "$extension_zip" \
        "https://extensions.gnome.org/extension-data/no-overviewfthx.v23.shell-extension.zip"
    gnome-extensions install --force "$extension_zip"
fi

printf "done.\n"
enable_extension "$EXTENSION_UUID" "No overview at start-up"

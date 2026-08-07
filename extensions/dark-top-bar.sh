#!/usr/bin/env bash

set -e

EXTENSION_UUID="dark-top-bar@omagnome"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="$(mktemp -d)"

cleanup() {
    rm -f "$BUILD_DIR/$EXTENSION_UUID.shell-extension.zip"
    rmdir "$BUILD_DIR"
}
trap cleanup EXIT

printf "[omagnome]  Installing Dark Top Bar GNOME extension: "
gnome-extensions pack \
    --force \
    --out-dir="$BUILD_DIR" \
    "$SCRIPT_DIR/dark-top-bar"
gnome-extensions install \
    --force \
    "$BUILD_DIR/$EXTENSION_UUID.shell-extension.zip"
printf "done.\n"

# Migrate installations previously configured by omagnome.
gnome-extensions disable blur-my-shell@aunetx 2> /dev/null || true

printf "[omagnome]  Enabling Dark Top Bar GNOME extension: "
if gnome-extensions enable "$EXTENSION_UUID" 2> /dev/null; then
    printf "done.\n"
else
    printf "restart GNOME Shell or log in again, then enable %s.\n" "$EXTENSION_UUID"
fi

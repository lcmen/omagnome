#!/usr/bin/env bash

set -euo pipefail

FONT_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/fonts/FiraCodeNerdFont"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"

for command_name in curl unzip fc-cache; do
    if ! command -v "$command_name" > /dev/null 2>&1; then
        echo "[omagnome]  Error: $command_name is required to install FiraCode Nerd Font." >&2
        exit 1
    fi
done

temporary_dir="$(mktemp -d)"
trap 'rm -rf "$temporary_dir"' EXIT

echo "[omagnome]  Downloading FiraCode Nerd Font..."
curl --fail --location --silent --show-error \
    "$FONT_URL" \
    --output "$temporary_dir/FiraCode.zip"

echo "[omagnome]  Installing FiraCode Nerd Font..."
mkdir -p "$FONT_DIR"
unzip -oq "$temporary_dir/FiraCode.zip" '*.ttf' -d "$FONT_DIR"

fc-cache -f "$FONT_DIR" > /dev/null

if command -v gsettings > /dev/null 2>&1 && \
    gsettings list-schemas | grep -qx 'org.gnome.Ptyxis'; then
    echo "[omagnome]  Applying FiraCode Nerd Font Mono to Ptyxis..."
    gsettings set org.gnome.Ptyxis use-system-font false
    gsettings set org.gnome.Ptyxis font-name 'FiraCode Nerd Font Mono 11'
fi

echo "[omagnome]  FiraCode Nerd Font installed."

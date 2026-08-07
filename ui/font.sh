#!/usr/bin/env bash

set -euo pipefail

FONT_ROOT="${XDG_DATA_HOME:-$HOME/.local/share}/fonts"
FIRACODE_DIR="$FONT_ROOT/FiraCodeNerdFont"
FIRACODE_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"
INTER_DIR="$FONT_ROOT/Inter"
INTER_URL="https://github.com/rsms/inter/releases/download/v4.1/Inter-4.1.zip"

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
    "$FIRACODE_URL" \
    --output "$temporary_dir/FiraCode.zip"

echo "[omagnome]  Downloading Inter..."
curl --fail --location --silent --show-error \
    "$INTER_URL" \
    --output "$temporary_dir/Inter.zip"

echo "[omagnome]  Installing FiraCode Nerd Font..."
mkdir -p "$FIRACODE_DIR"
unzip -oq "$temporary_dir/FiraCode.zip" '*.ttf' -d "$FIRACODE_DIR"

echo "[omagnome]  Installing Inter..."
mkdir -p "$INTER_DIR"
unzip -ojq "$temporary_dir/Inter.zip" \
    '*InterVariable.ttf' \
    '*InterVariable-Italic.ttf' \
    -d "$INTER_DIR"

fc-cache -f "$FIRACODE_DIR" "$INTER_DIR" > /dev/null

if command -v gsettings > /dev/null 2>&1; then
    echo "[omagnome]  Applying Inter as the system UI font..."
    gsettings set org.gnome.desktop.interface font-name 'Inter 11'
    gsettings set org.gnome.desktop.interface document-font-name 'Inter 12'
fi

if command -v gsettings > /dev/null 2>&1 && \
    gsettings list-schemas | grep -qx 'org.gnome.Ptyxis'; then
    echo "[omagnome]  Applying FiraCode Nerd Font Mono to Ptyxis..."
    gsettings set org.gnome.Ptyxis use-system-font false
    gsettings set org.gnome.Ptyxis font-name 'FiraCode Nerd Font Mono 11'
fi

echo "[omagnome]  Fonts installed."

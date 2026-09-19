#!/usr/bin/env bash

set -euo pipefail

if ! command -v ulauncher >/dev/null 2>&1; then
  printf '[omagnome] Installing Ulauncher from the Solus repository...\n'
  eopkg install -y ulauncher
fi

config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/ulauncher"
theme_dir="$config_dir/user-themes/ulauncher-white-transparent-theme"
mkdir -p "$config_dir/user-themes"

if [[ -d "$theme_dir/.git" ]]; then
  git -C "$theme_dir" pull --ff-only
else
  git clone --depth 1 https://github.com/yngmjgsd/ulauncher-white-transparent-theme.git "$theme_dir"
fi

# Keep the white-transparent blue theme, but make its launcher surface compact
# and square to match the rest of this setup.
blue_theme_css="$theme_dir/ulauncher-white-transparent-blue-match/theme.css"
sed -i \
  -e 's/rgba(255, 255, 255, 0.9)/#ffffff/' \
  -e 's/rgba(0, 0, 0, 0.3)/rgba(0, 0, 0, 0.12)/' \
  -e 's/box-shadow: 0 0 2px @window_shadow;/box-shadow: none;/' \
  -e 's/border-radius: 4px;/border-radius: 0;/' \
  -e 's/font-size: 130%;/font-size: 110%;/' \
  "$blue_theme_css"

settings_file="$config_dir/settings.json"
if [[ -f "$settings_file" ]]; then
  tmp_file=$(mktemp)
  jq '.theme_name = "white-transparent-blue-match" | .hotkey_show_app = "" | .window_shadow = 0' "$settings_file" > "$tmp_file"
  mv "$tmp_file" "$settings_file"
else
  printf '%s\n' '{"theme_name":"white-transparent-blue-match","hotkey_show_app":"","window_shadow":0}' > "$settings_file"
fi

shortcut_path="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ulauncher/"
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['$shortcut_path']"
gsettings set "org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$shortcut_path" name 'Ulauncher'
gsettings set "org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$shortcut_path" command 'gapplication launch io.ulauncher.Ulauncher'
gsettings set "org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$shortcut_path" binding '<Super>space'

# Restore the per-user Ptyxis override so launcher activation opens a new window.
ptyxis_system="/usr/share/applications/org.gnome.Ptyxis.desktop"
ptyxis_user="${XDG_DATA_HOME:-$HOME/.local/share}/applications/org.gnome.Ptyxis.desktop"
if [[ -r "$ptyxis_system" ]]; then
  mkdir -p "$(dirname "$ptyxis_user")"
  sed \
    -e 's/^DBusActivatable=true/DBusActivatable=false/' \
    -e '0,/^Exec=ptyxis$/s//Exec=ptyxis --new-window/' \
    "$ptyxis_system" > "$ptyxis_user"
  if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database "$(dirname "$ptyxis_user")" >/dev/null 2>&1 || true
  fi
fi

systemctl --user enable ulauncher.service
systemctl --user restart ulauncher.service
printf '[omagnome] Ulauncher is ready (Super+Space; white transparent blue theme).\n'

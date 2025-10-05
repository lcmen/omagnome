#!/usr/bin/env bash

set -e

echo "[omagnome]  Configuring workspaces..."

# Disable dynamic workspaces
gsettings set org.gnome.mutter dynamic-workspaces false

# Set number of static workspaces to 5
gsettings set org.gnome.desktop.wm.preferences num-workspaces 5

echo "[omagnome]  Workspaces configured: 5 static workspaces"

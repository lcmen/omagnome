#!/usr/bin/env bash

set -e

cat << "EOF"
  ____
 / __ \__ _  ___ ____ ____  ___  __ _  ___
/ /_/ /  ' \/ _ `/ _ `/ _ \/ _ \/  ' \/ -_)
\____/_/_/_/\_,_/\_, /_//_/\___/_/_/_/\__/
                /___/
EOF

printf "\n[omagnome] Configuring Gnome ==========================================\n"

for script in gnome/*.sh; do
  bash "$script"
done

printf "\n[omagnome] Setting up extensions ======================================\n"

for extension in extensions/*.sh; do
  bash "$extension"
done

printf "\n[omagnome] Setting up UI themes ========================================\n"

bash ui/install.sh

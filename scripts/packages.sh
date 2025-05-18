#!/usr/bin/env bash

packages=(vim git openssh docker docker-compose terminus-font wireguard-tools resolvconf)

echo "Updating pacman"

sudo pacman -Sy

echo "Downloading needed packages"

for pkg in "${packages[@]}"; do
    if ! pacman -Qi "$pkg" &>/dev/null; then
        echo "Installing $pkg..."
        sudo pacman -S --noconfirm "$pkg"
    else
        echo "$pkg already installed."
    fi
done

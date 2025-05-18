#!/usr/bin/env bash

sudo pacman -S --noconfirm wireguard-tools resolvconf

sudo mkdir -p /etc/wireguard

sudo cp ./wg0.conf /etc/wireguard/

wg-quick up /etc/wireguard/wg0.conf

exec /bin/bash

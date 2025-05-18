#!/usr/bin/env bash

sudo mkdir -p /etc/wireguard

sudo cp ./wg0.conf /etc/wireguard/

wg-quick up /etc/wireguard/wg0.conf || {
    echo "Failed to start WG"
    exit 1
}

docker network inspect vps-network &>/dev/null ||
    docker network create --subnet=172.21.0.0/16 vps-network

iptables -t nat -A POSTROUTING -s 172.17.0.0/16 -o wg0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 172.21.0.0/16 -o wg0 -j MASQUERADE

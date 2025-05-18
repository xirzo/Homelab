#!/usr/bin/env bash

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

systemctl start wg-quick@wg0

if ! ip link show wg0 >/dev/null 2>&1; then
    echo "WireGuard interface wg0 failed to start"
    exit 1
fi

if ! docker network inspect vps-network >/dev/null 2>&1; then
    echo "Creating Docker network vps-network"
    docker network create --driver bridge \
        --subnet=172.21.0.0/16 \
        --gateway=172.21.0.1 \
        vps-network
else
    echo "Docker network vps-network already exists"
fi

echo "Setting up iptables forwarding rules"
iptables -A FORWARD -i docker0 -o wg0 -j ACCEPT
iptables -A FORWARD -i wg0 -o docker0 -j ACCEPT
iptables -t nat -A POSTROUTING -s 172.17.0.0/16 -o wg0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 172.21.0.0/16 -o wg0 -j MASQUERADE

echo "Saving iptables rules for persistence"
mkdir -p /etc/iptables
sh -c "iptables-save > /etc/iptables/iptables.rules"

systemctl enable iptables.service

echo "Starting systemd-resolved"
systemctl enable systemd-resolved.service
systemctl start systemd-resolved.service

echo "Setup completed successfully"

#!/usr/bin/env bash

sudo systemctl start wg-quick@wg0

if ! sudo wg show wg0 &>/dev/null; then
    echo "WireGuard interface wg0 failed to start"
    exit 1
fi

if ! sudo docker network inspect vps-network >/dev/null 2>&1; then
    echo "Creating Docker network vps-network"
    sudo docker network create --driver bridge \
        --subnet=172.21.0.0/16 \
        --gateway=172.21.0.1 \
        vps-network
else
    echo "Docker network vps-network already exists"
fi

echo "Setting up iptables forwarding rules"
sudo iptables -A FORWARD -i docker0 -o wg0 -j ACCEPT
sudo iptables -A FORWARD -i wg0 -o docker0 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -s 172.17.0.0/16 -o wg0 -j MASQUERADE
sudo iptables -t nat -A POSTROUTING -s 172.21.0.0/16 -o wg0 -j MASQUERADE

echo "Saving iptables rules for persistence"
sudo mkdir -p /etc/iptables
sudo sh -c "iptables-save > /etc/iptables/iptables.rules"

sudo systemctl enable iptables.service

echo "Starting systemd-resolved"
sudo systemctl enable systemd-resolved.service
sudo systemctl start systemd-resolved.service

echo "Setup completed successfully"

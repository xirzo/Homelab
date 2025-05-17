#!/usr/bin/env bash

systemd_services=(sshd docker)

echo "Enabling and staring systemd services"

sudo systemctl enable "${systemd_services[@]}"
sudo systemctl start "${systemd_services[@]}"

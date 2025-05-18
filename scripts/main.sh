#!/usr/bin/env bash

WG_CONFIG_SOURCE="../wg0.conf"

source ./packages.sh
source ./systemd_services.sh
source ./env_setup.sh

bash ./setup_wireguard_config.sh "$WG_CONFIG_SOURCE"

echo "Configuring Docker daemon to use Google DNS servers..."
mkdir -p /etc/docker

cat >/etc/docker/daemon.json <<EOF
{
  "dns": ["8.8.8.8", "8.8.4.4"]
}
EOF

echo "Restarting Docker service..."
systemctl restart docker

systemctl status docker

echo "Docker DNS configuration completed."
echo "Try pulling Docker images again."

source ./setup_network.sh

bash ./create_docker_app.sh "portainer" "../docker-compose/docker-compose-portainer.yml"

#!/usr/bin/env bash

WG_CONFIG_SOURCE="../wg0.conf"

source ./packages.sh
source ./systemd_services.sh
source ./env_setup.sh

sudo ./setup_wireguard_config.sh "$WG_CONFIG_SOURCE"

source ./setup_network.sh

bash ./create_docker_app.sh "wireguard" "../docker-compose/docker-compose-wireguard.yml"
bash ./create_docker_app.sh "portainer" "../docker-compose/docker-compose-portainer.yml"

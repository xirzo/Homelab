#!/usr/bin/env bash

source ./packages.sh
source ./systemd_services.sh
source ./env_setup.sh

bash ./create_docker_app.sh "wireguard" "../docker-compose/docker-compose-wireguard.yml"
bash ./create_docker_app.sh "portainer" "../docker-compose/docker-compose-portainer.yml"

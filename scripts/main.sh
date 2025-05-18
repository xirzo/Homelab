#!/usr/bin/env bash

source ./packages.sh
source ./systemd_services.sh
source ./env_setup.sh

source ./setup_network.sh

bash ./create_docker_app.sh "portainer" "../docker-compose/docker-compose-portainer.yml"

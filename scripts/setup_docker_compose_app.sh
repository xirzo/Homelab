#!/usr/bin/env bash
set -e

if [ $# -lt 2 ]; then
    echo "Usage: $0 <username> <docker_compose_file>"
    exit 1
fi

USERNAME="$1"
DOCKER_COMPOSE_FILE="$2"
APP_DIRECTORY="/srv/${USERNAME}"

if ! id -u "$USERNAME" >/dev/null 2>&1; then
    sudo useradd -G docker -m -d "$APP_DIRECTORY" "$USERNAME"
fi

if [ ! -d "$APP_DIRECTORY" ]; then
    echo "Error: $APP_DIRECTORY does not exist."
    exit 1
fi

if [ ! -f "$DOCKER_COMPOSE_FILE" ]; then
    echo "Error: $DOCKER_COMPOSE_FILE does not exist."
    exit 1
fi

sudo cp "$DOCKER_COMPOSE_FILE" "$APP_DIRECTORY/docker-compose.yml"
sudo chown "$USERNAME:$USERNAME" -R "$APP_DIRECTORY"

echo "New docker-compose app is setup"

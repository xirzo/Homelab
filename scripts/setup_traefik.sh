#!/usr/bin/env bash
set -e

USERNAME="traefik"
APP_DIRECTORY="/srv/${USERNAME}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="${SCRIPT_DIR}/../traefik"

if ! id -u "$USERNAME" >/dev/null 2>&1; then
    sudo useradd -G docker -m -d "$APP_DIRECTORY" "$USERNAME"
fi

if [ ! -d "$APP_DIRECTORY" ]; then
    echo "Error: $APP_DIRECTORY does not exist."
    exit 1
fi

for file in docker-compose.yml traefik.yml; do
    if [ ! -f "${SRC_DIR}/$file" ]; then
        echo "Error: ${SRC_DIR}/$file does not exist."
        exit 1
    fi
    sudo cp "${SRC_DIR}/$file" "${APP_DIRECTORY}/$file"
done

if [ ! -d "${SRC_DIR}/dynamic" ]; then
    echo "Error: ${SRC_DIR}/dynamic directory does not exist."
    exit 1
fi

sudo rsync -a --delete "${SRC_DIR}/dynamic/" "${APP_DIRECTORY}/dynamic/"

sudo chown "$USERNAME:$USERNAME" -R "$APP_DIRECTORY"

echo "Traefik docker-compose app is set up in $APP_DIRECTORY"

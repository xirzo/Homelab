#!/usr/bin/env bash
set -e

if [ $# -lt 2 ]; then
    echo "Usage: $0 <username> <docker_compose_file>"
    exit 1
fi

USERNAME="$1"
DOCKER_COMPOSE_FILE="$2"
APP_DIR="/srv/${USERNAME}"

if ! getent group docker >/dev/null 2>&1; then
    groupadd docker
fi

if ! id -u "${USERNAME}" >/dev/null 2>&1; then
    useradd --system -s /usr/bin/nologin "${USERNAME}"
fi

usermod -aG docker "${USERNAME}"

mkdir -p "${APP_DIR}"
chown "${USERNAME}:${USERNAME}" "${APP_DIR}"

cp "${DOCKER_COMPOSE_FILE}" "${APP_DIR}/docker-compose.yml"
chown "${USERNAME}:${USERNAME}" "${APP_DIR}/docker-compose.yml"

(cd "${APP_DIR}" && docker-compose up -d)

echo "User '${USERNAME}' created and added to docker group."
echo "Docker-compose setup is now running inside /srv/${USERNAME}."

#!/usr/bin/env bash
set -e

if [ $# -lt 2 ]; then
    echo "Usage: $0 <username> <docker_compose_file>"
    exit 1
fi

USERNAME="$1"
DOCKER_COMPOSE_FILE="$2"
APP_DIR="/srv/${USERNAME}"

if ! sudo getent group docker >/dev/null 2>&1; then
    sudo groupadd docker
fi

if ! sudo id -u "${USERNAME}" >/dev/null 2>&1; then
    sudo useradd --system -s /usr/bin/nologin "${USERNAME}"
fi

sudo usermod -aG docker "${USERNAME}"
sudo usermod -aG wheel "${USERNAME}"

echo "# Allow ${USERNAME} to use sudo without password" | sudo tee "/etc/sudoers.d/${USERNAME}" >/dev/null
echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" | sudo tee -a "/etc/sudoers.d/${USERNAME}" >/dev/null
sudo chmod 440 "/etc/sudoers.d/${USERNAME}"

sudo mkdir -p "${APP_DIR}"
sudo chown "${USERNAME}:${USERNAME}" "${APP_DIR}"

sudo cp "${DOCKER_COMPOSE_FILE}" "${APP_DIR}/docker-compose.yml"
sudo chown "${USERNAME}:${USERNAME}" "${APP_DIR}/docker-compose.yml"

(cd "${APP_DIR}" && sudo -u "${USERNAME}" docker-compose up -d)

echo "User '${USERNAME}' created and added to docker and sudo groups."
echo "Docker-compose setup is now running inside /srv/${USERNAME}."
echo "The user has been granted passwordless sudo access."

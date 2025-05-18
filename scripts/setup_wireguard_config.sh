#!/usr/bin/env bash

setup_wireguard_config() {
    SOURCE_CONFIG="${1:-wg0.conf}"
    DEST_DIR="/etc/wireguard"
    DEST_CONFIG="${DEST_DIR}/wg0.conf"

    if [ ! -f "$SOURCE_CONFIG" ]; then
        echo "Error: Source configuration file '$SOURCE_CONFIG' not found"
        exit 1
    fi

    if [ ! -d "$DEST_DIR" ]; then
        echo "Creating $DEST_DIR directory"
        sudo mkdir -p "$DEST_DIR"
    fi

    if [ -f "$DEST_CONFIG" ]; then
        BACKUP_FILE="${DEST_CONFIG}.backup.$(date +%Y%m%d%H%M%S)"
        echo "Backing up existing configuration to $BACKUP_FILE"
        sudo cp "$DEST_CONFIG" "$BACKUP_FILE"
    fi

    echo "Copying WireGuard configuration to $DEST_CONFIG"
    sudo cp "$SOURCE_CONFIG" "$DEST_CONFIG"

    echo "Setting proper permissions on WireGuard config"
    sudo chmod 600 "$DEST_CONFIG"

    echo "WireGuard configuration setup complete"
    return 0
}

setup_wireguard_config "$1"

# Homelab

The idea of this particular repo is to hold a bootstrap script for my homelab, which I use to host some useful apps. This is meant to be used on Arch Linux, and it won`t work on other distributions.

## Install

- Install **wireguard** on your **VPS** and put the client config with the name **wg0.conf** into */srv/wireguard/wireguard-config/wg0.conf* (this works for any volume with relative path, it should be put into **/srv/{PROJECT_NAME}**)

- Make script executable and run it

```bash
sudo chmod +x scripts/main.sh && sudo ./main.sh
```

## Enabled systemd services

- sshd
- docker

## Installed apps

- nginx reverse proxy
- portainer
- nextcloud
- jellyfin

### Used ports

- portainer (10000, 9000)
- nextcloud (90, 9080, 9443)

## List of packages installed

- vim
- git
- openssl
- docker
- docker-compose
- terminus-font

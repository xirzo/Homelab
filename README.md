# Homelab

The idea of this particular repo is to hold a bootstrap script for my homelab, which I use to host some useful apps. This is meant to be used on Arch Linux, and it won`t work on other distributions.

## Install

- Clone repo on your home server and get into scripts directory
```

git clone https://github.com/xirzo/homelab && cd homelab/scripts
```

> [!NOTE]
> Wireguard was ditched in favor of docker networks

- Make script executable and run it

```bash
sudo chmod +x scripts/main.sh && sudo ./main.sh
```

## Configuration

> [!NOTE]  
> Now instead of **NPM**, my *homelab* utilizes **Traefik**

Setup **Traefik**

### Setting up Nextcloud AIO

#### Openning Nextcloud in browser

Forward port from server to your machine (this command must be executed on your machine, not server nor VPS)

```
ssh -L 8181:localhost:8080 server
```

Then open your browser at `localhost:8181`

## Enabled systemd services

- sshd
- docker

## Installed apps

- portainer
- nextcloud
- jellyfin

## List of packages installed

- vim
- git
- openssl
- docker
- docker-compose
- terminus-font
- wireguard-tools
- resolvconf

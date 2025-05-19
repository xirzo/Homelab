# Homelab

The idea of this particular repo is to hold a bootstrap script for my homelab, which I use to host some useful apps. This is meant to be used on Arch Linux, and it won`t work on other distributions.

## Install

- Clone repo on your home server and get into scripts directory (you should have NetworkManager installed on your machine, you may install it via **archinstall** when setting up your machine)

```
git clone https://github.com/xirzo/homelab && cd homelab/scripts
```

- Install **wireguard** on your **VPS** and put the client config with the name **wg0.conf** into **Homelab** directory on your home server.

**Client wg0.conf example:**

```
[Interface]
Address = 10.7.0.2/24
DNS = 77.88.8.8, 8.8.4.4
PrivateKey = <KEY>

[Peer]
PublicKey = <KEY>
PresharedKey = <KEY>
AllowedIPs = 10.7.0.1/32
Endpoint = <YOUR-SERVER-IP-OR-DOMAIN>:51820
PersistentKeepalive = 25
```

*Now you should have wg0.conf in `homelab` directory*

- Make script executable and run it

```bash
sudo chmod +x scripts/main.sh && sudo ./main.sh
```

## Configuration

You may change docker-compose files as you wish, but do not remove **vps-network** from networks property as it is needed for forwarding ports to your VPS.

### Adding new docker-compose app

#### Before using main.sh

Create new docker-compose-<name>.yml file in docker-compose directory and then add such line to the **main.sh**. Note that in order to use WG network you should add **vps-network** to your docker-compose service.

```
bash ./create_docker_app.sh "<name>" "../docker-compose/docker-compose-<name>.yml"
```

#### After using main.sh

You may just use create_docker_app.sh script or use portainer

```
./create_docker_app.sh "<name>" "docker-compose-<name>.yml"
```

## Enabled systemd services

- sshd
- docker

## Installed apps

- portainer
- nextcloud
- jellyfin

### Used ports

- portainer (12443)
- nextcloud (90, 9080, 9443)

## List of packages installed

- vim
- git
- openssl
- docker
- docker-compose
- terminus-font
- wireguard-tools
- resolvconf

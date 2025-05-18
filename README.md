# Homelab

The idea of this particular repo is to hold a bootstrap script for my homelab, which I use to host some useful apps. This is meant to be used on Arch Linux, and it won`t work on other distributions.

## Install

- Install **wireguard** on your **VPS** and put the client config with the name **wg0.conf** into **{HOMELAB_PROJECT_NAME}/scripts** directory on your home server.

Note, that your server **wg0.conf** should allow *docker default bridge* (172.17.0.0/16)

**Server wg0.conf example:**

```
[Interface]
Address = 10.7.0.1/24
PrivateKey = <KEY>
ListenPort = 51820

[Peer]
PublicKey = <KEY>
PresharedKey = <KEY>
# Allowd docker default bridge
AllowedIPs = 10.7.0.2/32, 172.17.0.0/16
```

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

- Make script executable and run it

```bash
sudo chmod +x scripts/main.sh && sudo ./main.sh
```

## Configuration

You may change docker-compose files as you wish, but do not remove **vps-network** from networks property as it is needed for forwarding ports to your VPS.

## Enabled systemd services

- sshd
- docker

## Installed apps

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
- wireguard-tools
- resolvconf

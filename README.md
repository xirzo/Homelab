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

> [!NOTE]  
> When adding new app into **NPM** set **wg0** ip address, not container name as host

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

### Setting up Nextcloud AIO

#### Openning Nextcloud in browser

Forward port from server to your machine (this command must be executed on your machine, not server nor VPS)

```
ssh -L 8181:localhost:8080 server
```

Then open your browser at `localhost:8181`

#### Nginx Proxy Manager

Configure NPM as such and insert domain that you chose on Nextcloud page when it asks so.

Note: If you`ve lost your Nextcloud passcode obtain it with this command (use it on server):

```
sudo docker exec nextcloud-aio-mastercontainer grep password /mnt/docker-aio-config/data/configuration.json
```

![image](https://github.com/user-attachments/assets/adb06c74-124e-42bb-9b30-f452e0afb32d)
![image](https://github.com/user-attachments/assets/05e24410-ee12-443c-a470-569f9ce07a1a)
![image](https://github.com/user-attachments/assets/8f265120-d0bf-4e20-ad96-9bd8b9c26145)
![image](https://github.com/user-attachments/assets/9d5e6199-4c3a-4b80-a854-948ad3762cc0)

```
client_body_buffer_size 512k;
proxy_read_timeout 86400s;
client_max_body_size 0;
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

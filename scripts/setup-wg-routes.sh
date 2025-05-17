#!/usr/bin/env bash

if ! docker exec wireguard ip a | grep -q wg0; then
    echo "WireGuard container doesn't have wg0 interface"
    echo "Fix WireGuard setup before continuing"
    exit 1
fi

WG_SUBNET=$(docker exec wireguard ip -4 route | grep wg0 | awk '{print $1}')
WG_CONTAINER_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' wireguard)
BRIDGE_ID=$(docker network inspect wg_network -f '{{.Id}}' | cut -c 1-12)
DOCKER_SUBNET=$(docker network inspect wg_network -f '{{range .IPAM.Config}}{{.Subnet}}{{end}}')

echo "WireGuard subnet: $WG_SUBNET"
echo "WireGuard container IP: $WG_CONTAINER_IP"
echo "Docker subnet: $DOCKER_SUBNET"

echo 1 >/proc/sys/net/ipv4/ip_forward

docker exec wireguard sysctl -w net.ipv4.ip_forward=1

iptables -A FORWARD -i br-"${BRIDGE_ID}" -o wg0 -j ACCEPT
iptables -A FORWARD -i wg0 -o br-"${BRIDGE_ID}" -j ACCEPT
iptables -t nat -A POSTROUTING -s "${DOCKER_SUBNET}" -o wg0 -j MASQUERADE

echo "Host routing set up successfully"

echo "Setting up routes in containers..."
for container in $(docker network inspect wg_network -f '{{range .Containers}}{{.Name}} {{end}}'); do
    if [ "$container" != "wireguard" ]; then
        echo "Adding route to $container"
        docker exec "$container" sh -c "command -v ip >/dev/null 2>&1 || { apt-get update >/dev/null 2>&1 && apt-get install -y iproute2 >/dev/null 2>&1 || apk add --no-cache iproute2 >/dev/null 2>&1; }"
        docker exec "$container" ip route add "$WG_SUBNET" via "$WG_CONTAINER_IP"
    fi
done

echo "All container routes configured!"

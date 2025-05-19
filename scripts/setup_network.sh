#!/usr/bin/env bash

sudo mkdir -p /etc/wireguard

sudo cp ../wg0.conf /etc/wireguard/

sudo nmcli connection import type wireguard file /etc/wireguard/wg0.conf

sudo nmcli connection up wg0

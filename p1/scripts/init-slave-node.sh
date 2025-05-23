#!/bin/bash
set -e

sudo apt-get update
if ! command -v curl &> /dev/null
then
	echo "curl could not be found, installing..."
	sudo apt-get install -y curl
fi
# Get interface name
ip_slave=$(hostname -I | awk '{print $1}')
iface=$(ip -o -4 addr show | grep "$ip_slave" | awk '{print $2}')
# Get K3S master node ip
master_ip=$(getent hosts lquehecS | awk '{ print $1 }')
# Install K3s
curl -sfL https://get.k3s.io | \
	INSTALL_K3S_EXEC="--flannel-iface $iface" \
	K3S_URL="https://$master_ip:6443" \
	K3S_TOKEN=$(sudo cat /vagrant/shared/k3s_node_token) \
	sh -

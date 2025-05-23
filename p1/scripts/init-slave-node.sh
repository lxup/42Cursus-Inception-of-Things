#!/bin/bash
set -e

# Install dependencies
sudo apt-get update
if ! command -v curl &> /dev/null
then
	echo "curl could not be found, installing..."
	sudo apt-get install -y curl
fi

# Get interface name
iface=$(ip -o -4 addr show | grep "$SLAVE_IP" | awk '{print $2}')
# Install K3s
curl -sfL https://get.k3s.io | \
	INSTALL_K3S_EXEC="--flannel-iface $iface" \
	K3S_URL="https://$MASTER_IP:6443" \
	K3S_TOKEN=$(cat "${SHARED_FOLDER}/k3s_node_token") \
	sh -

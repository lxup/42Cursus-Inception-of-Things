#!/bin/bash
set -e

# Install dependencies
sudo apt-get update
if ! command -v curl &> /dev/null
then
	echo "curl could not be found, installing..."
	sudo apt-get install -y curl
fi

# Uninstall k3s if already installed => get.k3s.io seems to automatically kill previous k3s and update it
# if command -v k3s &> /dev/null; then
# 	sudo systemctl stop k3s
# 	sudo /usr/local/bin/k3s-uninstall.sh
# fi

# Get interface name
iface=$(ip -o -4 addr show | grep "$MASTER_IP" | awk '{print $2}')
# Install K3s
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--flannel-iface $iface" sh -
# Wait for K3s to be ready
sudo chmod +x /etc/rancher/k3s/k3s.yaml
K3S_NODE_TOKEN=$(sudo cat /var/lib/rancher/k3s/server/node-token)
echo "K3S_NODE_TOKEN=$K3S_NODE_TOKEN"
echo "$K3S_NODE_TOKEN" > "${SHARED_FOLDER}/k3s_node_token"
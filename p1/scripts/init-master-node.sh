#!/bin/bash
set -e

sudo apt-get update
if ! command -v curl &> /dev/null
then
	echo "curl could not be found, installing..."
	sudo apt-get install -y curl
fi

# Get interface name
ip_master=$(hostname -I | awk '{print $1}')
iface=$(ip -o -4 addr show | grep "$ip_master" | awk '{print $2}')
# Install K3s
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--flannel-iface $iface" sh -
# Wait for K3s to be ready

sudo chmod +x /etc/rancher/k3s/k3s.yaml
K3S_NODE_TOKEN=$(sudo cat /var/lib/rancher/k3s/server/node-token)
echo "K3S_NODE_TOKEN=$K3S_NODE_TOKEN"
echo $K3S_NODE_TOKEN > /vagrant/shared/k3s_node_token
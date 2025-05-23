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
iface=$(ip -o -4 addr show | grep "$MASTER_IP" | awk '{print $2}')
# Install K3s
curl -sfL https://get.k3s.io | \
	INSTALL_K3S_EXEC="--flannel-iface $iface" \
	K3S_KUBECONFIG_MODE="644" \
	sh -
# Wait for K3s to be ready
sudo chmod 644 /etc/rancher/k3s/k3s.yaml
# Create alias like in the subject
echo "alias k='kubectl'" >> /home/vagrant/.bashrc

echo "Waiting node $MASTER..."
kubectl wait --for=condition=Ready node/"$MASTER"
echo "Node $MASTER ready !"

kubectl apply -f "$CONF_FOLDER/deployments.yaml"
kubectl apply -f "$CONF_FOLDER/service.yaml"
kubectl apply -f "$CONF_FOLDER/ingress.yaml"

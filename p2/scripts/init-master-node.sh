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

sudo chmod 644 /etc/rancher/k3s/k3s.yaml
# Create alias like in the subject
echo "alias k='kubectl'" >> /home/vagrant/.bashrc

# Wait for K3s nodes to be ready
echo "Waiting for node to register..."
until kubectl get nodes --no-headers 2>/dev/null | grep -q .; do
  sleep 1
done

NODE_NAME=$(kubectl get nodes -o jsonpath='{.items[0].metadata.name}')
echo "Waiting node $NODE_NAME..."
kubectl wait --for=condition=Ready node/"$NODE_NAME"
echo "Node $NODE_NAME ready !"

kubectl apply -f "$CONF_FOLDER/namespaces.yaml"
kubectl apply -f "$CONF_FOLDER/deployments.yaml"
kubectl apply -f "$CONF_FOLDER/services.yaml"
kubectl apply -f "$CONF_FOLDER/ingress.yaml"

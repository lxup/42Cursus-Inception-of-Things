# INSTALL DEPENDENCIES


# CHECK SUDO ACCESS
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# CURL

# K3D
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
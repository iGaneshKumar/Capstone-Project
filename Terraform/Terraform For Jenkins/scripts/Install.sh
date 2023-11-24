#!/bin/bash

if command -v docker --version &> /dev/null; then
  echo "Docker is already installed."
else
  echo "Installing Docker..."
  sudo apt-get update -y
  sudo apt-get install -y ca-certificates curl gnupg
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg
  echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update -y
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  sudo usermod -aG docker jenkins
  sudo usermod -aG docker ubuntu
fi

if command -v docker-compose --version &> /dev/null; then
  echo "Docker-Compose is already installed."
else
  echo "Installing Docker-Compose..."
  sudo apt install -y docker-compose
  sudo apt install -y unzip
fi

if command -v aws --version &> /dev/null; then
  echo "AWS CLI is already installed."
else
  echo "Installing AWS CLI..."
  sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
fi

# if command -v kubectl version &> /dev/null; then
#   echo "Kubectl is already installed."
# else
#   echo "Installing Kubectl..."
#   sudo apt-get update -y
#   sudo apt-get install -y apt-transport-https ca-certificates curl
#   sudo curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
#   echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
#   sudo apt-get update -y
#   sudo apt-get install -y kubectl
# fi

# if command -v eksctl version &> /dev/null; then
#   echo "eksctl version is already installed."
# else
#   echo "Installing eksctl version..."
#   ARCH=amd64
#   PLATFORM=$(uname -s)_$ARCH
#   sudo curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
#   sudo curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check
#   tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
#   sudo mv /tmp/eksctl /usr/local/bin
# fi

if command -v terraform --version &> /dev/null; then
  echo "Terraform is already installed."
else
  echo "Installing Terraform..."
  sudo wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
  sudo apt update -y && sudo apt install -y terraform
fi
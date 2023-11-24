#!/bin/bash

sudo sleep 10
sudo apt update -y

if command -v java -version &> /dev/null; then
  echo "Java is already installed."
else
  echo "Installing Java..."
  sudo apt install -y fontconfig openjdk-17-jre
fi

if command -v jenkins --version &> /dev/null; then
  echo "Jenkins is already installed."
else
  echo "Installing Jenkins..."
  sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
  echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
  sudo apt-get update
  sudo apt-get install -y jenkins
fi

sudo sleep 5

#Enable Jenkins:
sudo systemctl enable jenkins

# Check if Jenkins is active
if sudo systemctl is-active jenkins &> /dev/null; then
    echo "Jenkins is running"
else
    echo "Jenkins is not running, starting the service"
    sudo systemctl start jenkins
fi

# Host Rename:
sudo hostnamectl set-hostname jenkins
echo 'jenkins ALL=(ALL) NOPASSWD: ALL' | sudo tee -a /etc/sudoers

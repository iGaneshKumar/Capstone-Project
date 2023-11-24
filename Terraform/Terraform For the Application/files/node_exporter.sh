#!/bin/bash

wget https://github.com/prometheus/node_exporter/releases/download/v1.7.0/node_exporter-1.7.0.linux-amd64.tar.gz
tar -xvzf node_exporter-1.7.0.linux-amd64.tar.gz
sudo mv node_exporter-1.7.0.linux-amd64/node_exporter /usr/local/bin/
sudo rm -r node_exporter-1.7.0.linux-amd64*

sudo cp node_exporter.service /etc/systemd/system/

sudo systemctl enable node_exporter
sudo systemctl start node_exporter
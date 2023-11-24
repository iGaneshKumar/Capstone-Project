#!/bin/bash

# Define the name of your Docker container
CONTAINER_NAME1="prometheus"

# Check if the container is running
if docker inspect -f '{{.State.Running}}' "$CONTAINER_NAME1" &>/dev/null; then
    echo "Stopping the running container..."
    sudo docker-compose -f prometheus-docker-compose.yaml down &>/dev/null
fi

# Define the name of your Docker container
CONTAINER_NAME2="alertmanager"

# Check if the container is running
if docker inspect -f '{{.State.Running}}' "$CONTAINER_NAME2" &>/dev/null; then
    echo "Stopping the running container..."
    sudo docker-compose -f prometheus-docker-compose.yaml down &>/dev/null
fi

# Run docker-compose up -d
echo "Starting the containers..."
sudo docker-compose -f prometheus-docker-compose.yaml up -d
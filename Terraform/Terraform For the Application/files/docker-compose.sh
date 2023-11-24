#!/bin/bash

# Name of the Docker container
CONTAINER_NAME="capstone-prod"

# Check if the container is running
if docker inspect -f '{{.State.Running}}' "$CONTAINER_NAME" &>/dev/null; then
    echo "Stopping the running container..."
    docker-compose down
fi

# Start the container
echo "Starting the container..."
docker-compose pull --quiet
docker-compose up -d
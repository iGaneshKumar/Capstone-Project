#!/bin/bash

echo "Building Docker image......"
docker build -t $1 .

#!/bin/bash

set -e

# Docker Hub repository names
PROD_REPO="iganeshkumar/capstone-prod"
DEV_REPO="iganeshkumar/capstone-dev"

# Function to build and push Docker image
build_and_push_image() {
    local branch=$1
    local repo=$2

    echo "Building Docker image for branch: $branch"
    
    . ./build.sh $repo

    # Push the image to the specified repository
    docker push $repo

    # Log out from Docker Hub
    docker logout
}

# Main Jenkins pipeline script
# Check the current branch
CURRENT_BRANCH=${GIT_BRANCH}

if [ "$CURRENT_BRANCH" == "origin/main" ]; then
    # If main branch is merged, build and push to prod repository
    build_and_push_image "main" $PROD_REPO
elif [ "$CURRENT_BRANCH" == "origin/dev" ]; then
    # If dev branch is updated, build and push to dev repository
    build_and_push_image "dev" $DEV_REPO
else
    # For other branches, skip
    echo "No action for branch: $CURRENT_BRANCH"
fi

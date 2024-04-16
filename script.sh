#!/bin/bash

# Function to remove Docker container
remove_container() {
    docker container stop "$1" &> /dev/null
    docker container rm "$1" &> /dev/null
}

# Function to remove Docker image
remove_image() {
    docker image rm "$1" &> /dev/null
}

# Function to install wsl-open if not installed
install_wsl_open() {
    npm install -g wsl-open
}

# Check if wsl-open command is available
if ! command -v wsl-open &>/dev/null; then
    echo "wsl-open is not installed. Installing..."
    install_wsl_open
fi

# Pull the latest image
docker pull hyperzoddevops/hyperzod-ondemand-test

# Remove any existing container
remove_container hyperzod-container

# Remove any existing image
remove_image hyperzoddevops/hyperzod-ondemand-test

# Run the image, exposing port 5000
docker run -d -p 5000:5000 --name hyperzod-container hyperzoddevops/hyperzod-ondemand-test

sleep 5
# Open localhost:5000 in a web browser using wsl-open
wsl-open http://localhost:5000

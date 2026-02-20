#!/bin/bash

if ! command -v rsync &> /dev/null; then
    echo "rsync not found. Attempting to install..."
    if [ -f /etc/redhat-release ]; then
        sudo dnf install -y rsync
    else
        sudo apt update && sudo apt install -y rsync
    fi
fi
mkdir -p ~/rsync/shared-file
CURRENT_USER=$(whoami)
IP_ADDR=$(hostname -I | awk '{print $1}')
echo "RUN THIS ON THE SOURCE COMPUTER:"
echo "rsync -avz /path/to/source/folder/ ${CURRENT_USER}@${IP_ADDR}:rsync/shared-file/"

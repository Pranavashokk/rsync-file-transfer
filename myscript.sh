#!/bin/bash

install_rsync() {
    if ! command -v rsync &> /dev/null; then
        echo "rsync not found. Installing..."
        if command -v dnf &> /dev/null; then sudo dnf install -y rsync
        elif command -v apt &> /dev/null; then sudo apt update && sudo apt install -y rsync
        fi
    fi
}

echo "Are you the sender or reciever?"
echo "1) destination  2)sender"
read -p "select an option (1-2): " ROLE

case $ROLE in
    1)
        
        install_rsync
        mkdir -p ~/rsync/shared-file
        IP_ADDR=$(hostname -I | awk '{print $1}')
        
        echo "MODE: DESTINATION"
        echo "1. make sure SSH is running: sudo systemctl start ssh"
        echo "2. type the command to the sender"
      
        echo "rsync -avzP /path/to/source/folder/ $(whoami)@${IP_ADDR}:~/rsync/shared-file/"
        ;;
    2)
       
        install_rsync
       
        echo "MODE: SOURCE"
        read -p "enter the destination IP address: " DEST_IP
        read -p "enter the destination Username: " DEST_USER
        read -p "enter the FULL path of the folder to send: " SRC_PATH
        
        
        echo "rsync -avzP $SRC_PATH ${DEST_USER}@${DEST_IP}:~/rsync/shared-file/"
        
        read -p "Execute transfer now? (y/n): " CONFIRM
        if [[ $CONFIRM == "y" ]]; then
            rsync -avzP "$SRC_PATH" "${DEST_USER}@${DEST_IP}:~/rsync/shared-file/"
        fi
        ;;
    *)
        
        exit 1
        ;;
esac
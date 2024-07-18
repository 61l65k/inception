#!/bin/bash

setup_docker()
{
    sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.13.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo usermod -aG docker $USER
    newgrp docker
    docker --version
    docker compose version
    echo "Please log out and log back in to apply Docker group membership"
}

setup_minimal_desktop_gui()
{
    sudo apt-get install -y lxde gdm3
    sudo apt-get install -y xorg
    sudo apt-get install -y network-manager-gnome
    sudo dpkg-reconfigure gdm3
    echo "LXDE and gdm3 installation is complete. You can reboot your system to start the graphical environment."
}

setup_dns_to_local()
{
    sudo echo "127.0.0.1 $USER.42.fr" >> /etc/hosts
}


main()
{
    echo -e "This script will setup the docker for you and install minimal desktop GUI and setup DNS to local\n\n"
    echo "Run this script as root user press enter to continue ..."
    read
    setup_docker
    read -p "Do you want to install minimal desktop GUI? [y/n]: " install_gui
    if [ "$install_gui" == "y" ]; then
        setup_minimal_desktop_gui
    fi
    setup_dns_to_local
}

main
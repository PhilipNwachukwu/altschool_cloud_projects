#!/usr/bin/bash

# sudo apt update && sudo apt upgrade -y

# sudo apt install apache2 -y

# sudo apt-get install ca-certificates apt-transport-https software-properties-common wget curl lsb-release -y

# curl -sSL https://packages.sury.org/php/README.txt | sudo bash -x

# sudo apt update && sudo apt upgrade -y

# sudo apt install php8.1 libapache2-mod-php8.1

sudo apt update

apt list --upgradable

sudo apt upgrade

sudo apt install apache2 -y

sudo apt-get install ca-certificates apt-transport-https software-properties-common curl lsb-release -y

curl -sSL https://packages.sury.org/php/README.txt | sudo bash -x

sudo apt update & sudo apt upgrade

sudo apt install php8.1-fpm libapache2-mod-fcgid -y

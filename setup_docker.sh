#!/bin/bash -e

DOCKER_PULL="docker pull reapp/core; docker pull reapp/server; docker pull reapp/testing; docker pull sameersbn/apt-cacher-ng"

if ! docker-compose --version
then
sudo apt-get install -y python-pip
sudo pip install docker-compose
fi

if ! docker --version
then
sudo apt-get update
echo "Install docker prerequisites"
sudo apt-get install -y apt-transport-https ca-certificates linux-image-extra-$(uname -r)

sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo sh -c 'echo "deb https://apt.dockerproject.org/repo ubuntu-$(lsb_release -sc) main" > /etc/apt/sources.list.d/docker.list'

sudo apt-get update
echo "Uninstall old docker"
sudo apt-get purge -y lxc-docker

echo "Install docker"
sudo apt-get install -y docker-engine

sudo service docker restart
sudo usermod -aG docker $(whoami)

sudo su $(whoami) -c "$DOCKER_PULL"

echo "Please log-in again to use IPDE"

else
eval $DOCKER_PULL
fi

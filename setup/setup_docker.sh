#!/bin/bash -e

same_dir=$(cd "${BASH_SOURCE[0]}" && pwd)

case "$(lsb_release -sc)" in
"xenial")
"yakkety")
"zesty")
    if ! docker-compose --version
    then
        sudo apt-get install -y docker-compose
    fi
    if ! docker --version
    then
        sudo apt-get install -y docker.io
        sudo usermod -aG docker $(whoami)
        sudo su $(whoami) -c "$same_dir/pull_images.sh"
        echo "Please log-in again to use IPDE"
    else
        "$same_dir/pull_images.sh"
    fi
    exit
    ;;
*)
    ;;
esac

if ! docker-compose --version
then
    sudo apt-get update
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

    sudo su $(whoami) -c "$same_dir/pull_images.sh"
    echo "Please log-in again to use IPDE"

else
    "$same_dir/pull_images.sh"
fi

# ipde_utils

Docker-based deployment system for ROS-based robot solutions. 

## TL;DR

In this directory:

1. Install docker: `setup/setup_docker.sh` (you might need to log out and in again)
1. `docker-compose up -d` (runs server in detached mode, use `docker-compose stop` for stopping it)
1. source your catkin workspace **optional**
1. `./launch.sh test YOUR_PACKAGE_NAME_OR_DIR LAUNCH_FILE_NAME_OR_PATH` (test is the arbitrary name of the session, whitespace needs to be escaped)


## Set-up

The backend server needs to be started to provide the deployment environment.
In addition a local APT-proxy will be spawned to speed-up sandbox creation.

Intructions can be found in [doc/setup.md](doc/setup.md).

## Command line reference

A full command line reference can be found in [doc/cli.md](doc/cli.md)


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

## Description

Each deployment is run a in *session* with unique ID and a human-readable label.
This enables to maintain different applications or stages in the product lifecycle. 

In order to deploy a robot solution three steps need to be performed

### Configuration

First a labeled session has to be created. In addition to  a database entry, a new docker container will be created as a remote workspace.
Further the roslaunch entrypoint needs to be configures and all source code needs to be uploaded.

### Build

The build container needs to be executed. It will update `apt` and `rosdep` at the first run.
If a `.rosinstall` file was provided, all provided entries will be fetched.
Then all dependencies gets installed with `rosdep`. This step might take some time depending on how many dependencies have to installed.
If the same package was used in another session, it might be read from the apt cache. Further runs will skip already installed packages.
Last but not least the code gets build with catkin.
The resulting container will be committed to a new Docker image.

### Run

A new container will be started from the built images.
It will execute the configured entrypoint (`roslaunch` or `run_tests`).
If another session is already running, it will be stopped beforehand.

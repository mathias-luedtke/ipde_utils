# ipde_utils

## TL;DR

In this directory:

1. Install docker: `./setup_docker.sh` (you might need to log out and in again)
1. `docker-compose up -d` (runs server in detached mode, use `docker-compose down` for stopping it)
1. source your catkin workspace **optional**
1. `./launch.sh test YOUR_PACKAGE_NAME_OR_DIR LAUNCH_FILE_NAME_OR_PATH` (test is the arbitrary name of the session, whitespace needs to be escaped)


## Server

The backend server needs to be started to provide the deployment environment.
In addition a local APT-proxy will be spawned to speed-up sandbox creation.

### Set-up
Install docker(-compose) and pull images: `./setup_docker.sh`. **(requires sudo)**
This script can be rerun to pull updated images.

### Start-up

Run `docker-compose up` in this main folder to start the deployment backend.
The server provides a REST interface at http://127.0.0.1:8000/sessions/ and can be stopped with CTRL+C.

## Client

### Install dependencies
The required dependencies should be already available on most platforms.
For ubuntu you can insall them with: `sudo apt-get install -y bash tar curl sed` **(requires sudo)**

### Scripts

*All scripts read the `IPDE_SESSIONS_URI` environment variable to override the default URI `http://127.0.0.1:8000/sessions/`*

#### helper.bash
Variaous REST api functions, is meant to be sourced.


#### ./list.sh
Print all sessions and their state

#### ./deploy.sh 
`./deploy.sh label package launch_file [extra_paths *]`

Creates/overwrite a session with the given label.
Package can be a name (**Needs ROS setup.bash to be sourced**) or a directory.
The second and third arguments denote the main package and launch file.
All extra paths get uploaded into the session.
VCS paths and hidden files are exluded per default and have to be listed explicitly.

#### ./rm.sh 
`./rm.sh label`

Deletes the session with the given name.

#### ./build.sh 
`./build.sh label`

Builds the session with the given name und print the output.
**Stopping the script  does not stop the build!**

#### ./run.sh 
`./run.sh label`

Runs the session with the given name und print the output.
If another session is already running, it will be stopped.
**Stopping the script does not stop the run!**


#### ./stop.sh 
`./stop.sh label`

Stops the running session with the given name und print the output.

#### ./logs.sh 
`./logs.sh label [build|run] [tail]`

Print the build or run logs for the given session.
For stopped builds/runs the log can be truncated with the tail argument, otherwise logs get streamed.

#### ./launch.sh 
`./launch.sh label package launch_file [extra_paths *]`

Deploys, builds and runs the launchfile.
If the scrpt if interrupted (ctrl+c), the launchfile will be stopped.

#### ./create_external.sh 
`./launch.sh label package launch_file [extra_paths *]`

Cretae session that uses released packagem cannot resolve launch file paths automatically.

#### ./create_test.sh 
`./launch.sh label package [extra_paths *]`

Like `deploy.sh`, but uses creates testing session for given package.

#### ./testing.sh 

Like `launch.sh`, but creates and runs testing session.

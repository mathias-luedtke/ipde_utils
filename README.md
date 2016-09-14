# ipde_utils

## Server

The backend server needs to be started to provide the deployment environment.
In addition a local APT-proxy will be spawned to speed-up sandbox creation.

### Set-up
Install docker(-compose) and pull images: `./setup_docker.sh`. **(requires sudo)**
This script can be rerun to pull updated images.

### Start-up

Run `docker-compose up` in this main folder to start the deployment backend.
The server provides a REST interface at http://127.0.0.1:8000/sessions/ and can be stopped with CTRL+C.

IPDE is based on [Docker](http://docker.io), which needs to be installed first.

# Prerequisites
You will need to install `Docker` and `docker-compose`.
If you run on Ubuntu 16.04 (Xenial) or newer you can use the stock packages `docker.io` and `docker-compose`.

If not, you have to install it from the Docker-hosted servers, as explainded in [here](https://docs.docker.com/engine/installation/linux/ubuntu/).

For convenience you can use the `setup/setup_docker.sh` script on Ubuntu systems, which takes care of all steps.

If you run another Linux distribution or the [Docker Toolbox](https://www.docker.com/products/docker-toolbox), you should run `setup/pull_images.sh` to pull the required images from the Docker Hub.

# Startup

To start the IPDE server and the Apt cacher, just `cd` into the main directory (the one containing `docker-compose.yaml`) and run `docker-compose up`. This will prepare two docker containers and their data volumes.

You can confirm that it is running by visiting http://127.0.0.1:8000/sessions/.
Please note, if you are using the Docker Toolbox on Windows or Mac OS X the server is run into a VirtualBox VM with another IP. You should be able to access it under http://192.168.99.100:8000/sessions/.

# Customization

The server might be configured through addtional settings in `docker-compose.yaml`:
* `SQLALCHEMY_DATABASE_URI` needs to point to the DB to be used
* `APT_EXTRA_OPTS` might be used to customize apt, e.g. to use a proxy or cacher
* `IPDE_TRUSTED_IMAGES` specifies a list of docker images that can be used
* `IPDE_BIND_VOLUMES` can be used to bind host volumes to the running containers
* `hostname` is used to set the hostname of the server and for the ROS core

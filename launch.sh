#!/bin/bash -e

./deploy.sh "$@"
./build.sh $1

trap './stop.sh $1' INT
./run.sh $1
#!/bin/bash -e
help="usage: $0 label packages launch_file [extra_paths *]"

label=$1

./deploy.sh "$@"
./build.sh $label

trap './stop.sh $1' INT
./run.sh $1
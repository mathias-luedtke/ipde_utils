#!/bin/bash -e

./create_test.sh "$@"
./build.sh $1

trap './stop.sh $1' INT
./run.sh $1

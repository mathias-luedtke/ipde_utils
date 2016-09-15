#!/bin/bash -e
source helper.bash

help="usage: $0 label"

label=$1
shift  || error "no label given, $help"

session=$(find_session "$label")

if [ -z "$session" ]
then
  error "could not obtain session URI"
fi

run "$session"
logs "$session" run
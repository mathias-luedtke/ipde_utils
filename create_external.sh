#!/bin/bash -e
source helper.bash

help="usage: $0 label package launch_file [extra_paths *]"

label=$1
shift  || error "no label given, $help"

pkg=$1
shift || error "no package given, $help"

launch=$1
shift || error "no launch file given, $help"

session=$(create_session "$label")

if [ -z "$session" ]
then
  error "could not obtain session URI"
fi

configure_launch "$session" "$pkg" "$launch"

for p in "$@"
do
    send_src "$p" "$session"
done

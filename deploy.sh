#!/bin/bash -e
source helper.bash

help="usage: $0 label packages launch_file [extra_paths *]"

label=$1
shift  || error "no label given, $help"

pkg=$1
shift || error "no packages given, $help"

launch=$1
shift || error "no launch file given, $help"

session=$(create_session "$label")

if [ -z "$session" ]
then
  error "could not obtain session URI"
fi

pkg_dir=$(rospack find "$pkg")

launch_full_path=$(find "$pkg_dir" -name "$launch")
launch_path=${launch_full_path#$pkg_dir/}

configure_launch "$session" "$pkg" "$launch_path"

send_src "$pkg_dir" "$session"

for p in "$@"
do
    send_src "$p" "$session"
done

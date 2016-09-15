#!/bin/bash -e
source helper.bash
builder_image="${IPDE_BUILDER_IMAGE:-reapp/testing}"

help="usage: $0 label package [extra_paths *]"

label=$1
shift  || error "no label given, $help"

pkg=$1
shift || error "no package given, $help"

session=$(create_session "$label")

if [ -z "$session" ]
then
  error "could not obtain session URI"
fi

pkg_dir=$(get_pkg_dir $pkg)

configure_main "$session" "$(get_pkg_name $pkg_dir)"

send_src "$pkg_dir" "$session"

for p in "$@"
do
    send_src "$p" "$session"
done

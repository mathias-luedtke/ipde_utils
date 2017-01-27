#!/bin/bash -e
ipde_utils_path=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=helper.sh
source "$ipde_utils_path/helper.bash"

help="usage: $0 label"

label=$1
shift  || error "no label given, $help"

session=$(find_session "$label")

if [ -z "$session" ]
then
  error "could not obtain session URI"
fi

delete "$session"

#!/bin/bash -e
ipde_utils_path=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=helper.sh
source "$ipde_utils_path/helper.bash"

help="usage: $0 label [build|run] [tail]"

label=$1
shift  || error "no label given, $help"

stage=$1
shift  || error "no stage given, $help"

session=$(find_session "$label")

if [ -z "$session" ]
then
  error "could not obtain session URI"
fi

logs "$session" $stage $1

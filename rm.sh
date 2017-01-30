#!/bin/bash -e
ipde_utils_path=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=helper.sh
source "$ipde_utils_path/helper.bash"

help="usage: $0 label [label*]"

if [ "$#" -eq 0 ]; then
    error "no label(s) given, $help"
fi

for label in "$@"
do
    session=$(find_session "$label")

    if [ -z "$session" ]
    then
      error "could not obtain session URI for '$label'"
    fi

    delete "$session"
done

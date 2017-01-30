#!/bin/bash -e
ipde_utils_path=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

"$ipde_utils_path/deploy.sh" "$@"

session=$1
"$ipde_utils_path/build.sh" "$session"

trap '"$ipde_utils_path/stop.sh" "$session"' INT
"$ipde_utils_path/run.sh" "$session"

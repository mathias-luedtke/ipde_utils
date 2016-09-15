#!/bin/bash
set -e
set -o pipefail

sessions_uri="${IPDE_SESSIONS_URI:-http://127.0.0.1:8000/sessions/}"
builder_image="${IPDE_BUILDER_IMAGE:-reapp/core}"

function error {
    echo $1
    exit ${2/1}
}

function curl_xml {
    curl -H "Accept: application/xml" -sS "$@"
}

function get_sessions {
    curl_xml "$sessions_uri" | grep -o '<ipde:session[^>]*/>' | sed -n 's/.*uri="\([^"]*\)".*/\1/p'
}

function print_session {
    curl_xml "$1" | sed -n -e 's!.*label="\([^"]*\)" uri="\([^"]*\)"[^<]*<ipde:state \([^/]*\).*!\2 (\1): \3\n!p'
}

function get_uri_for_label {
    sed -n "s/.*label=\"$1\" uri=\"\([^\"]*\)\".*/\1/p"
}

function find_session {
    curl_xml "$sessions_uri" | get_uri_for_label $1
}

function create_session {
    curl_xml -F "label=$1" -F "builder_image=$builder_image" -F "reuse=1" "$sessions_uri" | get_uri_for_label $1
}

function upload {
    curl_xml -X PUT -F "${2:-file}=@-" "$1"
}

function configure {
    curl_xml -X PUT -F "config=<-" "$1/config"
}
function configure_launch {
configure "$1" << EOF
<?xml version="1.0" ?>
<ipde:config xmlns:ipde="http://www.reapp-projekt.de/IPDE" xmlns:ros1="http://www.reapp-projekt.de/IPDE/ROS1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="ipde:SessionConfig">
    <ipde:main id="$2" label="$2:$3" launchfile="$3" xsi:type="ros1:Launchfile"/>
    <ipde:world/>
</ipde:config>
EOF
}

function configure_main {
configure "$1" << EOF
<?xml version="1.0" ?>
<ipde:config xmlns:ipde="http://www.reapp-projekt.de/IPDE" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="ipde:SessionConfig">
    <ipde:main id="$2" label="test $2"/>
    <ipde:world/>
</ipde:config>
EOF
}

function get_pkg_dir {
    if [ -f "$1/package.xml" ]
    then 
        (cd "$1"; pwd -P)
    else
        rospack find "$pkg"
    fi
}

function get_pkg_name {
    sed -n -e 's!.*<name>\([^<]*\)</name>.*!\1!p' "$1/package.xml"
}

function configure_pkg_launch {
    local launch_full_path=$(find "$2" -name "$3")
    configure_launch "$1" "$(get_pkg_name $2)" "${launch_full_path#$2/}" 
}

function check_state {
    curl -sS "$1" | grep -q "\"$2\""
}

function build {
    curl -N -X PUT -F "logs=1" "$1/build"
    check_state "$1/build" done
}

function run {
    check_state "$1/build" done || error "build was not succesful"
    curl -sS -X PUT -F "force_switch=1" "$1/run" > /dev/null
    check_state "$1/run" in_progress || error "run failed"
}

function stop {
    curl -sS -X PUT -F "run_state=done" "$1/run" > /dev/null
    check_state "$1/run" done || error "did not stop"
}

function logs {
    curl -N "$1/$2/logs?tail=${3:--1}"
}

function delete {
    curl -X DELETE -sS "$1" > /dev/null
}


function tar_src {
    d=$(dirname "$1")
    if [ -d "$1" ] ; then
        tar --exclude-vcs --exclude-backups -cz -C "$d" "$(basename "$1")"
    else
        tar -cz -C "$d" "${1#$d/}"
    fi    
}

function send_src {
    tar_src $1 | upload "$2/src" file
}

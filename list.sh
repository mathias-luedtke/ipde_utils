#!/bin/bash -e
source helper.bash

for s in $(get_sessions); do print_session $s; done
#!/bin/bash
set -e

PARAMS="$PARAMS -it --rm"
PARAMS="$PARAMS -w /workspace"
PARAMS="$PARAMS -v $PWD:/workspace"
PARAMS="$PARAMS --entrypoint yotta"

docker run $PARAMS mbed/yotta $@
#!/bin/bash
set -e

YTFOLDER=`basename $PWD`
YTSETTINGS=${YOTTA_USER_SETTINGS_DIR:-"$HOME/.yotta"}

PARAMS="$PARAMS -it --rm"
PARAMS="$PARAMS -e YOTTA_USER_SETTINGS_DIR=/settings"
PARAMS="$PARAMS -v $YTSETTINGS:/settings"
PARAMS="$PARAMS -v $PWD:/yotta/$YTFOLDER"
PARAMS="$PARAMS -w /yotta/$YTFOLDER"
PARAMS="$PARAMS --entrypoint yotta"

docker run $PARAMS mbed/yotta $@

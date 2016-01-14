#!/bin/bash
set -e

DOCKER_IMAGE=mbed/yotta
YT_USER=yotta_user
YT_GROUP=yotta_group
YT_HOME=/yotta_home

USER_ID=$(id -u)
GROUP_ID=$(id -g)
YT_WORK_DIR="$YT_HOME/work/$(basename $PWD)"
INT_SETTINGS_DIR="$YT_HOME/.yotta"
EXT_SETTINGS_DIR=${YOTTA_USER_SETTINGS_DIR:-"$HOME/.yotta"}

PARAMS="$PARAMS -it --rm"
PARAMS="$PARAMS -e YOTTA_USER_SETTINGS_DIR=$INT_SETTINGS_DIR"
PARAMS="$PARAMS -v $EXT_SETTINGS_DIR:$INT_SETTINGS_DIR"
PARAMS="$PARAMS -v $PWD:$YT_WORK_DIR"
PARAMS="$PARAMS -w $YT_WORK_DIR"

run_yotta()
{
  echo \
    groupadd -f -g $GROUP_ID $YT_GROUP '&&' \
    useradd -u $USER_ID -g $YT_GROUP $YT_USER '&&' \
    chown -R $YT_USER:$YT_GROUP $YT_HOME '&&' \
    sudo -u $YT_USER HOME=$YT_HOME yotta
}

if [ -z "$DOCKER_HOST" ]; then
    eval docker run $PARAMS $DOCKER_IMAGE /bin/bash -ci "'$(run_yotta) $@'"
else
    eval docker run $PARAMS $DOCKER_IMAGE yotta $@
fi
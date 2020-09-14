#!/bin/bash

function get_xprop {
    # $1 = xprop, $2 = prop
    echo "$(echo "$1" | grep -m 1 "$2" | cut -d " " -f3)"
}

#Terminal is passed in
set -e

ID=$(xdpyinfo | grep focus | cut -f4 -d " " | cut -f1 -d ",")
XPROP=$(xprop -id $ID)
TERM_NAME=$(get_xprop "$XPROP" "WM_CLASS" | cut -d '"' -f2)

if [ "$TERM_NAME" != "$1" ]; then
    # Not a terminal, open in default path
    rm /tmp/.i3_i_am_here
    exit 0
fi

TERM_PPID=$(get_xprop "$XPROP" "_NET_WM_PID")
PID_NAME=$(get_xprop "$XPROP" "_NET_WM_NAME" | cut -d '"' -f2)
TERM_PID=$(ps -o pid=,comm=, --ppid $TERM_PPID | grep -m 1 $PID_NAME \
    | awk -F' ' '{print $1}')

if [ -e "/proc/$TERM_PID/cwd" ]; then
    readlink /proc/$TERM_PID/cwd > /tmp/.i3_i_am_here
fi

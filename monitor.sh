#!/bin/bash
# /lib/systemd/system-sleep/monitor.sh

case $1/$2 in
  post/*)
    sleep 1
    export DISPLAY=:0
    export XAUTHORITY=/var/run/lightdm/root/:0
    if /usr/bin/xrandr | grep -q "DP-1 connected\|HDMI-1 connected"; then
        /usr/bin/xrandr --auto
    fi
    ;;
esac

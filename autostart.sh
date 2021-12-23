#!/usr/bin/env sh

autostart(){
    nitrogen --restore &
    stalonetray &
    nm-applet &
    killall nm-applet > /dev/null
    nm-applet &
    volumeicon &
    setxkbmap es &
    xsetroot -cursor_name left_ptr &
}

main(){
    autostart
}

main


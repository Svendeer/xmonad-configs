#!/usr/bin/env sh

checkCaps(){

    capsStatus=$(xset q | grep Caps | awk '{printf $4}')

    if [[ $capsStatus == "on" ]]; then
        killall dunst
        dunstify -u low "CAPS is enabled."
    fi
}

main(){

    while true 
    do
        checkCaps
        sleep 1
    done
}

main

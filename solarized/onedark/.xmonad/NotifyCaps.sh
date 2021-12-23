#!/usr/bin/env sh

checkCaps(){

    capsStatus=$(xset q | grep Caps | awk '{printf $4}')
    iconDir="$HOME/.config/dunst"
    iconName="capslock-icon.png"

    if [[ $capsStatus == "on" ]]; then
        killall dunst
        dunstify -i $iconDir/$iconName "CAPS LOCK is enabled."
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

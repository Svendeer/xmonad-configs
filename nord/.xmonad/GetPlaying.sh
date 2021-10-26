#!/usr/bin/env bash

getStatus(){
    status=$(playerctl status)
}

sendMessageToBar(){
    if [[ $status == "No players found" ]]; 
    then
        echo -ne "No media playing here."
    else
        echo $(playerctl metadata title)
    fi
}

main(){
    while true; do
        sendMessageToBar
        sleep 0.1
    done
}

main


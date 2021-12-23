#!/bin/env bash

function takeScreenshot(){
    scrot -q 100 '%Y-%m-%d-%H-%M-%s_$wx$h.png' -e 'mv $f ~/Pictures/Screenshots'
}

#function notifyForScreenshotTaken(){
#    sleep 2
#    notify-send "Screenshot taken successfully."
#}

function main(){
    takeScreenshot
#    notifyForScreenshotTaken
}

main


#!/usr/bin/env sh

getSongRoute(){
    songRoute=$(cmus-remote -Q | grep -i file | awk '{for (x=2;x<=NF;x++) printf $x " "; print ""}' | sed "s/\(.\)$/\'/")
}

main(){
    getSongRoute
}

main


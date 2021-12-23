#!/bin/env bash
getSong(){
    song=$(cmus-remote -Q | awk '/tag title/  {$1=$2=""; t=$0} END {print b t}')
    echo $song
}

while :; do
    echo "Playing: $(getSong)"
    sleep 0.1
done

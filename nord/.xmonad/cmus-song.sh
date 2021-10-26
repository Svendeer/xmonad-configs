#!/usr/bin/env sh
getSong(){
    song=$(cmus-remote -Q | awk '/tag title/  {$1=$2=""; t=$0} END {print b t}')
    echo $song
}

while :; do
    echo " $(getSong) "
    sleep 0.1
done

#!/usr/bin/env sh

runTrayer(){
	trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --monitor 0 --transparent false --alpha 0 --tint 0x0B2639 --height 25% &
}

main(){

	killall Trayer > /dev/null 2>&1
	
	while :; do
		runTrayer
		sleep 1
	done
}

main

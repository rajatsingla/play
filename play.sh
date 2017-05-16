#!/bin/bash
# play 0.1
# Author: Rajat Singla

MUSICDIR=""

oIFS=$IFS
IFS=$'\n'
M=$(find $MUSICDIR -iname "*$1*.*")
I=0
for V in $M; do
	I=$((I+1))
done
if [ $I -le 1 ]; then
	T=$(echo ${V:$(expr length $MUSICDIR)})
	echo -e "\e[4m>> $T"
	tput sgr0
	mplayer -novideo "$M" > /dev/null 2>&1
	xdotool windowactivate $WINDOWID
fi
if [ $I -gt 1 ]; then
	I=0
	for V in $M; do
		T=$(echo ${V:$(expr length $MUSICDIR)})
		echo -en "\e[1m$I)"
		tput sgr0
		echo " $T"
		I=$((I+1))
	done		
	echo ""
	echo -ne "\e[1mSelection:"
	tput sgr0
	echo -n " "
	read S
	I=0
	for V in $M; do
		if [ $I == $S ]; then
			T=$(echo ${V:$(expr length $MUSICDIR)})
			echo -e "\e[4m>> $T"
			tput sgr0
			mplayer -novideo "$V" > /dev/null 2>&1
			xdotool windowactivate $WINDOWID
			break
		fi
		I=$((I+1))
	done
fi
IFS=$oIFS

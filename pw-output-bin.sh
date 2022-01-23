#!/bin/bash



#echo "$(wpctl status | sed -n '/Audio/,/Video/p' | sed -n '/Sinks/,/Sink endpoints/p' | sed '1d;$d' | sed 's/[│]//g')"


output="$(wpctl status \
    | sed -n '/Audio/,/Video/p' \
    | sed -n '/Sinks/,/Sink endpoints/p' \
    | sed '1d;$d' | sed 's/[│]//g' \
    | sed '/^[[:space:]]*$/d' \
    | sed 's/\[[^]]*\]//g')"

readarray -t array <<<"$output"



for i in "${array[@]}"
do
	i="$(echo "$i" |  tr -d "*" | sed 's/^[ \t]*//')"

    if [ x"$@" = x"$i" ]
    then
	    sink="$(sed 's/^[^0-9]*\([0-9]\+\).*$/\1/' <<< "$i")"

	    wpctl set-default $sink
	    notify-send.sh "Active output device" "$(echo "$i" | tr -d "$sink" | tr -d . | sed 's/^[ \t]*//')" -u low --icon=speaker 
        exit 0
	    
    fi
	
done 


active=111

for i in "${!array[@]}"
do

    echo "${array[$i]}" |  tr -d "*" | sed 's/^[ \t]*//'

    if echo x"${array[$i]}" | grep '*' > /dev/null; then 
        active="$i"
    fi
   	
done

echo -en "\x00prompt\x1fPipeWire  \n"
echo -en "\x00active\x1f$active\n"
echo -en "\0message\x1fChoose audio output\n"	

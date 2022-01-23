#!/usr/bin/env bash
theme="style_2"

dir="$HOME/.config/rofi/launchers/text"
styles=($(ls -p --hide="colors.rasi" $dir/styles))
color="${styles[1]}"

@import "styles/colors.rasi"

# comment this line to disable random colors
sed -i -e "s/@import .*/@import \"$color\"/g" $dir/styles/colors.rasi

# comment these lines to disable random style
#themes=($(ls -p --hide="launcher.sh" --hide="styles" $dir))
#theme="${themes[$(( $RANDOM % 7 ))]}"

rofi -show pw -modi "pw:pw-output-bin.sh" -theme $dir/"$theme" -monitor DP-1 -theme-str 'window {width: 750; height: 300;} entry {enabled: false;} element alternate.active {
    background-color: 				@green;
    text-color:       				@bg;
}'


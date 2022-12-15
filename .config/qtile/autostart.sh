#!/bin/sh

lxsession &
nitrogen --restore &
pgrep -x xcompmgr > /dev/null || xcompmgr &
sxhkd || pkill -USR1 -x sxhkd &
dunst --config $HOME/.config/dunst/dunstrc &
setxkbmap -model pc104 -layout us,ru -variant ,, -option grp:alt_shift_toggle

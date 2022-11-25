#!/bin/sh

lxsession &
nitrogen --restore &
pgrep -x xcompmgr > /dev/null || xcompmgr &
pgrep -x sxhkd > /dev/null || sxhkd -c $HOME/.config/i3/sxhkd/sxhkdrc &
dunst --config $HOME/.config/dunst/dunstrc &
# /usr/bin/emacs --daemon &
$HOME/.config/polybar/launch.sh &
setxkbmap -model pc104 -layout us,ru -variant ,, -option grp:alt_shift_toggle

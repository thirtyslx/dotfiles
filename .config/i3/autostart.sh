#!/bin/sh

lxsession &
nitrogen --restore &
killall sxhkd &
sxhkd -c $HOME/.config/i3/sxhkd/sxhkdrc &
dunst --config $HOME/.config/dunst/dunstrc &
/usr/bin/emacs --daemon &
$HOME/.config/polybar/launch.sh &
setxkbmap -model pc104 -layout us,ru -variant ,, -option grp:alt_shift_toggle &
autotiling

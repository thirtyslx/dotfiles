#!/bin/sh

# i3
# sxhkd -c ~/.config/i3/sxhkd/sxhkdrc
# exec i3

# bspwm
# sxhkd -c ~/.config/bspwm/sxhkd/sxhkdrc &
# $HOME/.config/bspwm/bspwmrc
# exec bspwm

# qtile
# sxhkd
# exec qtile

# exec dwm
lxsession &
# setbg ~/.config/wall.png
# nitrogen --restore &
# pgrep -x xcompmgr > /dev/null || xcompmgr &
# pgrep -x picom > /dev/null 2>&1 || picom --experimental-backends &
sxhkd &
dunst --config $HOME/.config/dunst/dunstrc &
# $HOME/.config/polybar/launch.sh bspwm &
# setxkbmap -model pc104 -layout us,ru -variant ,, -option grp:alt_shift_toggle &
setxkbmap us,ru -option 'grp:alt_shift_toggle' &
#setxkbmap -option caps:swapescape &
#setxkbmap -option caps:escape &
# Replace capslock with escape
#xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' &
setxkbmap -option caps:super &
xset r rate 300 30 &
setbg ~/.config/wall.png && xdotool key Super+F5 &
xsetroot -name "thirtysix's dwm build [36\"]" &
mpd &
#startup &
# startup &
unclutter &
xcompmgr &
xwallpaper --zoom $(readlink ~/.local/share/wall.png) &
pipewire &
pipewire-pulse &
wireplumber &
# exec bspwm
#exec dwm
while type dwm >/dev/null ; do dwm && continue || break ; done

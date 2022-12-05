#     _            ____                 _
#    / \   ___ ___| __ ) _ __ ___  __ _| | _____ _ __
#   / _ \ / __/ __|  _ \| '__/ _ \/ _` | |/ / _ \ '__|
#  / ___ \\__ \__ \ |_) | | |  __/ (_| |   <  __/ |
# /_/   \_\___/___/____/|_|  \___|\__,_|_|\_\___|_|
#
# http://www.gitlab.com/assbreaker/
#
# My bash config. Not much to see here; just some pretty standard stuff.

### EXPORT ###
export TERM="xterm-256color"                         # Getting proper colors
export EDITOR="nvim"                                 # $EDITOR use nvim in terminal
export VISUAL="nvim"                                 # $VISUAL use nvim in GUI mode
export BROWSER="librewolf"                           # $BROWSER use librewolf
export HISTCONTROL=ignoredups:erasedups              # No duplicate entries in history
export PATH="$HOME/.scripts:$PATH"                   # Adding scripts to the $PATH

### MANPAGER ###
# "bat" as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# "vim" as manpager
#export MANPAGER='/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'
# "nvim" as manpager
#export MANPAGER="nvim -c 'set ft=man' -"

### SET VI MODE ###
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

### PROMPT ###
export PS1="\e[1;34m \w\e[m\e[0;35m $ \e[m"

### PATH ###
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/Applications" ] ;
  then PATH="$HOME/Applications:$PATH"
fi

### SETTING OTHER ENVIRONMENT VARIABLES ###
if [ -z "$XDG_CONFIG_HOME" ] ; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi
if [ -z "$XDG_DATA_HOME" ] ; then
    export XDG_DATA_HOME="$HOME/.local/share"
fi
if [ -z "$XDG_CACHE_HOME" ] ; then
    export XDG_CACHE_HOME="$HOME/.cache"
fi

### CHANGE TITLE OF TERMINALS ###
case ${TERM} in
  xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|alacritty|st|konsole*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
        ;;
  screen*)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
    ;;
esac

### SHOPT ###
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize # checks term size when bash regains control

### ALIASES ###

# root privileges
alias doas="doas --"

# Sudo not required for some system commands
for command in mount umount sv updatedb su shutdown poweroff reboot; do
	alias $command="sudo $command"
done; unset command

# Navigation up
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'

# vim and emacs
alias vim="nvim"
alias em="/usr/bin/emacs -nw"
alias emacs="emacsclient -c -a 'emacs'"
alias doomsync="~/.emacs.d/bin/doom sync"
alias doomdoctor="~/.emacs.d/bin/doom doctor"
alias doomupgrade="~/.emacs.d/bin/doom upgrade"
alias doompurge="~/.emacs.d/bin/doom purge"

# Changing "ls" to "exa"
alias ls='exa -a --icons --color=always --group-directories-first'  # my preferred listing
alias ll='exa -l  --icons --color=always --group-directories-first' # long format
alias lt='exa -aT --color=always --group-directories-first'         # tree listing
alias l.='exa -a | egrep "^\."'                                     # all dotfiles

# pacman and yay
alias psyu='sudo pacman -Syu'                    # update only standard pkgs
alias psyyu='sudo pacman -Syyu'                  # Refresh pkglist & update standard pkgs
alias yaysua='yay -Sua --noconfirm'              # update only AUR pkgs (yay)
alias yaysyu='yay -Syu --noconfirm'              # update standard pkgs and AUR pkgs (yay)
alias parsua='paru -Sua --noconfirm'             # update only AUR pkgs (paru)
alias parsyu='paru -Syu --noconfirm'             # update standard pkgs and AUR pkgs (paru)
alias unlock='sudo rm /var/lib/pacman/db.lck'    # remove pacman lock
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'  # remove orphaned packages

# get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# Colorize output
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias pacman='pacman --color always'
alias ip='ip -color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# Adding flags
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias lynx='lynx -cfg=~/.lynx/lynx.cfg -lss=~/.lynx/lynx.lss -vikeys'
alias ncmpcpp='ncmpcpp ncmpcpp_directory=$HOME/.config/ncmpcpp/'
alias mocp='mocp -M "$XDG_CONFIG_HOME"/moc -O MOCDir="$XDG_CONFIG_HOME"/moc'

# ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# Merge Xresources
alias merge='xrdb -merge ~/.Xresources'

# git
alias add='git add'
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias stat='git status'     # 'status' is protected name so using 'stat' instead
alias tag='git tag'
alias newtag='git tag -a'

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# gpg encryption
# verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
# receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

# yt-dlp
alias yta-aac="yt-dlp --extract-audio --audio-format aac "
alias yta-best="yt-dlp --extract-audio --audio-format best "
alias yta-flac="yt-dlp --extract-audio --audio-format flac "
alias yta-m4a="yt-dlp --extract-audio --audio-format m4a "
alias yta-mp3="yt-dlp --extract-audio --audio-format mp3 "
alias yta-opus="yt-dlp --extract-audio --audio-format opus "
alias yta-vorbis="yt-dlp --extract-audio --audio-format vorbis "
alias yta-wav="yt-dlp --extract-audio --audio-format wav "
alias ytv-best="yt-dlp -f bestvideo+bestaudio "
alias yt="yt-dlp -f bestvideo+bestaudio "
alias yta="yt-dlp --extract-audio --audio-quality 0 --audio-format opus --add-metadata -o '%(artist)s - %(title)s.%(ext)s'"
alias ytap="yt-dlp --extract-audio --audio-quality 0 --audio-format opus --add-metadata -o '%(playlist)s/%(playlist_index)02d. %(artist)s - %(title)s.%(ext)s'"

# Switch between shells
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"

# Switch between display managers
alias tolightdm="sudo pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings --noconfirm --needed ; sudo systemctl enable lightdm.service -f ; echo 'Lightm is active - reboot now'"
alias tosddm="sudo pacman -S sddm --noconfirm --needed ; sudo systemctl enable sddm.service -f ; echo 'Sddm is active - reboot now'"
alias toly="sudo pacman -S ly --noconfirm --needed ; sudo systemctl enable ly.service -f ; echo 'Ly is active - reboot now'"
alias togdm="sudo pacman -S gdm --noconfirm --needed ; sudo systemctl enable gdm.service -f ; echo 'Gdm is active - reboot now'"

# bare git repo alias for dotfiles
alias config="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"

# the terminal rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

# Common commands that are too long
alias e="$EDITOR"
alias v="vim"
alias ka="killall"
alias xp="xprop | grep WM_CLASS"
alias p="sudo pacman"
alias r="/bin/rm"
alias g="git"
alias s="startx"
alias c="clear"

# Make multiple directorys at once
alias mkd="mkdir -pv"

# Fast cds
alias sc="cd ~/.scripts"
alias bm="vim ~/.local/share/bookmarks"

# Copy the last command
alias lc='echo "$(history | head -2 | sed "s/  [0-9]*  //;2d")" > /tmp/cmdoutput && cat /tmp/cmdoutput | xsel -b && notify-send "Terminal" "Last Command Copied"'

# Userlist
alias userlist="cut -d: -f1 /etc/passwd | sort"

# Update grub config
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

# Check for new fonts
alias update-fc='sudo fc-cache -fv'

# Hardware information
alias hw="hwinfo --short"

# Check audio server
alias audio="pactl info | grep 'Server Name'"

# Largest files in directory
alias ducks="du -cks * | sort -rn | head"

# Logout
alias logout="pkill -KILL -u $USER"

### STARSHIP PROMT ###
# eval "$(starship init bash)"

#     _            ____                 _
#    / \   ___ ___| __ ) _ __ ___  __ _| | _____ _ __
#   / _ \ / __/ __|  _ \| '__/ _ \/ _` | |/ / _ \ '__|
#  / ___ \\__ \__ \ |_) | | |  __/ (_| |   <  __/ |
# /_/   \_\___/___/____/|_|  \___|\__,_|_|\_\___|_|
#
# http://www.gitlab.com/assbreaker/
#
# My fish config. Not much to see here; just some pretty standard stuff.

### EXPORT ###
set fish_greeting                                 # Supresses fish's intro message
set TERM "xterm-256color"                         # Getting proper colors
set EDITOR "nvim"                                 # $EDITOR use nvim in terminal
set VISUAL "nvim"                                 # $VISUAL use nvim in GUI mode
set BROWSER "librewolf"                           # $BROWSER use librewolf
set -x PATH $HOME/.scripts $PATH                  # Adding scripts to the $PATH

### SET VI MODE ###
fish_vi_key_bindings

### PATH ###
# First line removes the path; second line sets it.  Without the first line,
# your path gets massive and fish becomes very slow.
set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $fish_user_paths

### MANPAGER ###
# "bat" as manpager
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
# "vim" as manpager
#set -x MANPAGER '/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'
# "nvim" as manpager
#set -x MANPAGER "nvim -c 'set ft=man' -"

### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

### FUNCTIONS ###
# Functions needed for !! and !$
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end
# The bindings for !! and !$
if [ "$fish_key_bindings" = "fish_vi_key_bindings" ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end
### END OF FUNCTIONS ###

### ALIASES ###

# Root privileges
alias doas="doas --"

# Navigation up
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# vim and emacs
alias vim='nvim'
alias em='/usr/bin/emacs -nw'
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

# Get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# Colorize output
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias pacman='pacman --color always'

# Confirm before overwriting something
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
alias pom='push origin main'

# Get error messages from journalctl
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
alias tolxdm="sudo pacman -S lxdm --noconfirm --needed ; sudo systemctl enable lxdm.service -f ; echo 'Lxdm is active - reboot now'"

# bare git repo alias for dotfiles
alias config="/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"

# the terminal rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

# Mocp must be launched with bash instead of Fish!
alias mocp="bash -c mocp"

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
eval (starship init fish)

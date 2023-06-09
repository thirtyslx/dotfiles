# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments
setopt inc_append_history     # save history from all session
setopt hist_ignore_dups

# History in config directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CONFIG_HOME:-$HOME/.config}/zsh/history"

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shortcuts" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shortcuts"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/nameddirs" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/nameddirs"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' '^ulfcd\n'

# move by word with ctrl + arrow keys
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Calculator
bindkey -s '^a' '^ubc -lq\n'

# FuzzyCd
fcd() {
    dir="$(find "$HOME" -type d 2>/dev/null | fzf)"
    [ -d "$dir" ] && cd "$dir" || return 1
    unset dir
}
bindkey -s '^f' '^ufcd\n'

# Fixing delete key
bindkey "\e[3~" delete-char

# Reverse search
bindkey '^r' history-incremental-search-backward

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '\e[3~' vi-delete-char
bindkey -M vicmd '^e' edit-command-line

# Starship promt
# eval "$(starship init zsh)"

# Fish like autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
[ -f "${XDG_CACHE_HOME:-$HOME/.cache}/wal/colors" ] && export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=$(sed -n '2p' $HOME/.cache/wal/colors)"

# Load syntax highlighting; should be last.
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

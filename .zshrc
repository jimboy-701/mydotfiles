HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
bindkey -e
zstyle :compinstall filename '/home/jma/.zshrc'
autoload -Uz compinit; compinit
autoload -Uz add-zsh-hook

# https://wiki.archlinux.org/index.php/Umask
# This setting gives read and write permissions for new files, and read, write and execute
# permissions for new folders
umask 077

# http://zsh.sourceforge.net/Intro/intro_16.html
# setopt autocd
# setopt cdablevars
# setopt correct
# setopt correctall
# setopt globdots
setopt extendedglob
setopt +o nomatch               # See aliases section "lh, lhl" below
setopt interactivecomments
setopt rcquotes
setopt sunkeyboardhack
unsetopt caseglob

# https://pissedoffadmins.com/os/my-zshrc.html
setopt APPEND_HISTORY           # append rather than overwrite history file
setopt INC_APPEND_HISTORY       # write after each command
setopt EXTENDED_HISTORY         # save timestamp and runtime information
setopt SHARE_HISTORY            # share history between sessions
setopt HIST_EXPIRE_DUPS_FIRST   # allow dups, but expire old ones when I hit HISTSIZE
setopt HIST_FIND_NO_DUPS        # don't find duplicates in history
setopt HIST_IGNORE_ALL_DUPS     # ignore duplicate commands regardless of commands in between
setopt HIST_IGNORE_DUPS         # ignore duplicate commands
setopt HIST_REDUCE_BLANKS       # leave blanks out
setopt HIST_SAVE_NO_DUPS        # don't save duplicates
setopt NO_CASE_GLOB             # case insensitive globbing
setopt NUMERIC_GLOB_SORT        # numeric glob sort
setopt PUSHD_MINUS              # this reverts the +/- operators
setopt AUTO_PUSHD
setopt PUSHD_TO_HOME
setopt PUSHD_SILENT
setopt PUSHD_IGNORE_DUPS

DIRSTACKFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/dirs"
if [[ -f "$DIRSTACKFILE" ]] && (( ${#dirstack} == 0 )); then
	dirstack=("${(@f)"$(< "$DIRSTACKFILE")"}")
	[[ -d "${dirstack[1]}" ]] && cd -- "${dirstack[1]}"
fi

chpwd_dirstack() { print -l -- "$PWD" "${(u)dirstack[@]}" > "$DIRSTACKFILE" }
add-zsh-hook -Uz chpwd chpwd_dirstack

DIRSTACKSIZE='20'

# Remove exec permissions from all files within the current & sub directories
rmexec() { fd --hidden --type x --glob '*.?*' -x chmod -v a-x }

# Auto-list directory contents on cd
auto-ls () { ls --color --group-directories-first --classify; }
chpwd_functions=( auto-ls $chpwd_functions )

alias python='clear; python -i -q'
alias pwsh='clear; pwsh-preview -NoLogo'
alias powershell='clear; pwsh-preview -NoLogo'

alias l="ls --color --classify --group-directories-first"
alias ll="ls -l --color --classify --group-directories-first"
alias la="ls -a --color --classify --group-directories-first"
alias lla="ls -la --color --classify --group-directories-first"

alias lss="ls -sh --color --classify --group-directories-first"
alias lsh="ls -ash --color --classify --group-directories-first"

# How to get rid of “zsh: no matches found: .?*”
# https://unix.stackexchange.com/questions/310540/how-to-get-rid-of-no-match-found-when-running-rm
alias lh="ls -d --color --classify --group-directories-first .?* 2>/dev/null"
alias lhl="ls -ld --color --classify --group-directories-first .?* 2>/dev/null"

alias dl="ls -d --color --classify */"
alias dll="ls -ld --color --classify */"
alias lt="exa -T"

alias ..="cd .."
alias ...="cd .. ; cd .."
alias ds="dirs -v"

alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -iv"

alias df="df -h"
alias lsblk="lsblk -f"

alias opkgs="pacman -Qdt"       # Query pacman for packages for Orphans
alias ipkgs="pacman -Qi"        # Get information on installed package
alias rpkgs="sudo pacman -Rn"   # Uninstall only the package leaving it's dependencies
alias rmpkgs="sudo pacman -Rns" # Uninstall a package and its dependencies
alias trpkgs="pactree -c"       # To view the dependency tree of a package

# Query pacman with fzf
alias spkgs="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"

# If you want to add package file list in preview - may be a bit slower updating preview window (make sure you run pacman -Fy at least
# once before invocation to sync the pacman file database)
# Query below seems broken
alias fpkgs="pacman -Slq | fzf --multi --preview 'cat <(pacman -Si {1}) <(pacman -Fl {1} | awk "{print \$2}")' | xargs -ro sudo pacman -S"

# Push updated .zshrc settings to enviroment
alias update="source ~/.zshrc"

source /usr/share/doc/pkgfile/command-not-found.zsh

# Initialize the Zsh plugin manager Antibody (replacement for the slower Antigen)
# https://getantibody.github.io/
source <(antibody init)
antibody bundle < ~/.zsh/zsh_plugins.txt

# User Antibody to load oh-my-zsh plugins
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
antibody bundle robbyrussell/oh-my-zsh path:plugins/git
antibody bundle robbyrussell/oh-my-zsh path:plugins/sudo

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[H' beginning-of-line                               # Home key
bindkey '^[[F' end-of-line                                     # End key

# Load fzf command-line fuzzy finder
# https://github.com/junegunn/fzf
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

# Colored directory listings
eval $(dircolors -b $HOME/.dircolors)
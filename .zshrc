HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
bindkey -e
zstyle :compinstall filename '/home/jma/.zshrc'
autoload -Uz compinit; compinit
autoload -Uz add-zsh-hook

umask 077

# http://zsh.sourceforge.net/Intro/intro_16.html
# setopt autocd
# setopt cdablevars
setopt correct
setopt correctall
setopt globdots
setopt extendedglob
setopt +o nomatch               # See aliases section "lh, lhl" below
setopt interactivecomments
setopt rcquotes
setopt sunkeyboardhack

# https://pissedoffadmins.com/os/my-zshrc.html
setopt APPEND_HISTORY           # append rather than overwrite history file.
setopt EXTENDED_HISTORY         # save timestamp and runtime information
setopt HIST_EXPIRE_DUPS_FIRST   # allow dups, but expire old ones when I hit HISTSIZE
setopt HIST_FIND_NO_DUPS        # don't find duplicates in history
setopt HIST_IGNORE_ALL_DUPS     # ignore duplicate commands regardless of commands in between
setopt HIST_IGNORE_DUPS         # ignore duplicate commands
setopt HIST_REDUCE_BLANKS       # leave blanks out
setopt HIST_SAVE_NO_DUPS        # don't save duplicates
setopt INC_APPEND_HISTORY       # write after each command
setopt PUSHD_IGNORE_DUPS
setopt SHARE_HISTORY            # share history between sessions
setopt NO_CASE_GLOB             # case insensitive globbing
setopt NUMERIC_GLOB_SORT        # numeric glob sort
unsetopt caseglob

# binaries installed by python pip (for working with vscode)
export PATH=/home/jma/.local/bin:$PATH

DIRSTACKFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/dirs"
if [[ -f "$DIRSTACKFILE" ]] && (( ${#dirstack} == 0 )); then
	dirstack=("${(@f)"$(< "$DIRSTACKFILE")"}")
	[[ -d "${dirstack[1]}" ]] && cd -- "${dirstack[1]}"
fi
chpwd_dirstack() {
	print -l -- "$PWD" "${(u)dirstack[@]}" > "$DIRSTACKFILE"
}
add-zsh-hook -Uz chpwd chpwd_dirstack

DIRSTACKSIZE='20'

setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME
## Remove duplicate entries
setopt PUSHD_IGNORE_DUPS
## This reverts the +/- operators.
setopt PUSHD_MINUS

# Set some preferences
export EDITOR=/user/bin/nano
export VISUAL=/usr/bin/nano
export PAGER=/usr/bin/less
export PYTHONSTARTUP=".pythonrc.py"

alias update="source ~/.zshrc"

alias python='clear; python -i -q'
alias pwsh='clear; pwsh-preview -NoLogo'
alias powershell='clear; pwsh-preview -NoLogo'
alias vi=/usr/bin/nano

# Auto-list directory contents on cd
auto-ls () { ls --color --group-directories-first --classify; }
chpwd_functions=( auto-ls $chpwd_functions )

# Let's be lazy as possible when listing directories
alias l="ls --color --classify --group-directories-first"
alias ll="ls -l --color --classify --group-directories-first"
alias la="ls -a --color --classify --group-directories-first"
alias lla="ls -la --color --classify --group-directories-first"

# How to get rid of “zsh: no matches found: .?*”
# https://unix.stackexchange.com/questions/310540/how-to-get-rid-of-no-match-found-when-running-rm
alias lh="ls -d --color --classify --group-directories-first .?* 2>/dev/null"
alias lhl="ls -ld --color --classify --group-directories-first .?* 2>/dev/null"

alias dl="ls -d --color --classify */"
alias dll="ls -ld --color --classify */"
alias lt="exa -T"

alias ..="cd .."
alias ds="dirs -v"

alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"

source /usr/share/doc/pkgfile/command-not-found.zsh

# Initialize the Zsh plugin manager Antibody (replacement for the slower Antigen)
# https://getantibody.github.io/
source <(antibody init)
antibody bundle < ~/.zsh/zsh_plugins.txt

export YSU_MESSAGE_POSITION="after"
export STARSHIP_CONFIG="~/.starship.toml"

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
export FZF_DEFAULT_OPS="--extended"

# Over-ride fzf's default search command and use fd-search
# https://github.com/sharkdp/fd
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r

eval $(dircolors -b $HOME/.dircolors)

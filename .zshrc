HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
zstyle :compinstall filename '/home/jma/.zshrc'
autoload -Uz compinit; compinit
autoload -Uz add-zsh-hook

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
alias lh="ls -d --color --classify --group-directories-first .??*"
alias lhl="ls -ld --color --classify --group-directories-first .??*"
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
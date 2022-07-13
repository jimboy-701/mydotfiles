export EDITOR=/user/bin/nano
export VISUAL=/usr/bin/nano
export PAGER=/usr/bin/less

# binaries installed by python pip (for working with vscode)
export PATH=/home/jma/.local/bin:/opt/cross/bin:$PATH
export PYTHONSTARTUP=~/.pythonrc.py

# export YSU_MESSAGE_POSITION="after"
# export STARSHIP_CONFIG="~/.starship.toml"

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r

# fzf command-line fuzzy finder
export FZF_DEFAULT_OPS="--extended"

# Over-ride fzf's default search command and use fd-search
# https://github.com/sharkdp/fd
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

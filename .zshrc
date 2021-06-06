HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
bindkey -e
zstyle :compinstall filename '/home/jma/.zshrc'
autoload -Uz compinit; compinit
autoload -Uz add-zsh-hook
autoload -U zmv

# https://wiki.archlinux.org/index.php/Umask
# This setting gives read and write permissions for new files, and read, write and execute
# permissions for new folders
#
umask 077

# http://zsh.sourceforge.net/Intro/intro_16.html
# setopt autocd
# setopt cdablevars
# setopt correct
# setopt correctall
# setopt globdots
#
setopt extendedglob
setopt +o nomatch               # See in .aliases for "lh, lhl"
setopt interactivecomments
setopt rcquotes
setopt notify
setopt sunkeyboardhack
unsetopt caseglob

# https://pissedoffadmins.com/os/my-zshrc.html
#
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

source $HOME/.aliases.zsh

source /usr/share/doc/pkgfile/command-not-found.zsh

# Initialize the Zsh plugin manager Antibody (replacement for the slower Antigen)
# https://getantibody.github.io/
#
source <(antibody init)
antibody bundle < ~/.zplugins

SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
  docker        # Docker section
  pyenv         # Pyenv section
  exec_time     # Execution time
  line_sep      # Line break
  battery       # Battery level and status
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

# User Antibody to load oh-my-zsh plugins
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
#
antibody bundle robbyrussell/oh-my-zsh path:plugins/sudo

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[H' beginning-of-line                               # Home key
bindkey '^[[F' end-of-line                                     # End key

# Load fzf command-line fuzzy finder
# https://github.com/junegunn/fzf
#
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

# Colored file listings
#
eval $(dircolors -b $HOME/.dircolors)

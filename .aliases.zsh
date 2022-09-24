## All aliases are kept here and sourced from zshrc

## Use Dirstack
#
DIRSTACKFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/dirs"
if [[ -f "$DIRSTACKFILE" ]] && (( ${#dirstack} == 0 )); then
    dirstack=("${(@f)"$(< "$DIRSTACKFILE")"}")
    [[ -d "${dirstack[1]}" ]] && cd -- "${dirstack[1]}"
fi

# To print the dirstack Use cd -<NUM> to go back to a visited folder
# Use autocompletion after the dash
#
chpwd_dirstack() { print -l -- "$PWD" "${(u)dirstack[@]}" > "$DIRSTACKFILE" }
add-zsh-hook -Uz chpwd chpwd_dirstack
DIRSTACKSIZE='20'

## Auto-list directory contents on cd
#
auto-ls() { ls --color --group-directories-first --classify; }
chpwd_functions=( auto-ls $chpwd_functions )

## Push updated .zshrc settings to enviroment
#
alias reload="source ~/.zshrc"

## Setting Python and Powershell preferences
#
alias python='clear; python -i -q'
alias pwsh='clear; pwsh-preview -NoLogo'
alias powershell='clear; pwsh-preview -NoLogo'

## Pacman related aliases
#
alias opkgs="pacman -Qdt"       # Query pacman for packages for Orphans
alias ipkgs="pacman -Qi"        # Get information on installed package
alias rpkgs="sudo pacman -Rn"   # Uninstall only the package leaving it's dependencies
alias rmpkgs="sudo pacman -Rns" # Uninstall a package and its dependencies
alias trpkgs="pactree -c"       # To view the dependency tree of a package

alias spkgs="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"

# If you want to add package file list in preview - may be a bit slower updating preview window (make sure you run pacman -Fy at least
# Once before invocation to sync the pacman file database)
# Query below seems broken
#
alias fpkgs="pacman -Slq | fzf --multi --preview 'cat <(pacman -Si {1}) <(pacman -Fl {1} | awk "{print \$2}")' | xargs -ro sudo pacman -S"

## Python pip
#
alias lspip="pip list"
alias chkpip="pip-review"
alias iupdatepip="pip-review --interactive"
alias aupdatepip="pip-review --auto"

## Admin tools
#
alias df="df -h"
alias lsblk="lsblk -f"

## Grep searches
#
alias grep="grep --color"
alias rgrep="grep -RHIi"

## File operations
#
alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -Iv"
alias rmd="rm -Ivr"
alias rmdf="rm -vrf"
alias mkd="mkdir -pv"

# https://stackoverflow.com/questions/11818408/convert-all-file-extensions-to-lower-case
#
rnext() {zmv -v '(*).(*)' '$1.$2:l'}

# https://unix.stackexchange.com/questions/9123/is-there-a-one-liner-that-allows-me-to-create-a-directory-and-move-into-it-at-th
#
mkcd() {mkdir -p "$1" && cd "$1";}

## Remove exec permissions from all files within the current directory & sub directories
#
rmexec() {fd --type x --glob '*.?*' -x chmod -v a-x}

## All aliases related to listing files \ directories
#
alias ..="cd .."
alias ...="cd .. ; cd .."
alias ds="dirs -v"

alias dl="ls -d --color --classify */"
alias dll="ls -ld --color --classify */"
alias lt="exa -T"

alias l="ls --color --classify --group-directories-first"
alias ll="ls -l --color --classify --group-directories-first"
alias la="ls -a --color --classify --group-directories-first"
alias lla="ls -la --color --classify --group-directories-first"
alias lss="ls --color --human-readable --size -1 -S --classify"
alias lsh="ls -ash --color --human-readable --size -1 -S --classify"

# How to get rid of “zsh: no matches found: .?*”
# https://unix.stackexchange.com/questions/310540/how-to-get-rid-of-no-match-found-when-running-rm
#
alias lh="ls -d --color --classify --group-directories-first .?* 2>/dev/null"
alias lhl="ls -ld --color --classify --group-directories-first .?* 2>/dev/null"

## Network related
#
alias ports="sudo netstat -tulanp"
alias myip="curl ipinfo.io/ip"

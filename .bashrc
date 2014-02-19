# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


#======================================================================
#======================================================================
#=========================== CUSTOM SETTINGS ==========================
#======================================================================

#----------------------------------------------------------------------
# PROMPT
#https://wiki.archlinux.org/index.php/Color_Bash_Prompt
#http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html

DEFAULT="\[\033[m\]"
DEFAULT_NORMAL="\[\033[0;m\]"
DEFAULT_BOLD="\[\033[1;m\]"

GREY="\[\033[30m\]"
GREY_NORMAL="\[\033[0;30m\]"
GREY_BOLD="\[\033[1;30m\]"

RED="\[\033[31m\]"
RED_NORMAL="\[\033[0;31m\]"
RED_BOLD="\[\033[1;31m\]"

GREEN="\[\033[32m\]"
GREEN_NORMAL="\[\033[0;32m\]"
GREEN_BOLD="\[\033[1;32m\]"

YELLOW="\[\033[33m\]"
YELLOW_NORMAL="\[\033[0;33m\]"
YELLOW_BOLD="\[\033[1;33m\]"

BLUE="\[\033[34m\]"
BLUE_NORMAL="\[\033[0;34m\]"
BLUE_BOLD="\[\033[1;34m\]"

PURPLE="\[\033[35m\]"
PURPLE_NORMAL="\[\033[0;35m\]"
PURPLE_BOLD="\[\033[1;35m\]"
PURPLE_UNDERLIGNED="\[\033[4;35m\]"

CYAN="\[\033[36m\]"
CYAN_NORMAL="\[\033[0;36m\]"
CYAN_BOLD="\[\033[1;36m\]"

WHITE="\[\033[37m\]"
WHITE_NORMAL="\[\033[0;37m\]"
WHITE_BOLD="\[\033[1;37m\]"


source /etc/bash_completion.d/git

sep="-"
# Separator:
PS1_LINE1="${WHITE_NORMAL}"'$sep'" [ ${WHITE_BOLD}\t${WHITE_NORMAL} ]"

PS1_LINE2="${WHITE_BOLD}"'\342\224\214'
PS1_LINE2="${PS1_LINE2}""\$(if [[ \$? == 0 ]]; then echo \"\[\033[1;32m\][\342\234\223]\"; else echo \"\[\033[01;31m\][\342\234\227]\"; fi)${WHITE_BOLD}"
PS1_LINE2="${PS1_LINE2}"'\342\224\200'
PS1_LINE2="${PS1_LINE2}""[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[1;35m\]ROOT'; else echo '\[\033[036m\]\u'; fi)${WHITE_BOLD}]"
PS1_LINE2="${PS1_LINE2}"'\342\224\200'
PS1_LINE2="${PS1_LINE2}""[${BLUE_BOLD}\h${WHITE_BOLD}]"
PS1_LINE2="${PS1_LINE2}"'\342\224\200'
PS1_LINE2="${PS1_LINE2}""[${YELLOW_BOLD}\w${WHITE_BOLD}]"
PS1_LINE2="${PS1_LINE2}"'\342\224\200'
PS1_LINE2="${PS1_LINE2}""[${WHITE_NORMAL}\$(ls -1 | wc -l | sed 's: ::g')(\$(ls -1a | wc -l | sed 's: ::g')) files, \$(ls -lah | grep -m 1 total | sed 's/total //')b${WHITE_BOLD}]\$(__git_ps1)"

PS1_LINE3="${WHITE_BOLD}\342\224\224"
PS1_LINE3="${PS1_LINE3}""\342\224\200"
PS1_LINE3="${PS1_LINE3}""${WHITE_NORMAL}/\!/${WHITE_BOLD}"
PS1_LINE3="${PS1_LINE3}""\342\224\200"
#PS1_LINE3="${PS1_LINE3}""\342\225\274"
PS1_LINE3="${PS1_LINE3}""\[\033[1m\]"
PS1_LINE3="${PS1_LINE3}""\$(if [[ -w \${PWD} ]]; then echo \"\[\033[1;32m\]\"; else echo \"\[\033[1;31m\]\"; fi)\342\224\244 ${WHITE_BOLD}"

PS1="${PS1_LINE1}\n${PS1_LINE2}\n${PS1_LINE3}"
# Reset color for command output (this one is invoked every time before a command is executed):
trap 'echo -ne "\e[0m"' DEBUG
function prompt_command {
    # Sets separator
    let sepsize=(${COLUMNS}/2)-13
    sep=""
    while [ "$sepsize" -gt "0" ]
    do
        sep="-${sep}"
        let sepsize=${sepsize}-1
    done

    # If this is an xterm set the title to user@host:dir
    case "$TERM" in
        xterm*|rxvt*)
        bname=`basename "${PWD/$HOME/~}"`
        echo -ne "\033]0;${bname}: ${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"
        ;;
        *)
        ;;
    esac
}
PROMPT_COMMAND=prompt_command


#----------------------------------------------------------------------
# ALIASES
alias l="ls -l --color"
alias la="l -a"
alias c=clear
alias ..="cd .."

alias rm="rm -I"

# Reloads ./bashrc
alias rb=". ~/.bashrc" 

alias wget="wget -c"


#----------------------------------------------------------------------
# FUNCTIONS
function lf
{ 
    echo "$(ls -l $* | wc -l) files:"
    ls -l --color=tty --classify $*
}

function display_colors
{
    T='gYw'   # The test text
    echo -e "\n                 40m     41m     42m     43m\
         44m     45m     46m     47m";
    for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
               '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
               '  36m' '1;36m' '  37m' '1;37m';
      do FG=${FGs// /}
      echo -en " $FGs \033[$FG  $T  "
      for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
        do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
      done
      echo;
    done
    echo
}


#----------------------------------------------------------------------
# GREETINGS
archey


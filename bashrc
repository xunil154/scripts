#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH=$PATH:/opt/android-sdk/tools

alias ls='ls --color=auto'
alias sl='ls'

alias phone_connect='mtp-connect'
alias phone_mount='go-mtpfs ~/phone'

source ~/.git-completion.sh
source ~/.git-prompt.sh

#PS1='[\u@\h \W]\$ '
prompt="[\A \W]\$ "
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true

#prompt='[\A \W]\$ '
#prompt='[\A \W$(__git_ps1 " (%s)") ]\$ '
#prompt='[\A \W$(__git_ps1 " \e[0;32m(%s)\e[m")\e[m ]\$ '
#prompt='[\A \W$(__git_ps1 " \e[0;32m(%s)\e[m") ]\$ '

PS1="$prompt" # None 
#PS1="\e[0;31m$prompt\e[m" # red
#PS1="\e[0;32m$prompt\e[m" # green
#PS1="\e[0;33m$prompt\e[m" # yellow 

term='xterm'
TERM='xterm'

umask 027

export bash_id=$(cat ~/.bash_id)
next_id=$(( $bash_id + 1 ))
echo $next_id > ~/.bash_id

export start_timestamp=`date +%s`
date=`date`
~/scripts/scripts/bash_start.sh

trap ~/scripts/scripts/bash_exit.sh EXIT

export HISTIGNORE="&:ls:[bf]g:exit"
export HISTSIZE=2000

shopt -s histappend
shopt -s checkwinsize
shopt -s autocd
#. /etc/bash_completion



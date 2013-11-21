#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH=$PATH:/opt/android-sdk/tools

alias ls='ls --color=auto'
alias sl='ls'
alias grep='grep --color'

alias phone_connect='mtp-connect'
alias phone_mount='go-mtpfs ~/phone'

source ~/.git-completion.sh
source ~/.git-prompt.sh

export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

#PS1='[\u@\h \W]\$ '
prompt="[\A \W]\$ "

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true

function build_prompt(){
	git_prompt='$(__git_ps1 " \[\e[0;32m\](%s)\[\e[m\]")'
	virtualenvprompt=''
	if [ $VIRTUAL_ENV ]
		then
		virtualenvprompt='($(basename "$VIRTUAL_ENV"))'
	fi
	#prompt='[\A \W]\$ '
	#prompt='[\A \W$(__git_ps1 " (%s)") ]\$ '
	prompt="$virtualenvprompt[\A \W$git_prompt]\$ "
	#prompt='[\A \W$(__git_ps1 " \e[0;32m(%s)\e[m") ]\$ '

	#prompt="\[\e[0;31m\]$prompt\[\e[m\]" # red
	#prompt="\[\e[0;32m\]$prompt\[\e[m\]" # green
	#prompt="\[\e[0;33m\]$prompt\[\e[m" # yellow 
}


build_prompt
export PS1="$prompt" # None 

term='xterm'
TERM='xterm'


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


function cd(){
	builtin cd $@
	build_prompt
	export PS1="$prompt"
}

export GRAILS_HOME='/home/aerstone/.grails/2.2.4'

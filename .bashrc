# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# http://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
# http://unix.stackexchange.com/questions/18212/bash-history-ignoredups-and-erasedups-setting-conflict-with-common-history
# Avoid duplicates
export HISTCONTROL=ignoreboth:erasedups  
# When the shell exits, append to the history file instead of overwriting it
#shopt -s histappend # not needed, history is saved instantly
# After each command, append to the history file and reread it
#export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

shopt -s autocd
shopt -s checkwinsize

HISTFILESIZE=100000000
HISTSIZE=100000


function hclean() {
  cat ~/.bash_history | nl | sort -r -k 2 | uniq -f 1 | sort -n | cut -f 2 > ~/.bash_history_tmp ;
  mv ~/.bash_history_tmp ~/.bash_history ;
  }

#hclean



[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"



#https://www.debian-administration.org/article/548/Controlling_the_size_of_the_PWD_in_bash
prompt_command()
{
  newPWD="${PWD/#$HOME/~}"
  local pwdmaxlen=$((${COLUMNS:-80}/5))
  [ ${#newPWD} -gt $pwdmaxlen ] && newPWD="${newPWD:0:4}\[\e[1;30m\]...\[\e[0m\]${newPWD:7-$pwdmaxlen}"
  if [ "`id -u`" -eq 0 ]; then
    PS1="${newPWD}${CODE_STRING} \[\033[38;5;9m\]\\$\[$(tput sgr0)\] "
  else
    PS1="${newPWD}${CODE_STRING} \\$\[$(tput sgr0)\] "
  fi
}
export PROMPT_COMMAND=prompt_command

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm-256color)
PROMPT_COMMAND='prompt_command;echo -n -e "\033k\033\\"'
;;

xterm*|rxvt*)

PROMPT_COMMAND='prompt_command;echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'

    ;;
screen)

    PROMPT_COMMAND='prompt_command;echo -n -e "\033k\033\\"'
    ;;
*)
    ;;
esac

export EDITOR=vim
alias vi='vim'
alias ls='ls --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias htop='htop -d 90'
alias locate='locate -i'
alias grep='grep -i'

alias href='history -c ; history -r'

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'


#http://superuser.com/questions/636449/source-my-bash-profile-when-i-su-on-os-x
alias su="export REAL_HOME=$HOME && export SWITCHING_TO_SU=true && export PROMPT_COMMAND='source $HOME/.bashrc; $PROMPT_COMMAND' && su"
if [[ "$SWITCHING_TO_SU" == 'true' ]]; then
    unset SWITCHING_TO_SU
    unset REAL_HOME
fi

#https://wiki.ubuntuusers.de/Paketverwaltung/Tipps
function apt-history(){
      case "$1" in
        install)
              cat /var/log/{dpkg.log,dpkg.log.1} | grep 'install '
              ;;
        upgrade|remove)
              cat /var/log/{dpkg.log,dpkg.log.1} | grep $1
              ;;
        rollback)
              cat /var/log/{dpkg.log,dpkg.log.1} | grep upgrade | \
                  grep "$2" -A10000000 | \
                  grep "$3" -B10000000 | \
                  awk '{print $4"="$5}'
              ;;
        *)
              cat /var/log/{dpkg.log,dpkg.log.1}
              ;;
      esac
}


alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'





# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi





set show-all-if-ambiguous on
extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1     ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }
#complete -W "$(<~/.ssh/hosts)" ssh

export LESS_TERMCAP_mb=$'\E[01;31m' # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m' # begin bold
export LESS_TERMCAP_me=$'\E[0m' # end mode
export LESS_TERMCAP_se=$'\E[0m' # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m' # begin standout-mode – info box
export LESS_TERMCAP_ue=$'\E[0m' # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

if [ -n "$SSH_CONNECTION" ] && [ -z "$SCREEN_EXIST" ]; then
export SCREEN_EXIST=1
echo -n "Restoring screen session in "
echo -n . ; sleep 0.3 ; echo -n . ; sleep 0.3 ; echo -n . ; sleep 0.3 ; echo -n "3" ; sleep 0.3 ; echo -n . ; sleep 0.3 ; echo -n . ; sleep 0.3 ; echo -n . ; sleep 0.3 ; echo -n 2 ; sleep 0.3 ; echo -n . ; sleep 0.3 ; echo -n . ; sleep 0.3 ; echo -n . ; sleep 0.3 ; echo -n "1" ; sleep 0.3 ; echo -n . ; sleep 0.3 ; echo -n . ; sleep 0.3 ; echo -n . ; sleep 0.3; echo 0
screen -a -DR -S mainscreen
fi


#http://scriptsandoneliners.blogspot.no/2014/12/fixing-bash-history-impl-zshpreexec.html
function my_history() { 
 history -a; 
} 
  ### ZSH Pre-exec style functionality hack using DEBUG
set -o functrace > /dev/null 2>&1
shopt -s extdebug > /dev/null 2>&1
export PROMPT_COMMAND="my_history; ${PROMPT_COMMAND}";
trap 'my_history' DEBUG;

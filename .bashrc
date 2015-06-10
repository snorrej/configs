[ -z "$PS1" ] && return
export PHONON_GST_AUDIOSINK=oss4sink

# http://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
# Avoid duplicates
export HISTCONTROL=ignoredups:erasedups  
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend
# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"


export EDITOR=vim
shopt -s checkwinsize
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


    prompt_command()
    {
      newPWD="${PWD/#$HOME/~}"
      local pwdmaxlen=$((${COLUMNS:-80}/3))
      [ ${#newPWD} -gt $pwdmaxlen ] && newPWD="${newPWD:0:4}\[\e[1;30m\]...\[\e[0m\]${newPWD:7-$pwdmaxlen}"

      PS1="${newPWD}${CODE_STRING}\$ "
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


# enable color support of ls and also add handy aliases
#if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
#    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
#fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

alias vi='vim'


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

alias htop='htop -d 90'
alias locate='locate -i'
alias grep='grep -i'
#alias sss='screen -a -DR -S mainscreen'
alias s='~/Documents/bin/screensessionchooser'

if [ -n "$SSH_CONNECTION" ] && [ -z "$SCREEN_EXIST" ]; then
export SCREEN_EXIST=1
echo -n "3" ; sleep 0.3 ; echo -n . ; sleep 0.3 ; echo -n . ; sleep 0.3 ; echo -n . ; sleep 0.3 ; echo -n 2 ; sleep 0.3 ; echo -n . ; sleep 0.3 ; echo -n . ; sleep 0.3 ; echo -n . ; sleep 0.3 ; echo -n "1" ; sleep 0.3 ; echo -n . ; sleep 0.3 ; echo -n . ; sleep 0.3 ; echo -n . ; sleep 0.3; echo 0
#~/Documents/bin/selecter
screen -a -DR -S mainscreen
#echo " "
#echo "to restore screen session, execute s"
#echo " "


#elif [ -z "$SSH_CONNECTION" ]; then
#	~/Documents/bin/screensessionchooser

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


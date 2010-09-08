# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# set vars
export EDITOR=vim
color_prompt=yes
export GREP_OPTIONS='--color=auto'
export SVN_EDITOR='${EDITOR}'

#binding
bind `set completion-ignore-case on`
#bind `set show-all-if-ambiguous on` # show list auto, without double tab
bind `set bell-style none` # no bell


# set path
if [ -d  /var/lib/gems/1.8/bin/ ] ; then
	PATH=/var/lib/gems/1.8/bin/:"${PATH}"
fi


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
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

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'


# aliases for git
alias gitt-lg='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --date=relative'
alias gitt-up='git pull --rebase && git push origin master'
alias gitt-st='git status'
alias gitt-ci='git commit -v'
alias gitt-br='git branch -a'

function gitt-co {
	if [ -z "$1" ]; then
		git checkout master
	else
		git checkout $1
	fi
}

# other aliases from: http://dotfiles.org/~jacqui/.bashrc
alias ducks='du -cksh * | sort -rn|head -11' # Lists folders and files sizes in the current folder
alias systail='tail -f /var/log/system.log'
alias top='top -o cpu'

# Shows most used commands, cool script I got this from: http://lifehacker.com/software/how-to/turbocharge-your-terminal-274317.php
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"


# alias for this file. When done it will be loaded in current shell
alias bashrc='vim ~/.bashrc && source ~/.bashrc'


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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


# Extracting
extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
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

#packing
pack() {
	if [[ -f $2 && -n $1 ]]; then
		case $1 in
			*.tar.bz2)	tar -cjf "$1" "$2" ;;
			*.tar.gz)	tar -pczf $1 $2 ;;
			*.rar)		rar a $1 $2 ;;
			*.tar)		tar -cf $1 $2 ;;
			*.tbz2)		tar -jcvf $1 $2 ;;
			*.tgz)		tar -zcvf $1 $2 ;;
			*.zip)		zip $1 $2 ;;
			*.7z)		7z a $1 $2 ;;
			*)		echo "don't know how to pack '$1'..." ;;
		esac
	else
		echo "Usage: pack <archive> <dir/file>"
		echo "Automagically detects what kind of archive you want to use."
		echo "Supports:"
		echo -e "\t.tar.gz"
		echo -e "\t.rar"
		echo -e "\t.tar"
		echo -e "\t.tbz2"
		echo -e "\t.tgz"
		echo -e "\t.zip"
		echo -e "\t.7z"
	fi
}

#dir size
function ds() {
	echo 'Size of directories in MB'
	if [ $# -lt 1 ] || [ $# -gt 2 ]; then
		echo 'You did not specify a directy, using pwd'
		DIR=$(pwd)
		find $DIR -maxdepth 1 -type d -exec du -sm \{\} \; 2>/dev/null | sort -nr
	else
		find $1 -maxdepth 1 -type d -exec du -sm \{\} \; 2>/dev/null | sort -nr
	fi
}

#file size
function filesize() {
	if [ $# -lt 1 ] || [ $# -gt 2 ]; then
		DIR=$(pwd)
	else
		DIR=$1
	fi
	echo "Biggest files in $DIR:"
	find $DIR -maxdepth 1 -type f -exec du -sm \{\} \; 2>/dev/null | sort -nr
}

# Define a few Colours
BLACK='\e[0;30m'
BLUE='\e[0;34m'
GREEN='\e[0;32m'
CYAN='\e[0;36m'
RED='\e[0;31m'
PURPLE='\e[0;35m'
BROWN='\e[0;33m'
LIGHTGRAY='\e[0;37m'
DARKGRAY='\e[1;30m'
LIGHTBLUE='\e[1;34m'
LIGHTGREEN='\e[1;32m'
LIGHTCYAN='\e[1;36m'
LIGHTRED='\e[1;31m'
LIGHTPURPLE='\e[1;35m'
YELLOW='\e[1;33m'
WHITE='\e[1;37m'
NC='\e[0m' # No Color

#Use human-readable filesizes
alias du="du -h"
alias df="df -h"

#Make these commands ask before clobbering a file. Use -f to override.
alias rm="rm -vi"
alias cp="cp -vi"
alias mv="mv -vi"

function apt-history(){
      case "$1" in
        install)
              cat /var/log/dpkg.log | grep 'install '
              ;;
        upgrade|remove)
              cat /var/log/dpkg.log | grep $1
              ;;
        rollback)
              cat /var/log/dpkg.log | grep upgrade | \
                  grep "$2" -A10000000 | \
                  grep "$3" -B10000000 | \
                  awk '{print $4"="$5}'
              ;;
        *)
              cat /var/log/dpkg.log
              ;;
      esac
}

# Subversion
alias svnaddall='find "$PWD" -exec svn add {} 2>/dev/null \;'

# Define a word - USAGE: define dog
define (){
	lynx -dump "http://www.google.com/search?hl=en&q=define%3A+${1}&btnG=Google+Search" |
	grep -m 3 -w "*" | sed 's/;/ -/g' | cut -d- -f1 > /tmp/templookup.txt
	if [[ -s /tmp/templookup.txt ]] ;then
		until ! read response
		do
		echo "${response}"
		done < /tmp/templookup.txt
	else
		echo "Sorry $USER, I can't find the term\"${1} \""
	fi
	rm -f /tmp/templookup.txt
}

echo
echo -ne "${LIGHTCYAN}"; cal -3
echo -ne "${LIGHTPURPLE}"; weather -i EHAM
echo

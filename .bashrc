#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\e[1;44;30m \u@\h \e[00m \e[0;100;97m \w \e[00m '

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

pfetch

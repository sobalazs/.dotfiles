#
# ~/.bashrc
#

#if [ -n "$DESKTOP_SESSION" ];then
#     eval $(gnome-keyring-daemon --start)
#     export SSH_AUTH_SOCK
#fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

fgcolor="\[$(tput setaf 256)\]" #https://misc.flogisoft.com/bash/tip_colors_and_formatting
bgcolor="\[$(tput setab 0)\]"
resetcolor="\[$(tput sgr0)\]"

case ${TERM} in
 alacritty)
          PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
          ;;
esac

parse_git_info() {
if [ -d .git ]; then
	echo -e "\e[1;34m"\ $(git branch -v | awk '{print $2}')"\e[0m \e[1;36m|\e[0m \e[1;35m"$(git tag | tail -1)"\e[0m \e[1;36m|\e[0m \e[1;31m" $(git status | grep modified | wc -l)"\e[0m\n\r"
fi
}

#start -> \e[
#color -> 0;32m
#end   -> \e[0m

PS1="\$(parse_git_info)> "
#PS1='\[\e[1;44;30m\] \u@\h \[\e[00m\] \[\e[0;100;97m\] \w \[\e[00m\] '

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_autocomp ]; then
    . ~/.bash_autocomp
fi

#if [ -n "$DESKTOP_SESSION" ];then
#    eval $(gnome-keyring-daemon --start)
#    export SSH_AUTH_SOCK
#fi

pfetch

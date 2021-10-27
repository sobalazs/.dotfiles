#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Add Aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Add autocompletion for pass
if [ -f ~/.bash_autocomp ]; then
    . ~/.bash_autocomp
fi

# Add git Status line when in "git-folder?"
parse_git_info() {
	if [ -d .git ]; then
		branch=$(git branch -v | awk '{print $2}')
		version=$(git tag | tail -1)
		modified=$(git status | grep modified | wc -l)
		color_in_branch='\[\033[1m\]\[\033[38;5;12m\]\[\033[48;5;0m\] '"$branch"'\[\033[0m\] \[\033[38;1;3m\]\[\033[48;1;2m\]|\[\033[0m\]'
		color_in_version='\[\033[1m\]\[\033[38;5;13m\]\[\033[48;5;0m\]v '"$version"'\[\033[0m\] \[\033[38;1;3m\]\[\033[48;1;2m\]|\[\033[0m\]'
		color_in_modified='\[\033[1m\]\[\033[38;5;9m\]\[\033[48;5;0m\] '"$modified"'\[\033[0m\]\r\n'
		PS1="$color_in_branch $color_in_version $color_in_modified> "
	else
		PS1="> "
	fi
}

# Render PS1 by every command
PROMPT_COMMAND=parse_git_info

# Add fancy start script :)
pfetch

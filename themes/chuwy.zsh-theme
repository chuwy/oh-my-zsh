# CHUWY - created mainly inspired by CRUNCH
#
# Instead, only the  things that vary in my own workflow are shown:
#
# * The time on right prompt
# * The current user
# * The current virtualenv (if virtualenvwrapper is installed)
# * The current directory (2-depth)
# * The Git branch and its 'dirty' state
# 
# Colors are at the top so you can mess with those separately if you like.
# For the most part I stuck with Dallas's.

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo `basename $VIRTUAL_ENV`
}

CRUNCH_BRACKET_COLOR="%{$fg[white]%}"

CRUNCH_TIME_COLOR="%{$fg[yellow]%}"
CRUNCH_RVM_COLOR="%{$fg[magenta]%}"
CRUNCH_DIR_COLOR="%{$FG[033]%}"
CRUNCH_GIT_BRANCH_COLOR="%{$fg[green]%}"
CRUNCH_GIT_CLEAN_COLOR="%{$fg[green]%}"
CRUNCH_GIT_DIRTY_COLOR="%{$fg[red]%}"

time="%(?.%{$fg[green]%}.%{$fg[red]%})%*%{$reset_color%}"
local user="%(!.%{$fg[blue]%}.%{$fg[$HOST_COLOR]%})%n%{$reset_color%}"

# These Git variables are used by the oh-my-zsh git_prompt_info helper:
ZSH_THEME_GIT_PROMPT_PREFIX="$CRUNCH_BRACKET_COLOR:$CRUNCH_GIT_BRANCH_COLOR"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_CLEAN=" $CRUNCH_GIT_CLEAN_COLOR✓"
ZSH_THEME_GIT_PROMPT_DIRTY=" $CRUNCH_GIT_DIRTY_COLOR✗"


CRUNCH_DIR_="$CRUNCH_DIR_COLOR%2~% \$(git_prompt_info) "
CRUNCH_PROMPT="$CRUNCH_BRACKET_COLOR$ "

if (( $+commands[vi_mode_prompt_info] )) ; then
    RPROMPT='$(vi_mode_prompt_info) $CRUNCH_DIR_COLOR$(virtualenv_info)%{$reset_color%} ${time%}'
else
    RPROMPT='$CRUNCH_DIR_COLOR$(virtualenv_info)%{$reset_color%} ${time%}'
fi

# Put it all together!
PROMPT="${user%} $CRUNCH_DIR_$CRUNCH_PROMPT%{$reset_color%}"

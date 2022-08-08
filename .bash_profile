# [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

export ASANA_TOKEN="1/1196482669978105:0a801ad7a2c4a2ed0cb5f76cdf6e23af"
export EDITOR=vim

alias g='git'
alias aa='git add -p'
alias rr='git rebase'
alias rb='git rebase'
alias c='clear'
alias gst='git status'
alias ss='git status'

# PS1="[\[\033[32m\]\w]\[\033[0m\]\$(__git_ps1)\n\[\033[1;36m\]\u\[\033[32m\]$ \[\033[0m\]"

source ~/.bin/git-prompt.sh
PS1="[\[\033[32m\]\w]\[\033[0m\]\$(__git_ps1)\n\[\033[1;36m\]\u\[\033[32m\]$ \[\033[0m\]"

#function color_my_prompt {
#    local __user_and_host="\[\033[01;32m\]\u@\h"
#    local __cur_location="\[\033[01;34m\]\w"
#    local __git_branch_color="\[\033[31m\]"
#    #local __git_branch="\`ruby -e \"print (%x{git branch 2> /dev/null}.grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`"
#    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
#    local __prompt_tail="\[\033[35m\]$"
#    local __last_color="\[\033[00m\]"
#    export PS1="$__user_and_host $__cur_location $__git_branch_color$__git_branch$__prompt_tail$__last_color "
#}
#color_my_prompt

function we_are_in_git_work_tree {
    git rev-parse --is-inside-work-tree &> /dev/null
}

function parse_git_branch {
    if we_are_in_git_work_tree
    then
    local BR=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD 2> /dev/null)
    if [ "$BR" == HEAD ]
    then
        local NM=$(git name-rev --name-only HEAD 2> /dev/null)
        if [ "$NM" != undefined ]
        then echo -n " @$NM"
        else git rev-parse --short HEAD 2> /dev/null
        fi
    else
        echo -en " $COLBROWN$BR$COLCLEAR"
       fi
    fi
}

function parse_git_status {
    if we_are_in_git_work_tree
    then
    local ST=$(git status --short 2> /dev/null)
    if [ -n "$ST" ]
    then echo -en " $COLRED(✘)$COLCLEAR\n"
    else echo -en " $COLGREEN(✓)$COLCLEAR\n"
    fi
    else echo -n " "
    fi
}

function pwd_depth_limit_2 {
    if [ "$PWD" = "$HOME" ]
    then echo -en "$COLGRAY~$COLCLEAR"
    else echo -en "$COLGRAY$(pwd | sed -e "s|.*/\(.*/.*\)|\1|")$COLCLEAR"
    fi
}

COLGRAY="\033[1;36m"
COLGREEN="\033[1;32m"
COLBROWN="\033[1;33m"
COLRED="\033[1;31m"
COLCLEAR="\033[0m"

# Export all these for subshells
export -f parse_git_branch parse_git_status we_are_in_git_work_tree pwd_depth_limit_2
export PS1="\$(pwd_depth_limit_2)\$(parse_git_branch)\$(parse_git_status)> "
export TERM="xterm-color"
# RVM
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# NVM
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && .  "/usr/local/etc/profile.d/bash_completion.sh" ]]

# nvm use

# eval "$(rbenv init -)"

# Docker Completion
# if [ -f $(brew --prefix)/etc/bash_completion ]; then
#   . $(brew --prefix)/etc/bash_completion
# fi

mov_to_mp4 () {
  infile=$(find . | grep ".mov" | FZF)
  if [ ! -f "$infile" ]
  then
    echo "No such file: $infile"
  else
    printf "Output filename? (without .mp4 extension) "
    read -r outfile

    # ffmpeg -i "$infile" -filter_complex \
    #   "[0:v] setpts=PTS/3,fps=6,scale=720:-1,split [a][b];[a] palettegen [p];[b][p] paletteuse" \
    #   "$outfile.gif"
    ffmpeg -i "$infile" -vcodec h264 -acodec mp2 "$outfile.mp4"
  fi
}

mp4_to_gif () {
  infile=$(find . | grep ".mp4" | FZF)
  if [ ! -f "$infile" ]
  then
    echo "No such file: $infile"
  else
    printf "Output filename? (without .gif extension) "
    read -r outfile

    ffmpeg -i "$infile" -vf "fps=3,scale=720:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 "$outfile.gif"
  fi
}

export HISTSIZE=
export HISTFILESIZE=

# Avoid duplicates
export HISTCONTROL=ignoredups:erasedups  
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

export HEROKU_ORGANIZATION=hipcamp


# export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules'
alias python=/usr/local/bin/python3
alias pip=/usr/local/bin/pip3

. /usr/local/opt/asdf/libexec/asdf.sh

. /usr/local/opt/asdf/etc/bash_completion.d/asdf.bash

eval $(ssh-agent)

export LINT_FORMAT=html
export LINT_OUTPUT_FILE=lint-output.html
export AIRSTREAM_PORT=80
export PATH="/Users/bbergstein/.bin:$PATH"
export PNPM_HOME="/Users/bbergstein/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

source ~/.bash_secrets

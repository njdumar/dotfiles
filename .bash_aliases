# eval $(keychain --eval --quiet id_ed25519 id_rsa ~/.keys/my_custom_key)
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s`
  ssh-add
fi

export GOPATH=~/go

# Better ctrl-r replacement
if [ -f /usr/share/fzf/key-bindings.bash ] ; then
    source /usr/share/fzf/key-bindings.bash
else
    [ -f ~/.fzf.bash ] && source ~/.fzf.bash
fi

export PATH=$PATH:/usr/local/go/bin

# Disable software flow conntrol (XON/XOFF), it's annoying in vim
stty -ixon

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

SVN_EDITOR=vim
export SVN_EDITOR
export EDITOR=vim
export CSCOPE_EDITOR=/usr/bin/vim

# Perform arithmetic easily in bash
=() {
    answer="$(($@))"
    printf '%s' "$answer"
    bc -l <<< "obase=16;ans=$answer;print \" (0x\",ans,\")\\n\""
}

# terminal prompt git statuses
COLOR_RED="\001\033[01;31m\002"
COLOR_YELLOW="\001\033[01;33m\002"
COLOR_GREEN="\001\033[01;32m\002"
COLOR_OCHRE="\001\033[38;5;95m\002"
COLOR_BLUE="\001\033[01;34m\002"
COLOR_CYAN="\001\033[01;36m\002"
COLOR_WHITE="\001\033[01;37m\002"
COLOR_PURPLE="\001\033[01;35m\002"
COLOR_RESET="\001\033[0m\002"

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local operating_branch="currently ([^${IFS}]*) branch '([^${IFS}]*)' on"
  local on_commit="HEAD detached at ([^${IFS}]*)"
  local interactive_rebasing="interactive rebase in progress; onto ([^${IFS}]*)"
  local git_added="$(git diff --cached --numstat 2> /dev/null | wc -l)"
  local git_dirty="$(git diff-files --diff-filter=M 2> /dev/null | wc -l)"
  local git_untracked="$(git ls-files --exclude-standard --others 2> /dev/null | wc -l)"

  local status=""
  local color=$COLOR_OCHRE

  if [[ $git_status =~ "diverged" ]]; then
    color=$COLOR_RED
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    color=$COLOR_YELLOW
  elif [[ $git_status =~ "Your branch is behind" ]]; then
    color=$COLOR_PURPLE
  elif [[ $git_status =~ "Your branch is up-to-date" ]]; then
    color=$COLOR_BLUE
  elif [[ $git_status =~ "On branch" ]]; then
    color=$COLOR_BLUE
  fi

  if [[ $git_added > 0 ]]; then
      status+=" $git_added staged"
  fi
  if [[ $git_dirty > 0 ]]; then
      status+=" $git_dirty dirty"
  fi
  if [[ $git_untracked > 0 ]]; then
      status+=" $git_untracked untracked"
  fi

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo -e "$color($branch)$status"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo -e "$color($commit)$status"
  elif [[ $git_status =~ $operating_branch ]]; then
    local branch=${BASH_REMATCH[2]}
    local operation=${BASH_REMATCH[1]}
    echo -e "$color($branch | $operation)$status"
  elif [[ $git_status =~ $interactive_rebasing ]]; then
    local commit=${BASH_REMATCH[1]}
    echo -e "$color(Interactive Rebase: $commit)"
  fi
}

PS1='$\[\033[01;32m\]\u@\w\[\033[00m\]: \[\033[01;35m\]'
PS1+="\$(git_branch)"
PS1+='\[\033[00m\]\n\$ '
export PS1

# Setup fzf
# ---------
if [[ ! "$PATH" == *~/.vim/plugged/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}~/.vim/plugged/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "~/.vim/plugged/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "~/.vim/plugged/fzf/shell/key-bindings.bash"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
[ -n "$(command -v pyenv)" ] && eval "$(pyenv init - zsh)"

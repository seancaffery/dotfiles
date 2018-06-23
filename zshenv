export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export MINICONDA_DIRECTORY=$HOME/.pyenv/versions/miniconda-3.9.1
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

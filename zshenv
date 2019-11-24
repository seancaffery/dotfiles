export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export MINICONDA_DIRECTORY=$HOME/.pyenv/versions/miniconda-3.9.1
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export GOPATH="$HOME/code/go"
export PATH="$PATH:$GOPATH/bin"
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
export PATH="$GOROOT/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

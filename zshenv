typeset -U path
export GOPATH="$HOME/code/go"
export GOENV_ROOT="$HOME/.goenv"
path=($GOPATH/bin $GOENV_ROOT/bin $HOME/.cargo/bin /opt/homebrew/bin $path)
export HOMEBREW_AUTO_UPDATE_SECS=86401
export IDF_PATH="$HOME/esp/ESP8266_RTOS_SDK"
export AWS_VAULT_DISABLE_HELP_MESSAGE=1

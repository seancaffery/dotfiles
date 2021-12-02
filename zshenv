typeset -U path
export GOPATH="$HOME/code/go"
export GOENV_ROOT="$HOME/.goenv"
path=($GOPATH/bin $GOENV_ROOT/bin $HOME/.cargo/bin $path)
export HOMEBREW_AUTO_UPDATE_SECS=86401
export IDF_PATH="$HOME/esp/ESP8266_RTOS_SDK"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="philips"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# homebrew set up
eval "$(`which brew` shellenv)"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(tmux git gitfast bundler colorize vi-mode docker)
# User configuration

path=($HOME/esp/xtensa-lx106-elf/bin $HOME/bin bin node_modules/.bin $path)

export ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zcompdump-${HOST}-${ZSH_VERSION}"
source $ZSH/oh-my-zsh.sh
bindkey '^R' history-incremental-search-backward
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
cb () {
  git branch | cut -c 3- | selecta | xargs git checkout
}

zeust () {
 find test/* -type f -not -path '*.swp' | selecta
}

function prj() {
  cd $({ find ~/code -maxdepth 2 -type d } | selecta)
  zle reset-prompt
}
zle -N prj
bindkey "^P" "prj"

#export GIT_PAGER="git diff --color | diff-highlight | less -SFEX"
export GIT_PAGER="less -SFEX"
export EDITOR='vim'

eval "$(rbenv init - --no-rehash)"
alias vim='nvim'
alias vi='nvim'
alias bi='bundle check || bundle install --local --quiet && echo "Bundle complete"'
alias cr='crystal run --release'
unalias irb
export PKG_CONFIG_PATH='/usr/local/opt/openssl/lib/pkgconfig'
autoload -U add-zsh-hook

# don't add to history if command fails
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

if [[ -f $HOME/.zsh.work ]]; then
  source $HOME/.zsh.work
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/scaffery/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/scaffery/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/scaffery/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/scaffery/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

source <(kubectl completion zsh)

export NODE_EXTRA_CA_CERTS="$(mkcert -CAROOT)/rootCA.pem"

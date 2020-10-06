# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export TERM=xterm-256color

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"
ZSH_THEME="lambda"

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
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export PATH=""
# export ANDROID_HOME=''
export LC_CTYPE="en_US.UTF-8"
# export PYTHONSTARUP="$HOME/.pythonrc"

# export MANPATH="/usr/local/man:$MANPATH"

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
# alias ctags=/usr/local/bin/ctags
# alias v='NVIM_TUI_ENABLE_CURSOR_SHAPE=1 nvim'
alias v='nvim'
alias r='ranger'
# alias cm="screen -d -m cmus"
# alias n="cmus-remote -n"
# alias r="cmus-remote -r"
# alias u="cmus-remote -u"
# alias R="cmus-remote -R"

# require auto-fu
# source ~/.zsh/auto-fu; auto-fu-install
# zle-line-init () {auto-fu-init;}; zle -N zle-line-init
zstyle ':completion:*' completer _oldlist _complete
# zle -N zle-keymap-select auto-fu-zle-keymap-select
zstyle ':auto-fu:highlight' input bold
zstyle ':auto-fu:highlight' completion fg=14
zstyle ':auto-fu:highlight' completion/one fg=14

# . <(npm completion) # search npm tab completion

zstyle ':auto-fu:var' autoable-function/skiplines \
        "('|$'|\")*" "^(??)##" "npm##*"

export NVM_DIR="$HOME/.nvm"
export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/dist
alias npm='npm --registry=https://registry.npm.taobao.org'

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use

export GOPATH="$HOME/gocode"
export GO111MODULE="on"
export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin
source $HOME/.cargo/env
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
eval "$(zoxide init zsh)"


export BAT_THEME='Solarized (light)'
_gen_fzf_default_opts() {
  local base03="12"
  local base02="14"
  local base01="7"
  local base00="15"
  # local base0="12"
  # local base1="14"
  # local base2="7"
  # local base3="15"
  local base0="8"
  local base1="0"
  local base2="10"
  local base3="11"
  local yellow="3"
  local orange="9"
  local red="1"
  local magenta="5"
  local violet="13"
  local blue="4"
  local cyan="6"
  local green="2"

  # Comment and uncomment below for the light theme.

  # Solarized Dark color scheme for fzf
  export FZF_DEFAULT_OPTS="
    --color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base01,hl+:$blue,gutter:$base02
    --color info:$green,prompt:$red,pointer:$base02,marker:$base3,spinner:$yellow
  "

  export FZF_CTRL_T_OPTS="
    --ansi --preview-window 'right:60%'
    --preview '([[ -f {} ]] && (bat --color=always --style=header --line-range :300 {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
  "
  ## Solarized Light color scheme for fzf
  #export FZF_DEFAULT_OPTS="
  #  --color fg:-1,bg:-1,hl:$blue,fg+:$base02,bg+:$base2,hl+:$blue
  #  --color info:$yellow,prompt:$yellow,pointer:$base03,marker:$base03,spinner:$yellow
  #"
}
_gen_fzf_default_opts

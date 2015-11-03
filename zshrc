# screenfetch
# acpi -V | grep ok
DEFAULT_USER='dan'
# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh
TERM="xterm-256color"
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# BULLETTRAIN_TIME_SHOW=false
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="bullet-train"
ZSH_THEME="powerlevel9k"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status history)
# POWERLINE_HIDE_USER_NAME="true"
# POWERLINE_HIDE_HOST_NAME="true"
# Example aliases
source .oh-my-zsh/lib/alias.zsh
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias x='exit'
alias ag='apt-get'
alias th='theme'
alias wo='workon'
alias menv='mkvirtualenv'
alias da='deactivate'
alias zshrc='nvim ~/.zshrc'
alias vimrc='nvim ~/.vimrc'
alias nvimrc='nvim ~/.nvimrc'
alias weechat='weechat-curses'
alias go='fg'
alias chx='chmod u+x'
alias gpo='git push origin master'
# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git themes zsh-syntax-highlighting sublime rbenv rvm zsh_reload battery)
export WORKON_HOME=$HOME/Envs
export PROJECT_HOME=$HOME/project
source $ZSH/oh-my-zsh.sh
source /usr/local/bin/virtualenvwrapper.sh
# User configuration

export PATH=$HOME/bin:/usr/local/bin:$HOME/neovim/bin:$HOME/perl5/perlbrew/bin:/opt/wx/3.0/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
export EDITOR='vim'
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR


# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
xmodmap ~/.speedswapper

PERL_MB_OPT="--install_base \"/home/dan/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/dan/perl5"; export PERL_MM_OPT;

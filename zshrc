#
## User-defined functions
#

# add push notifications over Pushover
push() {
  curl -s -F "token=afgq15q22847cg8e1xjpmjfug5ran3" -F "user=u2f4smknjr4z5mhc3xque2jzp7ap7n" -F "title=Work Blackbox" -F "message=$1" https://api.pushover.net/1/messages.json
}

open() {
  zsh -c "
    xdg-open \"$1\" &
    disown xdg-open
  "
}

# print some wisdom by our favorite animals
cowspeakfortune() {
  h=`date +%H`
  # If early morning (middle of the night)
  if [ $h -lt 06 ]
  then
      cowargs="elephant"
  # If mid to late morning
  elif [ $h -lt 12 ]
  then
      cowargs="moose"
  # If early afternoon
  elif [ $h -lt 16 ]
  then
      cowargs="tux"
  # If mid morning
  elif [ $h -lt 20 ]
  then
      cowargs="vader"
  # If late night
  elif [ $h -lt 24 ]
  then
      cowargs="dragon-and-cow"
  # If we missed a case
  else
      cowargs="-d"
  fi
  # Now print motd
  echo $fg[cyan]
  fortune -s | cowsay -f $cowargs
  echo ""
}

ssh_clean() {
    sed -i "/$1/,+1 d" ~/.ssh/known_hosts
}

#
## Oh-My-Zsh Configuration
#

# path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# set name of the theme to load.
ZSH_THEME="gallois"

# uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# uncomment the following line to display red dots whilst waiting for completion.
#COMPLETION_WAITING_DOTS="true"

# uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# the optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# increase History Length
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

# which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git sudo ssh-agent history wd zsh_reload)


# source oh-my-zsh setup
source $ZSH/oh-my-zsh.sh

#
## User configuration
#

# Don't throw an error when a glob doesn't match anything.
setopt nonomatch

# Get all the UTF
export LANG=en_US.utf-8
export LC_ALL=en_US.utf-8

export PATH="$HOME/.bin:$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# Add CMAKE_PREFIX_PATH for Qt compatability
export CMAKE_PREFIX_PATH=/opt/Qt/5.9/gcc_64

# Set fake "window manager" to make IDA inherit gtk+2 theme
export XDG_CURRENT_DESKTOP=gnome

# make sure we're always editing in vim #vimmasterrace
export EDITOR='nvim'

# why not view our manpages in nvim?
export MANPAGER="nvim -c 'set ft=man' -"

# alias common commands
alias dusort="du -sh * | sort -h"
alias utime="date +%s"
alias ipecho="curl ipecho.net/plain"
alias sourcez="source ~/.zshrc"
alias grep="grep -i --color=auto"
alias watch="watch -n1"
alias ls="ls --color -l"
alias diff="colordiff"
alias ffprobe="ffprobe -hide_banner"
alias ffmpeg="ffmpeg -hide_banner"
alias sed="sed -r"

alias music="ncmpcpp"
# Linux-specific keyboard speed command
alias fast="/usr/bin/xset r rate 200 40"

# alias view to read-only vim instead of ex
alias view="vim -R"
alias l="less"

# Dircolors
eval `dircolors -b $HOME/.dir_colors`
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

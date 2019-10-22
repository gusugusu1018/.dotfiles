# zprofile
autoload -U compinit
compinit

# In case of using promptinit
# $ prompt -l
# setting for prompt
# $ prompt [prompt名]
# autoload -U promptinit
# promptinit
# my prompt
PROMPT='%F{6}%~ %f%F{3}>%f%F{4}>%f%F{5}>%f%F{6}>%f '

# zplug section
source ~/.zplug/init.zsh
# zsh-autosuggestions
zplug 'zsh-users/zsh-autosuggestions'
# zsh-completions
zplug 'zsh-users/zsh-completions'
# docker alias
zplug "tcnksm/docker-alias", use:zshrc
# zplug install
if ! zplug check --verbose; then
  printf 'Install? [y/N]: '
  if read -q; then
    echo; zplug install
  fi
fi
zplug load --verbose

# history path
export HISTFILE=${HOME}/.zhistory
# history size in memory
export HISTSIZE=1000
# history size in file
export SAVEHIST=100000
# ignore overlapped history
setopt hist_ignore_dups
# save start and finish
setopt EXTENDED_HISTORY
# share history
setopt share_history
# ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
# スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space
# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_verify
# 余分な空白は詰めて記録
setopt hist_reduce_blanks  
# 古いコマンドと同じものは無視 
setopt hist_save_no_dups
# not save history command
setopt hist_no_store
# 補完時にヒストリを自動的に展開
setopt hist_expand
# add history to increamental
setopt inc_append_history
# search on increamental
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward


# Use hard limits, except for a smaller stack and no core dumps
unlimit
limit stack 8192
limit core 0
limit -s

umask 022

# Set up aliases
alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'       # no spelling correction on cp
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
alias j=jobs
alias pu=pushd
alias po=popd
alias d='dirs -v'
alias h=history
alias l='ls'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

# docker run gui aliase
alias docker-runx='docker run -it --env DISPLAY=unix$DISPLAY --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw"'

# ls color on linux
alias ls='ls -F --color'

# anyenv
if [ -d $HOME/.anyenv ] ; then
	export PATH="$HOME/.anyenv/bin:$PATH"
	eval "$(anyenv init -)"
# pyenv
	if [ -d $HOME/.anyenv/envs/pyenv ] ; then
		eval "$(pyenv init -)"
# pyenv virtualenv
		if [ -d $HOME/.anyenv/envs/pyenv/plugins/pyenv-virtualenv ] ; then
			eval "$(pyenv virtualenv-init -)"
		fi
	fi
fi
## ROS
#source /opt/ros/bouncy/setup.bash
#export OSPL_URI=file:///usr/etc/opensplice/config/ospl.xml
#source $HOME/Projects/ros2_ws/install/local_setup.bash
#source /opt/ros/crystal/setup.bash

clear

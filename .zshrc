#################### PROMPT ######################
# Set up the prompt

#autoload -Uz promptinit
#promptinit
#prompt clint
PROMPT='%F{6}%~ %f%F{3}>%f%F{4}>%f%F{5}>%f%F{6}>%f '

##################### ZPLUG #######################
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
zplug load
###################### ALIAS ########################
# ls color on linux
alias ls='ls -F --color'
alias docker-images-clean="docker rmi -f $(docker images  --filter "dangling=true" -aq)"

###################### HISTORY #######################
# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history
setopt hist_ignore_dups
setopt share_history
setopt histignorealldups
setopt EXTENDED_HISTORY
setopt hist_ignore_space
setopt hist_reduce_blanks  
setopt hist_save_no_dups
setopt hist_no_store
setopt inc_append_history

setopt hist_expand

# Use hard limits, except for a smaller stack and no core dumps
unlimit
limit stack 8192
limit core 0
limit -s

umask 022

#zstyle ':completion:*' auto-description 'specify: %d'
#zstyle ':completion:*' completer _expand _complete _correct _approximate
#zstyle ':completion:*' format 'Completing %d'
#zstyle ':completion:*' group-name ''
#zstyle ':completion:*' menu select=2
#eval "$(dircolors -b)"
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' list-colors ''
#zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
#zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
#zstyle ':completion:*' menu select=long
#zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
#zstyle ':completion:*' use-compctl false
#zstyle ':completion:*' verbose true
#
#zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
#zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

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
	if [ -d $HOME/.anyenv/envs/nodenv ] ; then
		eval "$(nodenv init -)"
	fi
fi

# kubectl
if type kubectl > /dev/null 2>&1; then
	source <(kubectl completion zsh)
fi

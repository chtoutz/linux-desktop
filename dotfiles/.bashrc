PS1='\u @ \h (\e[38;5;198m\w\e[0m) [\e[38;5;148m$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\e[0m]\n\$ '

# Environment / Path
# export GOBIN=/home/stutz/bin
export SCRIPTS=/home/stutz/s
export PATH=$PATH:$SCRIPTS

# Load aliases
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# History
# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# Append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
export EDITOR=nano

## DEV SCRIPTS ##
# alias potiso='cd ~/github/potiso && quasar dev'
# alias eksplorer='cd ~/github/eksplorer && quasar dev'
# alias raspi='ssh pi@192.168.1.101'

# Setup ssh-agent
#eval `ssh-agent` &>/dev/null
#ssh-add ~/.ssh/*.pem &>/dev/null

# export FZF_CTRL_R_OPTS='--sort --exact'

# [ -f ~/.fzf.bash ] && source ~/.fzf.bash

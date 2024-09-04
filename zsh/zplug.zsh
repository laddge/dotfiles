export ZPLUG_HOME=$HOME/.zplug

if [ ! -e $ZPLUG_HOME ]; then
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

source $ZPLUG_HOME/init.zsh

# plugins
zplug "zsh-users/zsh-syntax-highlighting"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[default]='fg=white,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=white,underline,bold'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=yellow, bold'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=green,bold'
zstyle ':completion:*:default' menu select=2

zplug "zsh-users/zsh-history-substring-search"
export HISTORY_SUBSTRING_SEARCH_PREFIXED=true
bindkey "^P" history-substring-search-up
bindkey "^N" history-substring-search-down
bindkey "OA" history-substring-search-up
bindkey "OB" history-substring-search-down
bindkey "[A" history-substring-search-up
bindkey "[B" history-substring-search-down

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "chrissicool/zsh-256color"
zplug "mafredri/zsh-async"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# 一般的な設定
setopt correct  # 入力しているコマンド名が間違っている場合にもしかして:を出す。
setopt nobeep  # ビープを鳴らさない
setopt autocd  # ディレクトリ名を入力するだけでcdできるようにする
setopt sharehistory  # 同時に起動したzshの間でヒストリを共有する。
setopt histignoredups  # 直前と同じコマンドをヒストリに残さない。
setopt histreduceblanks  # ヒストリに保存するときに余分なスペースを削除する
setopt nopromptcr  # 行末の#を消す
setopt extendedhistory  # ヒストリに実行時間も保存

# ヒストリの設定
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey "OA" history-beginning-search-backward-end
bindkey "OB" history-beginning-search-forward-end
bindkey "[A" history-beginning-search-backward-end
bindkey "[B" history-beginning-search-forward-end

# promptの設定
autoload -Uz colors
colors

do_enter() {
    if [ -n "$BUFFER" ]; then
        FIRST_CD=false
        zle accept-line
        return 0
    fi
    echo
    echo
    zle reset-prompt
    return 0
}
zle -N do_enter
bindkey '^m' do_enter
ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(do_enter $ZSH_AUTOSUGGEST_CLEAR_WIDGETS)

chpwd() {
    FIRST_CD=true
}

# git ブランチ名を色付きで表示させるメソッド
function prompt_git {
  local branch_name st branch_status

  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  # git 管理されていないディレクトリは何も返さない
  return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`LANG=C git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
  # 全て commit されてクリーンな状態
  branch_status="%F{green}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
  # git 管理されていないファイルがある状態
  branch_status="%F{red}"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
  # git add されていないファイルがある状態
  branch_status="%F{red}"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
  # git commit されていないファイルがある状態
  branch_status="%F{yellow}"
  elif [[ -n `echo "$st" | grep "rebase in progress"` ]]; then
  # コンフリクトが起こった状態
  echo "%F{red}!(no branch)"
  return
  else
  # 上記以外の状態の場合
  branch_status="%F{blue}"
  fi
  # ブランチ名を色付きで表示する
  echo " (${branch_status}$branch_name%f)"
}

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt promptsubst

prompt_pwd() {
    if [[ $FIRST_CD == '' || $FIRST_CD == true ]]; then
        echo "%F{blue}`pwd`%f"
    else
        echo "%F{blue}%(5~,%-2~/.../%2~,%~)%f"
    fi
}

prompt_kao() {
    local ok='(^_^)'
    local ng='(=_=;'
    local color face reset
    color="%{%(?.%F{green}.%B%F{red})%}"
    face="%(?.$ok.$ng)"
    reset="%{%f%}"
    echo "$color$face$reset"
}

# プロンプトにメソッドの結果を表示させる
PROMPT='%B[%F{green}%m%f][`exec prompt_pwd`]`prompt_git`
`prompt_kao` %(!.%F{red}#%f.%b%F{white}$%f%B) %f%b'
RPROMPT=""

# zplugの読み込み
source ~/.zsh/zplug.zsh

# for w3m
export WWW_HOME="http://google.com/"

# for ls
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'

# aliases
alias ls='ls --color'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias cmx='chmod +x'
alias python='python3'
alias pip='pip3'
alias v='nvim'
alias ga='git add'
alias gaa='git add -A'
alias gs='git status'
alias gl='git log --graph'
alias gch='git checkout'
alias gb='git branch'
alias gpl='git pull'
alias gps='git push'
alias gpr='git push -u origin'
alias gcm='git commit'

# PATH
export PATH="$PATH:/sbin:/usr/sbin:/snap/bin:$HOME/bin:$HOME/.local/bin"

# language
export LANG=en_US.UTF-8

# for fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

echo "[;1mWelcome `whoami` ![m"

if [ -e ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

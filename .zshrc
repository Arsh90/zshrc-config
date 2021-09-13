if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx &>/dev/null
fi

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh my zsh folder
export ZSH="/home/arsh/.oh-my-zsh"

source ~/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-dircolors-nord/zsh-dircolors-nord.zsh

test -r ~/.dir_colors && eval $(dircolors ~/.dir_colors)


ZSH_THEME="powerlevel10k/powerlevel10k"

HYPHEN_INSENSITIVE="true"

# Zsh corrections
ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

# Oh my zsh plugins
plugins=(zsh-autosuggestions zsh-completions zsh-syntax-highlighting history-substring-search thefuck z ripgrep fzf fd colored-man-pages command-not-found history zsh_reload archlinux catimg git tmux taskwarrior adb pass ufw systemd auto-notify zsh-dircolors-nord)

#For z
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

export FZF_BASE=/usr/bin/fzf

source $ZSH/oh-my-zsh.sh

# User configuration

function rm {
  if [[ "$#" -eq 0 ]]; then
    local files
    files=$(ls | fzf --multi)
    echo $files | xargs rm
  else
    command rm "$@"
  fi
}

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

# Aiases
alias zshconf="nvim ~/.zshrc"
alias yayinst="yay -Slq | fzf -m --preview 'yay -Si {1}' | xargs -ro sudo yay -S"
alias r="ranger"
alias cat="bat"
alias f='cd $(fd -H -t d -d 1 | fzf)'
alias tmux='tmux -u'
alias qtilecheck="python3 -m py_compile ~/.config/qtile/config.py"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#completion
autoload -U compinit && compinit

#for thefuck
eval $(thefuck --alias)

# colorscheme for fzf
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'  --color fg:7,bg:-1,hl:6,fg+:6,bg+:-1,hl+:6 --color info:2,prompt:1,spinner:5,pointer:5,marker:3,header:8'

#for bat theme
export BAT_THEME="base16"

#Shit, forgot whats this is for
fpath=(~/.zsh.d/ $fpath)

# Hit Q in order to get out of ranger in the directory you're in
function ranger {
  local IFS=$'\t\n'
  local tempfile="$(mktemp -t tmp.XXXXXX)"
  local ranger_cmd=(
  command
  ranger
  --cmd="map Q chain shell echo %d > "$tempfile"; quitall"
)

${ranger_cmd[@]} "$@"
if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
  cd -- "$(cat "$tempfile")" || return
fi
command rm -f -- "$tempfile" 2>/dev/null
}


# Pfetch configuration
export PF_INFO="ascii title os kernel wm pkgs shell term palette"
# for pfetch; term doesn't show properly in tmux
export TERM_PROGRAM="alacritty"


# hide division sign on incomplete line
PROMPT_EOL_MARK=''


#For nnn cd on quit
n ()
{
  # Block nesting of nnn in subshells
  if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
    echo "nnn is already running"
    return
  fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # NOTE: NNN_TMPFILE is fixed, should not be modified
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
      . "$NNN_TMPFILE"
      rm -f "$NNN_TMPFILE" > /dev/null
    fi
  }

#NNN settings
export NNN_COLORS='4231'
export NNN_FCOLORS='00010203040506070a0b0c0d0e0f'
export NNN_OPTS=""
export NNN_BMS='d:~/Documents/personal'
export NNN_PLUG='b:bookmarks;z:fzz;n:nuke;l:launch;s:suedit;b:bulknew'
export NNN_OPENER=/home/barbarossa/.config/nnn/plugins/nuke
export TERMINAL=alacritty
export GUI=1
export NNN_FIFO=/tmp/nnn.fifo
export NNN_TRASH=1
export NNN_ARCHIVE="\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)$"

export LF_ICONS="\
  tw=:\
  st=:\
  ow=:\
  dt=:\
  di=:\
  fi=:\
  ln=:\
  or=:\
  ex=:\
  *.c=:\
  *.cc=:\
  *.clj=:\
  *.coffee=:\
  *.cpp=:\
  *.css=:\
  *.d=:\
  *.dart=:\
  *.erl=:\
  *.exs=:\
  *.fs=:\
  *.go=:\
  *.h=:\
  *.hh=:\
  *.hpp=:\
  *.hs=:\
  *.html=:\
  *.java=:\
  *.jl=:\
  *.js=:\
  *.json=:\
  *.lua=:\
  *.md=:\
  *.php=:\
  *.pl=:\
  *.pro=:\
  *.py=:\
  *.rb=:\
  *.rs=:\
  *.scala=:\
  *.ts=:\
  *.vim=:\
  *.cmd=:\
  *.ps1=:\
  *.sh=:\
  *.bash=:\
  *.zsh=:\
  *.fish=:\
  *.tar=:\
  *.tgz=:\
  *.arc=:\
  *.arj=:\
  *.taz=:\
  *.lha=:\
  *.lz4=:\
  *.lzh=:\
  *.lzma=:\
  *.tlz=:\
  *.txz=:\
  *.tzo=:\
  *.t7z=:\
  *.zip=:\
  *.z=:\
  *.dz=:\
  *.gz=:\
  *.lrz=:\
  *.lz=:\
  *.lzo=:\
  *.xz=:\
  *.zst=:\
  *.tzst=:\
  *.bz2=:\
  *.bz=:\
  *.tbz=:\
  *.tbz2=:\
  *.tz=:\
  *.deb=:\
  *.rpm=:\
  *.jar=:\
  *.war=:\
  *.ear=:\
  *.sar=:\
  *.rar=:\
  *.alz=:\
  *.ace=:\
  *.zoo=:\
  *.cpio=:\
  *.7z=:\
  *.rz=:\
  *.cab=:\
  *.wim=:\
  *.swm=:\
  *.dwm=:\
  *.esd=:\
  *.jpg=:\
  *.jpeg=:\
  *.mjpg=:\
  *.mjpeg=:\
  *.gif=:\
  *.bmp=:\
  *.pbm=:\
  *.pgm=:\
  *.ppm=:\
  *.tga=:\
  *.xbm=:\
  *.xpm=:\
  *.tif=:\
  *.tiff=:\
  *.png=:\
  *.svg=:\
  *.svgz=:\
  *.mng=:\
  *.pcx=:\
  *.mov=:\
  *.mpg=:\
  *.mpeg=:\
  *.m2v=:\
  *.mkv=:\
  *.webm=:\
  *.ogm=:\
  *.mp4=:\
  *.m4v=:\
  *.mp4v=:\
  *.vob=:\
  *.qt=:\
  *.nuv=:\
  *.wmv=:\
  *.asf=:\
  *.rm=:\
  *.rmvb=:\
  *.flc=:\
  *.avi=:\
  *.fli=:\
  *.flv=:\
  *.gl=:\
  *.dl=:\
  *.xcf=:\
  *.xwd=:\
  *.yuv=:\
  *.cgm=:\
  *.emf=:\
  *.ogv=:\
  *.ogx=:\
  *.aac=:\
  *.au=:\
  *.flac=:\
  *.m4a=:\
  *.mid=:\
  *.midi=:\
  *.mka=:\
  *.mp3=:\
  *.mpc=:\
  *.ogg=:\
  *.ra=:\
  *.wav=:\
  *.oga=:\
  *.opus=:\
  *.spx=:\
  *.xspf=:\
  *.pdf=:\
  *.nix=:\
  "

export OPENER=rifle
printf "\033]0; $(pwd | sed "s|$HOME|~|") - lf\007" > /dev/tty

lf () {
  tmp="$(mktemp)"
  /usr/bin/lfrun --last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp"
    if [ -d "$dir" ]; then
      if [ "$dir" != "$(pwd)" ]; then
        cd "$dir"
      fi
    fi
  fi
}

#Auto notify settings
export AUTO_NOTIFY_THRESHOLD=15
export AUTO_NOTIFY_TITLE="Hey! %command has just finished"
export AUTO_NOTIFY_BODY="It completed in %elapsed seconds with exit code %exit_code"
export AUTO_NOTIFY_EXPIRE_TIME=5000

zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==35=35}:${(s.:.)LS_COLORS}")';
zstyle ':completion:*:descriptions' format $'\e[01;33m %d\e[0m'
zstyle ':completion:*:messages' format $'\e[01;31m %d\e[0m'

alias luamake=/home/arsh/.config/lua-language-server/3rd/luamake/luamake

export PATH="$PATH:$HOME/bin"


alias woofetch="~/.config/woofetch"

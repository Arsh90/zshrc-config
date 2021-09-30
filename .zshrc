#  ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄   ▄▄ ▄▄▄▄▄▄   ▄▄▄▄▄▄▄ 
# █       █       █  █ █  █   ▄  █ █       █
# █▄▄▄▄   █  ▄▄▄▄▄█  █▄█  █  █ █ █ █       █
#  ▄▄▄▄█  █ █▄▄▄▄▄█       █   █▄▄█▄█     ▄▄█
# █ ▄▄▄▄▄▄█▄▄▄▄▄  █   ▄   █    ▄▄  █    █   
# █ █▄▄▄▄▄ ▄▄▄▄▄█ █  █ █  █   █  █ █    █▄▄ 
# █▄▄▄▄▄▄▄█▄▄▄▄▄▄▄█▄▄█ █▄▄█▄▄▄█  █▄█▄▄▄▄▄▄▄█




# ██▀ ▀▄▀ █▀▄ ▄▀▄ █▀▄ ▀█▀ ▄▀▀
# █▄▄ █ █ █▀  ▀▄▀ █▀▄  █  ▄██

export ZSH="/home/arsh/.oh-my-zsh"
fpath=(~/.zsh.d/ $fpath)



# ▄▀▄ █▀▄ █▀▄ ██▀ █▀▄ ▄▀▄ █▄ █ ▄▀▀ ██▀
# █▀█ █▀  █▀  █▄▄ █▀▄ █▀█ █ ▀█ ▀▄▄ █▄▄

# Zsh Highlighing and Nord Colors
source ~/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-dircolors-nord/zsh-dircolors-nord.zsh
test -r ~/.dir_colors && eval $(dircolors ~/.dir_colors)

ZSH_THEME="common"


# colorscheme for fzf
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'  --color fg:7,bg:-1,hl:6,fg+:6,bg+:-1,hl+:6 --color info:2,prompt:1,spinner:5,pointer:5,marker:3,header:8'

#for bat theme
export BAT_THEME="base16"


# Pfetch configuration
export PF_INFO="ascii title os kernel de pkgs shell term editor palette"
export TERM_PROGRAM="kitty"
export EDITOR="nvim"
export XDG_CURRENT_DESKTOP="Qtile"
PROMPT_EOL_MARK=''


# █▀▄ █   █ █ ▄▀  █ █▄ █ ▄▀▀
# █▀  █▄▄ ▀▄█ ▀▄█ █ █ ▀█ ▄██

plugins=(zsh-autosuggestions zsh-completions zsh-syntax-highlighting history-substring-search thefuck ripgrep fzf fd colored-man-pages command-not-found history zsh_reload archlinux catimg git tmux taskwarrior adb pass ufw systemd auto-notify zsh-dircolors-nord)


export FZF_BASE=/usr/bin/fzf

source $ZSH/oh-my-zsh.sh




# ▄▀▄ █   █ ▄▀▄ ▄▀▀ ██▀ ▄▀▀
# █▀█ █▄▄ █ █▀█ ▄██ █▄▄ ▄██

alias zshconf="nvim ~/.zshrc"
alias f='cd $(fd -H -t d -d 1 | fzf)'
alias tmux='tmux -u'
alias qtilecheck="python3 -m py_compile ~/.config/qtile/config.py"
alias class="/home/arsh/script/classes"
alias ls="lsd"
alias l="lsd -l"
alias la="lsd -a"
alias lla="lsd -la"
alias lt="lsd --tree"


# █ █ ▄▀▀ ██▀ █▀ █ █ █     ▄▀▀ ▀█▀ █ █ █▀ █▀
# ▀▄█ ▄██ █▄▄ █▀ ▀▄█ █▄▄   ▄██  █  ▀▄█ █▀ █▀

#completion
autoload -U compinit && compinit

# Correct previous commands
eval $(thefuck --alias)

# When using autocomplete "-" or "_" are interchangable
HYPHEN_INSENSITIVE="true"

# Notify When Command Finishes
export AUTO_NOTIFY_THRESHOLD=15
export AUTO_NOTIFY_TITLE="Hey! %command has just finished"
export AUTO_NOTIFY_BODY="It completed in %elapsed seconds with exit code %exit_code"
export AUTO_NOTIFY_EXPIRE_TIME=5000

zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==35=35}:${(s.:.)LS_COLORS}")';
zstyle ':completion:*:descriptions' format $'\e[01;33m %d\e[0m'
zstyle ':completion:*:messages' format $'\e[01;31m %d\e[0m'

# Something related to rm

function rm {
  if [[ "$#" -eq 0 ]]; then
    local files
    files=$(ls | fzf --multi)
    echo $files | xargs rm
  else
    command rm "$@"
  fi
}


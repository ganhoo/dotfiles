export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PATH="/usr/local/opt/maven@3.5/bin:$PATH:$HOME/bin"
export BAT_THEME="Monokai Extended Bright"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_191.jdk/Contents/Home"
#export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH:$JAVA_HOME"
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"

export FZF_DEFAULT_OPTS=" --border
--height 80%
--extended
--ansi
--reverse
--cycle
--bind alt-p:preview-up,alt-n:preview-down
--bind ctrl-u:half-page-up
--bind ctrl-d:half-page-down
--bind alt-a:select-all,ctrl-r:toggle-all
--bind ctrl-s:toggle-sort
--bind ?:toggle-preview,alt-w:toggle-preview-wrap
--bind \"ctrl-y:execute-silent(ruby -e 'puts ARGV' {+} | pbcopy)+abort\"
--preview-window right:50%:hidden
"

#  History {{{
export HISTFILE="$HOME/.zsh_history" # History file
export HISTSIZE=100000               # History size in memory
export SAVEHIST=1000000              # The number of histsize
export LISTMAX=50                    # The size of asking history
setopt EXTENDED_HISTORY              # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY            # Write to the history file immediately, not when the shell exits.
# setopt SHARE_HISTORY               # Share history between all sessions.
setopt HIST_IGNORE_SPACE             # Do not record an entry starting with a space.
setopt HIST_REDUCE_BLANKS            # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY                   # Do not execute immediately upon history expansion.
setopt HIST_BEEP                     # Beep when accessing nonexistent history.
# Do not add in root
[[ "$UID" == 0 ]] && unset HISTFILE && SAVEHIST=0
#  }}} History

ZPLUG_INIT=~/.zplug/init.zsh
[[ -f "$ZPLUG_INIT" ]] || curl -sL https://raw.githubusercontent.com/zplug/installer/master/installer.zsh |zsh
source "$ZPLUG_INIT"
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Git alias. See: https://github.com/robbyrussell/oh-my-zsh/wiki/Plugin:git
zplug "plugins/git", from:oh-my-zsh
# Git completions. On OS X with Homebrew, you need to install git with brew install git --without-completions. Otherwise, git's _git will take precedence, and you won't see the completions for git-extras commands.
zplug "plugins/git-extras", from:oh-my-zsh
#zplug "plugins/cp", from:oh-my-zsh
(( $+commands[mvn]        )) && zplug "plugins/mvn",        from:oh-my-zsh, lazy:yes
(( $+commands[docker]     )) && zplug "plugins/docker",     from:oh-my-zsh, lazy:yes
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(forward-word forward-char)
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(end-of-line)

zplug "felixonmars/ydcv", as:command, use:"src/ydcv.py", rename-to:"ydcv"
zplug "wfxr/formarks"
zplug 'wfxr/forgit', defer:1
FORGIT_FZF_DEFAULT_OPTS="
--height '80%'
"
zplug "wfxr/emoji-cli", as:plugin
zplug "wfxr/emoji-cli", as:command, use:'emojify|fuzzy-emoji'
EMOJI_CLI_KEYBIND='^[m'
zplug 'wfxr/epoch-cli', as:plugin

zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    read -q && echo && zplug install
fi

zplug load

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.zsh_fzf_extra 2>/dev/null
tmux source-file ~/.tmux.conf 2>/dev/null

alias vimrc='vim ~/.vimrc'
alias zshrc='vim ~/.zshrc'
alias tmuxconf='vim ~/.tmux.conf'
alias dot='cd ~/dotfiles'
#hash exa &>/dev/null && alias ls='exa' || alias ls='ls --color'
hash lsd &>/dev/null && alias  ls='lsd' || alias ls='ls --color'
alias ll='ls -lh'
alias l='ls -lah'
alias cat='bat'
alias pc='pbcopy'
alias pp='pbpast'

#自动补全选项
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*:*:default' force-list always
zstyle ':completion:*' select-prompt '%SSelect:  lines: %L  matches: %M  [%p]'

zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

#补全色彩配置
# eval $(dircolors -b)
export ZLSCOLORS="${LS_COLORS}"
zmodload zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# source <(kubectl completion zsh)

function pre-commit-hook-gen() {
    (
    cd "$(git rev-parse --show-toplevel)" || return 1
    hook=.git/hooks/pre-commit
    cat >"$hook" <<-'EOF'
#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

ROOT=$(git rev-parse --show-toplevel)
cd "$ROOT"

VER=$(head -n 1 version)
if [[ $VER != *-SNAPSHOT ]]; then
    VER_RE='^([0-9]+).([0-9]+).([0-9]+)$'
    if [[ $VER =~ $VER_RE ]]; then
        MAJOR=${BASH_REMATCH[1]}
        MINOR=${BASH_REMATCH[2]}
        PATCH=${BASH_REMATCH[3]}

        PATCH=$((PATCH + 1))
        echo "$MAJOR.$MINOR.$PATCH-SNAPSHOT" > version
        git add version
    else
        echo 'Invalid version detected. Should be "MAJOR.MINOR.PATCH" format' >&2
        exit 1
    fi
fi
EOF
    chmod +x "$hook"
    )
}

function git-tag-with-version() {
    [ $# -eq 0 ] && git tag -l --sort=v:refname && return 0
    (
    IFS=$'\n\t'

    ROOT=$(git rev-parse --show-toplevel)
    cd "$ROOT"

    if [[ -n $(git status -s) ]]; then
        printf 'modified/untracked:\n\n'
        git status -s
        exit 1
    fi

    tag=$1
    echo "$tag" > version

    git add version
    git commit --no-verify -m "$tag"
    git tag "$tag"
    )
} && alias gtv=git-tag-with-version
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles
export OPENAI_API_KEY='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'

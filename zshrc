
export FZF_DEFAULT_OPTS="
--border
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

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PATH="/usr/local/opt/maven@3.5/bin:$PATH"

alias vimrc='vim ~/.vimrc'
alias zshrc='vim ~/.zshrc'
alias tmuxconf='vim ~/.tmux.conf'
alias dot='cd ~/dotfiles'
alias ls='exa'

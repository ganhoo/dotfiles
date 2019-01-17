#!/bin/bash
  
# mail: liutong@zmeng123.com
  
# Created Time: 一  7/ 2 11:58:42 2018
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || return 1
ln -sf  "$SCRIPT_DIR/vimrc"              ~/.vimrc
ln -sf  "$SCRIPT_DIR/tmux.conf"              ~/.tmux.conf
ln -sf  "$SCRIPT_DIR/zshrc"             ~/.zshrc
ln -sf  "$SCRIPT_DIR/zsh_fzf_extra"             ~/.zsh_fzf_extra

# git config
git config --global user.email "437341974@qq.com"
git config --global user.name "Liu Tong"
# avoid enter password again and again
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'

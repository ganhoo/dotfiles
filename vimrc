"vim: ft=vim:
set nu              " 显示行号
set showcmd         " 输入的命令显示出来，看的清楚些

set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8

let mapleader = ','

"新建.sh,.py文件，自动插入文件头
" autocmd BufNewFile *.sh,*.py,*.java exec ":call SetTitle()"
""定义函数SetTitle，自动插入文件头
func SetTitle()
	"如果文件类型为.sh文件
	" if &filetype == 'sh'
		call setline(1,"#!/usr/bin/env bash")
	call append(line("."),"#===============================================================================")
		call append(line(".")+1, "\#   Author: Liutong")
		call append(line(".")+2, "\#   Email: liutong@zmeng123.com")
		call append(line(".")+3, "\#  Created Time: ".strftime("%Y-%m-%d %H:%M"))
	call append(line(".")+4,"#===============================================================================")
	" endif

endfunc
"新建.sh,.py文件，自动插入文件头
autocmd BufNewFile *.sh call SetTitle()
function HeaderPython(  )
	call setline(1,"# !/usr/bin/env python2")
	call append(line("."),"#-*- coding: utf-8 -*-")
	call append(line(".")+1,"# vim:fenc=utf-8")
	call append(line(".")+2,"#===============================================================================")
	call append(line(".")+3,"\# Email: liutong@zmeng123.com")
	call append(line(".")+4,"\# Author: Liutong")
	call append(line(".")+5,"\# Created Time: "  .strftime("%Y-%m-%d %H:%M"))
	call append(line(".")+6,"#===============================================================================")
endf
autocmd bufnewfile *.py call HeaderPython(  )

nmap <leader>w :w!<cr>
nmap <leader>f :find<cr>
" 映射全选+复制 ctrl+a
map <C-A> ggVGY
map! <C-A> <Esc>ggVGY
map <F12> gg=G
" 选中状态下 Ctrl+c 复制
vmap <C-c> "+y

" 自动缩进
set autoindent
set cindent
" Tab键的宽度
set tabstop=4

" 统一缩进为4
set softtabstop=4
set shiftwidth=4

function! ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endfunction
filetype plugin indent on

"打开文件类型检测, 加了这句才可以用智能补全
set completeopt=longest,menu
set cursorline
set textwidth=100
" Transparent setting
hi VertSplit ctermbg=NONE guibg=NONE
hi Normal    ctermbg=NONE guibg=NONE

" Auto install vim-plug {{{ "
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" }}} Auto install vim-plug "

call plug#begin('~/.vim/plugged')
" tpope/vim-sensible {{{ "
if !has('nvim')
	Plug 'tpope/vim-sensible' " no nead for nvim
endif
" }}} tpope/vim-sensible "
Plug 'tomasr/molokai'
Plug 'Valloric/YouCompleteMe'
" Let ale do it
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
" 配置默认的ycm_extra_conf.py
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
" 打开vim时不再询问是否加载ycm_extra_conf.py配置
let g:ycm_confirm_extra_conf = 0
" 注释补全开关
let g:ycm_complete_in_comments = 1
" 字符串补全开关:关闭会导致在包含双引号形式的头文件时无法补全！
let g:ycm_complete_in_strings = 1
" 基于标签收集引擎
let g:ycm_collect_identifiers_from_tags_files = 1
" 基于注释和字符串的收集引擎
let g:ycm_collect_identifiers_from_comments_and_strings = 1
" 语言关键字补全
let g:ycm_seed_identifiers_with_syntax = 1
" 从第n个字符开始展开补全
let g:ycm_min_num_of_chars_for_completion = 1
" 添加UltiSnips进行snippet补全
let g:ycm_use_ultisnips_completer = 1
" 关闭函数原型等补全预览窗口
set completeopt=menu,menuone
" 补全完成后关闭预览窗口
" let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_add_preview_tocompleteopt = 0
let g:ycm_filetype_blacklist = { }
" 关闭js文件补全（需要js项目配置文件，类似C++，麻烦）
" let g:ycm_filetype_specific_completion_to_disable = {'javascript': 1}
let g:ycm_always_populate_location_list = 1
" 直接显示补全（全局类型、变量、宏或函数等补全需要
let g:ycm_key_invoke_completion = '<C-x>'
" 停止补全
let g:ycm_key_list_stop_completion = ['<C-g>']
let g:ycm_semantic_triggers =  {
            \ 'c,cpp,python,java,go,rust,erlang,perl,cs,lua,javascript': ['re!\w{3}'],
            \ 'clojure': ['re!\w{2}[\w/]'],
            \ }
nmap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
" autocmd FileType c,cpp,cs,python,ruby,java,go,rust,erlang,perl
            " \ nmap <buffer> <c-t> <c-o>|
            " \ nmap <buffer> <c-]> :YcmCompleter GoToDefinitionElseDeclaration<CR>|
            " \ nmap <buffer> <leader>F :YcmCompleter FixIt<CR>
" }}} YouCompleteMe "

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tmux-plugins/vim-tmux', { 'for': 'tmux' }
Plug 'junegunn/vim-github-dashboard' | let g:github_dashboard = { 'username': 'ganhoo' }
Plug 'junegunn/goyo.vim'             | nnoremap <Leader>G :Goyo<CR>
Plug 'tpope/vim-surround'

" auto-pairs {{{ "
Plug 'jiangmiao/auto-pairs'
let g:AutoPairsMultilineClose = 0
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsShortcutBackInsert = ''
" }}} auto-pairs "

" limelight {{{ "
Plug 'junegunn/limelight.vim'
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1
function! s:goyo_enter()
	silent :execute "normal! mL"
	if exists('$TMUX')
		silent !tmux set status off
	endif
	setl foldlevel=99
	setl nowrap
	setl nocursorline
	let &background = &background
	Limelight
	let &l:statusline = '%M'
	hi StatusLine ctermfg=red guifg=red cterm=NONE gui=NONE
endfunction
function! s:goyo_leave()
	if exists('$TMUX')
		silent !tmux set status on
	endif
	Limelight!
	let &background = &background
	hi VertSplit ctermbg=NONE guibg=NONE
	hi Normal    ctermbg=NONE guibg=NONE
	silent :execute "normal! `L"
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
nnoremap <silent> <Leader>L :Limelight!!<cr>
" }}} limelight "

" mhinz/vim-startify {{{ "
Plug 'mhinz/vim-startify'
" Shot nerdtree when start vim without argument
" autocmd VimEnter *
" \ if !argc()
" \ |   Startify
" \ |   NERDTree
" \ |   wincmd w
" \ | endif
" }}} mhinz/vim-startify "

" AndrewRadev/switch.vim {{{ "
Plug 'AndrewRadev/switch.vim'
" gs/gr to switch or switch reverse
let g:switch_mapping = "-"
let g:switch_reverse_mapping = '_'
" }}} AndrewRadev/switch.vim "

" scrooloose/nerdcommenter {{{ "
" Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdcommenter'
let NERDSpaceDelims = 1
let g:NERDCreateDefaultMappings = 0
let g:NERDTrimTrailingWhitespace = 1
let g:NERDCompactSexyComs = 1
let g:NERDCommentEmptyLines = 1
" For some reason, vim registers <C-/> as <C-_>
nnoremap <c-_> :call NERDComment(0, "toggle")<CR>j
vnoremap <c-_> :call NERDComment(0, "toggle")<CR>'>j
" Copy & comment
nmap <leader>cc yyP<c-_>
vmap <leader>cc yPgp<c-_>
" }}} scrooloose/nerdcommenter "

" Yggdroot/indentLine {{{ "
Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesToggle' }
let g:indentLine_enabled = 0
" autocmd Filetype *yaml,*xml,c,cpp,go,rust,java let g:indentLine_enabled = 1
autocmd Filetype json,markdown let g:indentLine_setConceal = 0
let g:indentLine_char = '│'
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#4E4E4E'
map <leader>il :IndentLinesToggle<CR>
" }}} Yggdroot/indentLine "

" sbdchd/neoformat {{{ "
Plug 'sbdchd/neoformat'
" Enable alignment
let g:neoformat_basic_format_align = 1
" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1
" Enable trimming of trailing whitespace
let g:neoformat_basic_format_trim = 1
nnoremap <c-a-l> :Neoformat<cr>
" }}} sbdchd/neoformat "

" ultisnips && vim-snippets {{{ "
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" Trigger configuration. Do not use <tab> if you use 'YouCompleteMe'
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="horizontal"
autocmd Filetype snippet set shiftwidth=4
" }}} ultisnips && vim-snippets "

" ale {{{ "
" Best lint engine(require neovim or vim version > 8)
Plug 'w0rp/ale'
let g:ale_lint_on_insert_leave = 1
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_error_str = 'E'
let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_format = '[%severity%][%linter%] %s'
let g:ale_cpp_clang_options = '-Wall -std=c++17'
let g:ale_cpp_gcc_options = g:ale_cpp_clang_options
nmap <silent> <a-p> <Plug>(ale_previous_wrap)
nmap <silent> <a-n> <Plug>(ale_next_wrap)
" }}} ale "

call plug#end()
colorscheme molokai

" Custom functions {{{ "
" Open repo in browser
function! s:go_github()
    let s:repo = matchstr(expand("<cWORD>"), '\v[0-9A-Za-z\-\.\_]+/[0-9A-Za-z\-\.\_]+')
    if empty(s:repo)
        echo "GoGithub: No repository found."
    else
        let s:url = 'https://github.com/' . s:repo
        call netrw#BrowseX(s:url, 0)
    end
endfunction
autocmd FileType *vim,*zsh,*bash,*tmux nnoremap <buffer> <silent> <cr> :call <sid>go_github()<cr>
" }}} Custom functions "

" Zoom {{{ "
function! s:zoom()
  if winnr('$') > 1
    tab split
  elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
                  \ 'index(v:val, '.bufnr('').') >= 0')) > 1
    tabclose
  endif
endfunction
nnoremap <silent> <c-w><c-w> :call <sid>zoom()<cr>
" }}} Zoom "

syntax on "自动语法高亮
set nu              " 显示行号
set showcmd         " 输入的命令显示出来，看的清楚些 
set ruler           " 显示标尺 
set laststatus=1    " 启动显示状态行(1),总是显示状态行(2) 
  
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936  
set termencoding=utf-8  
set encoding=utf-8  
set fileencodings=ucs-bom,utf-8,cp936  
set fileencoding=utf-8  

"新建.sh,.py文件，自动插入文件头   
autocmd BufNewFile *.sh,*.py,*.java exec ":call SetTitle()"   
""定义函数SetTitle，自动插入文件头   
func SetTitle()   
    "如果文件类型为.sh文件   

	if &filetype == 'sh'	
	  call setline(1,"#!/bin/bash")
      call append(line("."),"  ")
      call append(line(".")+1, "\# mail: liutong@zmeng123.com")
      call append(line(".")+2,"  ")
      call append(line(".")+3, "\# Created Time: ".strftime("%c"))
	  call append(line(".")+4,"  ")
	endif

endfunc 
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

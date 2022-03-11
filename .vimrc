"return" 2>&- || "exit"
""vundle
set nu
set nocompatible    "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
set cursorline
set tabstop=4       " Tab键的宽度
set laststatus=2    "文件信息显示
set shortmess=atI   " 启动的时候不显示那个援助乌干达儿童的提示
set showcmd         " 输入的命令显示出来，看的清楚些
set scrolloff=3     " 光标移动到buffer的顶部和底部时保持3行距离
set autoindent      " 自动缩进
set expandtab       " 使用空格代替制表符
set softtabstop=4   " 统一缩进为4
set shiftwidth=4    " 统一缩进为4

syntax on           " 语法高亮显示
autocmd InsertEnter * se cul    " 用浅色高亮当前行
set ruler           " 显示标尺  
set backspace=2     " 使回格键（backspace）正常处理indent, eol, start等
set whichwrap+=<,>,h,l " 允许backspace和光标键跨越行边界


filetype on         " 检测文件的类型
filetype plugin on  " 载入文件类型插件
filetype indent on  " 为特定文件类型载入相关缩进文件

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"自动安装插件管理器
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    augroup vim-plug_
        autocmd!
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    augroup END
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 插件开始
call plug#begin()
	Plug 'liuchengxu/space-vim-dark'            "python
	Plug 'davidhalter/jedi-vim'                 "python
	Plug 'vim-scripts/indentpython.vim'         "python
	Plug 'Yggdroot/indentLine'                  "缩进线
	Plug 'Lokaltog/vim-powerline'               "缩进线
	Plug 'Yggdroot/indentLine'                  "缩进线
	Plug 'frazrepo/vim-rainbow'                 "彩虹括号改进
	Plug 'tell-k/vim-autopep8'
	Plug 'itchyny/lightline.vim'                "文件信息
	Plug 'preservim/nerdcommenter'
	Plug 'mattn/emmet-vim'                      "html
	Plug 'vim-syntastic/syntastic'              "语法检查
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 语法检查用于vim-syntastic/syntastic插件
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_seed_identifiers_with_syntax=1        "是否开启语义补全"
let g:indentLine_char='┆'                       "缩进指示线
let g:indentLine_enabled = 1                    "缩进指示线

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py,*.m exec ":call SetTitle()"
""定义函数SetTitle，自动插入文件头
func SetTitle()
	"如果文件类型为.sh文件
	if &filetype == 'sh'
		call setline(1,"\#!/bin/bash")
		call append(line("."), "")
    elseif &filetype == 'python'
		call setline(1, "#!/usr/bin/python3")
		call append(line("."), "# coding:UTF-8")
		call append(line(".")+1, "'''")
		call append(line(".")+2, "> File Name:".expand("%"))
		call append(line(".")+3, "> Author:liuFeng")
		call append(line(".")+4, "> Mail:1336007004@qq.com")
		call append(line(".")+5, "> Created Time: ".strftime("%c"))
		call append(line(".")+6, "'''")
		call append(line(".")+7, "#  ************************************************************************/")
		call append(line(".")+8, "")

    elseif &filetype == 'ruby'
        call setline(1,"#!/usr/bin/env ruby")
        call append(line("."),"# encoding: utf-8")
	    call append(line(".")+1, "")

	else
		call setline(1, "/*************************************************************************")
		call append(line("."), "	> File Name: ".expand("%"))
		call append(line(".")+1, "	> Author: liuFeng ")
		call append(line(".")+2, "	> Mail:1336007004@qq.com ")
		call append(line(".")+3, "	> Created Time: ".strftime("%c"))
		call append(line(".")+4, " ************************************************************************/")
		call append(line(".")+5, "")
	endif
	if expand("%:e") == 'cpp'
		call append(line(".")+6, "#include<iostream>")
		call append(line(".")+7, "using namespace std;")
		call append(line(".")+8, "")
	endif
	if &filetype == 'c'
		call append(line(".")+6, "#include<stdio.h>")
		call append(line(".")+7, "")
	endif
	if expand("%:e") == 'h'
		call append(line(".")+6, "#ifndef _".toupper(expand("%:r"))."_H")
		call append(line(".")+7, "#define _".toupper(expand("%:r"))."_H")
		call append(line(".")+8, "#endif")
	endif
	if &filetype == 'java'
		call append(line(".")+6,"public class ".expand("%:r"))
		call append(line(".")+7,"")
	endif
	"新建文件后，自动定位到文件末尾
endfunc
autocmd BufNewFile * normal G

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Quickly Run
    """"""""""""""""""""""
    map <F5> :call CompileRunGcc()<CR>
    func! CompileRunGcc()
        exec "w"
        if &filetype == 'c'
            exec "!g++ % -o %<"
            exec "!time ./%<"
        elseif &filetype == 'cpp'
            exec "!g++ % -o %<"
            exec "!time ./%<"
        elseif &filetype == 'java'
            exec "!javac %"
            exec "!time java %<"
        elseif &filetype == 'sh'
            :!time bash %
        elseif &filetype == 'python'
            exec "!time python3 %"
        elseif &filetype == 'html'
            exec "!firefox % &"
        elseif &filetype == 'go'
    "        exec "!go build %<"
            exec "!time go run %"
        elseif &filetype == 'mkd'
            exec "!~/.vim/markdown.pl % > %.html &"
            exec "!firefox %.html &"
        endif
    endfunc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 打开上次的位置
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
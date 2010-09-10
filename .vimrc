set encoding=utf-8
set tabstop=4
set ruler
set listchars=tab:>-,trail:_ list
set incsearch " http://stackoverflow.com/questions/1276403/simple-vim-commands-you-wish-youd-known-earlier/1295244#1295244

autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

autocmd BufNewFile *.sh,*.bash 0put =\"#!/bin/bash\<nl># -*- coding: UTF8 -*-\<nl>\<nl>\"|$

syntax on

set encoding=utf-8

syntax on "turn on syntax highlighting
colorscheme elflord


set showcmd "show incomplete cmds down the bottom
set showmode "show current mode down the bottom

set incsearch "find the next match as we type the search
set hlsearch "highlight searches by default

set nowrap "dont wrap lines
set linebreak "wrap lines at convenient points
set wrap "wrap entire words, don't break them; much easier to read!

set ruler " set ruler on
set number " set line numbering on

if has("gui_running")
	set cursorline " highlight current line
end

set switchbuf=useopen "don't reopen already opened buffers

set wildmenu "make tab completion act more like bash
set wildmode=list:longest "tab complete to longest common string, like bash

set cmdheight=2 "make the command line a little taller to hide "press enter to viem more" text

set backspace=indent,eol,start " set nice backspace

set listchars=tab:>-,trail:_ list " insert _ as space while typing AND insert >--- as one tab

" set spaces and tabs
set tabstop=4
set autoindent
set preserveindent
set smarttab
set softtabstop=4
set shiftwidth=4

" Make tabs work like we're used to
map <C-Tab> :tabnext<CR>
map <C-S-Tab> :tabprev<CR>

filetype plugin indent on "enable automatic filetype detection, filetype-specific plugins/indentation

autocmd BufNewFile *.sh,*.bash 0put =\"#!/bin/bash\<nl># -*- coding: UTF8 -*-\<nl>\<nl>\"|$

autocmd FileType html :set omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP


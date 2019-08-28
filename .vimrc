"=========
"General Setting
"=========
set title
set fenc=utf-8
set showcmd
set showmatch
set tabstop=3
set shiftwidth=3
set softtabstop=0
set noexpandtab
set autoindent
set smartindent

"=========
"vim-clang
"=========
" 'Shougo/neocomplete.vim' {{{
let g:neocomplete#enable_at_startup = 1
if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"""}}}

" 'justmao945/vim-clang' {{{

" disable auto completion for vim-clanG
let g:clang_auto = 0
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_use_library = 1

" default 'longest' can not work with neocomplete
let g:clang_c_completeopt   = 'menuone'
let g:clang_cpp_completeopt = 'menuone'

let g:clang_exec = 'clang'
let g:clang_format_exec = 'clang-format'

let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '
  \ -std=c++1z 
  \ -stdlib=libc++ 
  \ -pedantic-errors
  \ '

" }}}

"=========
"sonictemplate
"=========
" mattn/sonictemplate-vim {{{
let g:sonictemplate_vim_template_dir = ['~/.dotfiles/vim/template']
" }}}

"==========
"dein.vim
"==========
if &compatible
  set nocompatible
endif
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('Shougo/vimproc.vim', {'build': 'make'})
  call dein#add('justmao945/vim-clang')
  call dein#add('Shougo/neoinclude.vim')
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  call dein#add('thinca/vim-quickrun')
  call dein#add('mattn/sonictemplate-vim')
  call dein#end()
endif

" filetype plugin indent on
syntax enable

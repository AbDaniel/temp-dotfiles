" Install vim-plug if needed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
	" Plug '907th/vim-auto-save'
	" Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'airblade/vim-gitgutter'
	" Plug 'b4b4r07/vim-hcl'
	" Plug 'blindfs/vim-taskwarrior'
	" Plug 'cespare/vim-toml'
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'easymotion/vim-easymotion'
	" Plug 'editorconfig/editorconfig-vim'
	" Plug 'euclio/vim-markdown-composer'
	" Plug 'fatih/vim-hclfmt'
	Plug 'tpope/vim-surround' " Surrounding ysw)
	Plug 'easymotion/vim-easymotion'
	" Plug 'junegunn/vim-github-dashboard.git'
	" Plug 'lifepillar/pgsql.vim' " PSQL Pluging needs :SQLSetType pgsql.vim
	Plug 'preservim/tagbar' " Tagbar for code navigation
	Plug 'rafi/awesome-vim-colorschemes' " Retro Scheme
	Plug 'ryanoasis/vim-devicons' " Developer Icons
	Plug 'tc50cal/vim-terminal' " Vim Terminal
	Plug 'terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
	Plug 'tpope/vim-commentary' " For Commenting gcc & gc
	Plug 'vim-airline/vim-airline' " Status bar
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/vim-easy-align'
	Plug 'kana/vim-textobj-entire'
	Plug 'kana/vim-textobj-user'
	Plug 'lambdalisue/suda.vim'
	Plug 'nathanaelkane/vim-indent-guides'
	Plug 'preservim/nerdtree'
	Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
	Plug 'rdnetto/YCM-Generator'
	" Plug 'sbdchd/vim-shebang'
	" Plug 'scrooloose/nerdcommenter'
	" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
	Plug 'sonph/onehalf', { 'rtp': 'vim' }
	Plug 'tpope/vim-fireplace'
	Plug 'tpope/vim-unimpaired'
	Plug 'tpope/vim-sensible'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'vim-scripts/ReplaceWithRegister'
	Plug 'vim-syntastic/syntastic'
    Plug 'svermeulen/vim-cutlass'
    Plug 'jiangmiao/auto-pairs'
call plug#end()

set encoding=UTF-8

""" Map leader to space ---------------------
let mapleader=" "

set clipboard=unnamedplus

""" Mappings --------------------------------
nnoremap zzz :wq<cr>
nnoremap zz :w<cr>
nnoremap Z :q<cr>
inoremap jk <Esc>
nmap ; :
noremap ;; ;
nnoremap ss i<space><Esc>


""" Plugin settings -------------------------
let g:argtextobj_pairs="[:],(:),<:>"
au TextYankPost * silent! lua vim.highlight.on_yank()

""" Plugin Mappings --------------------------------
map <leader>f <Plug>(easymotion-s)
map <leader>e <Plug>(easymotion-f)

set nocompatible
set autoindent
set clipboard=unnamed
set cursorline
set incsearch
set mouse=a
set nu
set number
set relativenumber
set shiftwidth=4
set showmode
set smarttab
set so=5
set softtabstop=4
set t_Co=256
set tabstop=4
set ignorecase
syntax on

colorscheme onehalfdark

let g:airline_theme='onehalfdark'
let g:lightline = { 'colorscheme': 'onehalfdark' }

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif


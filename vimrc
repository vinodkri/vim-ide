
"#########################################################################
"#                  VINOD's Vimrc SETTINGS                               #
"#########################################################################
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" see :h vundle for more details or wiki for FAQ
"#########################################################################
"######### Vundle Plugins #########
" Configured Vundle Plugins {{{1
filetype off
set runtimepath=$VIM,$VIMRUNTIME
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.fzf
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'haya14busa/incsearch.vim'
call vundle#end()
"}}}1

" Plugin Specific Configurations {{{1
	" FZF Plugin --- {{{2
	" An action can be a reference to a function that processes selected lines
	function! s:build_quickfix_list(lines)
	  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
	  copen
	  cc
	endfunction

	let g:fzf_action = {
	  \ 'ctrl-q': function('s:build_quickfix_list'),
	  \ 'ctrl-t': 'tab split',
	  \ 'ctrl-x': 'split',
	  \ 'ctrl-v': 'vsplit' }

	" Default fzf layout
	" - down / up / left / right
	let g:fzf_layout = { 'down': '~40%' }

	" Customize fzf colors to match your color scheme
	"let g:fzf_colors =
	"\ { 'fg':      ['fg', 'Normal'],
	"  \ 'bg':      ['bg', 'Normal'],
	"  \ 'hl':      ['fg', 'Comment'],
	"  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
	"  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
	"  \ 'hl+':     ['fg', 'Statement'],
	"  \ 'info':    ['fg', 'PreProc'],
	"  \ 'border':  ['fg', 'Ignore'],
	"  \ 'prompt':  ['fg', 'Conditional'],
	"  \ 'pointer': ['fg', 'Exception'],
	"  \ 'marker':  ['fg', 'Keyword'],
	"  \ 'spinner': ['fg', 'Label'],
	"  \ 'header':  ['fg', 'Comment'] }

	" Enable per-command history.
	" CTRL-N and CTRL-P will be automatically bound to next-history and
	" previous-history instead of down and up. If you don't like the change,
	" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
	let g:fzf_history_dir = '~/.local/share/fzf-history'
	"}}}2

	" incsearch Plugin --- {{{2
	map /  <Plug>(incsearch-forward)
	map ?  <Plug>(incsearch-backward)
	map g/ <Plug>(incsearch-stay)
	set hlsearch
	set incsearch
	map n  <Plug>(incsearch-nohl-n)
	map N  <Plug>(incsearch-nohl-N)
	map *  <Plug>(incsearch-nohl-*)
	map #  <Plug>(incsearch-nohl-#)
	map g* <Plug>(incsearch-nohl-g*)
	map g# <Plug>(incsearch-nohl-g#)
	"}}}2
"}}}1

" Command line spell corrections {{{1 
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Wq ((getcmdtype() is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))
cnoreabbrev <expr> Wa ((getcmdtype() is# ':' && getcmdline() is# 'Wa')?('wa'):('Wa'))
cnoreabbrev <expr> Qa ((getcmdtype() is# ':' && getcmdline() is# 'Qa')?('qa'):('Qa'))
cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))
"}}}1


" Default settings for vim {{{1
" Enable filetype plugins
filetype on
filetype plugin indent on

"if &diff
""    set background=light
"else
set background=light
"endif

colorscheme default

syntax enable
set syntax=on

" set t_ut=
" Send more characters for redraws
set ttyfast
set nocompatible

" Set this to the name of your terminal that supports mouse codes.
" Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
set ttymouse=xterm2

set wildmenu
set path+=.**

" To Remember
" z. [z followed by a dot (.)] - to put the line with the cursor at the
" center,
" zt - to put the line with the cursor at the top
" zb - to put the line with the cursor at the bottom of the screen.
" z<return> - to put the line with the cursor at the top of the screen

" Set Mouse Scrolling For Normal Mode
set mouse=n
set history=1000                " Store a ton of history default
set ul=1000                     " Undo levels

" Enable persistent undo
"set undofile   " Maintain undo history between sessions
"set undodir=~/.vim/undodir

"UI config
set number "Show line numbers
set relativenumber "Show line numbers
set hlsearch
set laststatus=2
set foldenable

set backspace=indent,eol,start
highlight Search ctermbg=darkmagenta ctermfg=white
highlight VertSplit ctermbg=darkgreen ctermfg=darkgrey
autocmd FileType * setlocal foldmethod=manual

" Use backspace to jump back
nmap <bs> <C-t>
nmap <cr> <c-]>
" My Mappings {{{1
	" Managing tabs {{{2
	    noremap <Tab> gt
	    noremap <S-Tab> gT

	    noremap 0<Tab> 0gt
	    noremap 1<Tab> 1gt
	    noremap 2<Tab> 2gt
	    noremap 3<Tab> 3gt
	    noremap 4<Tab> 4gt
	    noremap 5<Tab> 5gt
	    noremap 6<Tab> 6gt
	    noremap 7<Tab> 7gt
	    noremap 8<Tab> 8gt
	    noremap 9<Tab> 9gt

	    " Opens a new tab with the current buffer's path
	    " Super useful when editing files in the same directory
	    noremap<leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
	"}}}2
"}}}1

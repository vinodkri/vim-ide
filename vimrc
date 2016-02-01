" Enable filetype plugins
filetype plugin on
filetype indent on

colorscheme desert
"colorscheme koehler 
"colorscheme solarized 
"colorscheme darkblue 
if &diff
    colorscheme pablo 
endif

" Set mouse scrolling for normal mode
set mouse=n

set cst
set csto=0
set history=1000                " Store a ton of history (default
set ul=1000                     " Undo levels

"C Syntax
set tabstop=4                   " Number of visual spaces per TAB
set softtabstop=4               " Number of spaces in tab when editing
set expandtab                   " Tabs are spaces
set shiftwidth=4
set smarttab
set wrap                        " Wrap lines

"UI config
set autoindent
set cindent
set number                      " Show line numbers
set cursorline                  " Highlight current line
"filetype indent on             " Load filetype-specific indent files
set wildmenu                    " Visual autocomplete for command menu
set lazyredraw                  " Redraw only when we need to.
set showmatch                   " Highlight matching [{()}]
set noswapfile

"Searching
set incsearch                   " Search as characters are entered
set hlsearch                    " Highlight matches
set ignorecase                  " Search without case

" Smart searching 
set smartcase
set laststatus=2
set title

" Ctags
set tags+=~/.vim/systags
set tags+=/workspace/sw/vinodkri/softwares/dpdk-2.2.0/tags
imap <C-o> <C-x><C-o>

" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast quiting 
nmap <leader>q :q!<cr>
" Fast saving
nmap <leader>w :w!<cr>
" Fast saving & quitting
nmap <leader>e :wq!<cr>
" Fast quiting all
nmap <leader>qa :qall<cr>
" Fast saving all
nmap <leader>wa :wall<cr>
" Fast saving & quitting all
nmap <leader>ea :wqall<cr>

" Disable highlight when <leader><cr> is pressed
noremap<silent> <leader><cr> :noh<cr>

noremap <C-j> J 
" My  Mappings for managing tabs
set path=.,,**
noremap<leader>tn :tabnew<cr>
noremap<leader>to :tabonly<cr>
noremap<leader>tc :tabclose<cr>
noremap<leader>tm :tabmove
noremap<leader>tf :tabfind
noremap<leader>tls :tabs<cr>
noremap<leader>tsp :tab split<cr>
noremap<leader>m gt
noremap<leader>. gT
noremap<leader>n <C-W><S-t>

" Smart way to move between windows
noremap <leader>j <C-W>j
noremap <leader>k <C-W>k
noremap <leader>h <C-W>h
noremap <leader>l <C-W>l

nnoremap <leader>d :setlocal number!<cr>

" Maps Alt-[h,j,k,l] to resizing a window split
nnoremap <S-h> <C-w><
nnoremap <S-l> <C-w>>
nnoremap <S-k> <C-W>-
nnoremap <S-j> <C-W>+
nnoremap <leader>x <C-W>x

" My mappings for managing tabs
"0 or s: Find this C symbol
"1 or g: Find this definition
"2 or d: Find functions called by this function
"3 or c: Find functions calling this function
"4 or t: Find this text string
"6 or e: Find this egrep pattern
"7 or f: Find this file
"8 or i: Find files #including this file

noremap<leader>cs b"zyw:exe "tab cs find 0 ".@z.""<CR>
noremap<leader>cg b"zyw:exe "tab cs find 1 ".@z.""<CR>
noremap<leader>cd b"zyw:exe "tab cs find 2 ".@z.""<CR>
noremap<leader>cc b"zyw:exe "tab cs find 3 ".@z.""<CR>
noremap<leader>ct b"zyw:exe "tab cs find 4 ".@z.""<CR>
noremap<leader>ce b"zyw:exe "tab cs find 6 ".@z.""<CR>
noremap<leader>cf b"zyw:exe "tab cs find 7 ".@z.""<CR>
noremap<leader>ci b"zyw:exe "tab cs find 8 ".@z.""<CR>

" Using ',hcX' searches current word and makes the vim
" window split horizontally, with search result displayed
" in the new window.
noremap<leader>hcs b"zyw:exe "scs find 0 ".@z.""<CR>
noremap<leader>hcg b"zyw:exe "scs find 1 ".@z.""<CR>
noremap<leader>hcd b"zyw:exe "scs find 2 ".@z.""<CR>
noremap<leader>hcc b"zyw:exe "scs find 3 ".@z.""<CR>
noremap<leader>hct b"zyw:exe "scs find 4 ".@z.""<CR>
noremap<leader>hce b"zyw:exe "scs find 6 ".@z.""<CR>
noremap<leader>hcf b"zyw:exe "scs find 7 ".@z.""<CR>
noremap<leader>hci b"zyw:exe "scs find 8 ".@z.""<CR>

" Hitting ',vcsX' searches current word and does a vertical
" split instead of a horizontal one
noremap<leader>vcs b"zyw:exe "vert scs find 0 ".@z.""<CR>
noremap<leader>vcg b"zyw:exe "vert scs find 1 ".@z.""<CR>
noremap<leader>vcd b"zyw:exe "vert scs find 2 ".@z.""<CR>
noremap<leader>vcc b"zyw:exe "vert scs find 3 ".@z.""<CR>
noremap<leader>vct b"zyw:exe "vert scs find 4 ".@z.""<CR>
noremap<leader>vce b"zyw:exe "vert scs find 6 ".@z.""<CR>
noremap<leader>vcf b"zyw:exe "vert scs find 7 ".@z.""<CR>
noremap<leader>vci b"zyw:exe "vert scs find 8 ".@z.""<CR>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
 \ if line("'\"") > 0 && line("'\"") <= line("$") |
 \   exe "normal! g`\"" |
 \ endif
" Remember info about open buffers on close
set viminfo^=%

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
noremap<leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
      hi statusline guibg=Cyan ctermfg=6 guifg=Black ctermbg=0
  elseif a:mode == 'r'
      hi statusline guibg=Purple ctermfg=5 guifg=Black ctermbg=0
  else
      hi statusline guibg=DarkRed ctermfg=1 guifg=Black ctermbg=0
  endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15

" default the statusline to green when entering Vim
hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15

" " Formats the statusline
set statusline+=%F\ %l\:%c
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%y      "filetype
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag

vmap `c :s/^/\/*/<cr>gv:s/$/*\//<cr>:noh<cr>i
vmap `r :s/^\/\*//<cr>gv:s/\*\/$/<cr>:noh<cr>i

let maplocalleader = "`"
autocmd FileType c nnoremap <buffer> <localleader>c I//<esc>
autocmd FileType python     nnoremap <buffer> <localleader>c I#<esc>

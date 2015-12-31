" Enable filetype plugins
filetype plugin on
filetype indent on

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

" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>
" Fast quiting 
nmap <leader>q :q!<cr>
" Fast saving & quitting
nmap <leader>e :wq!<cr>
" Traversing 
map f <S-w>
"noremap <S-w> <w>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" My  Mappings for managing tabs
set path=.,,**
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>tf :tabfind
map <leader>tls :tabs<cr>
map <leader>tsp :tab split<cr>
map <leader>m gt
map <leader>n gT

" Smart way to move between windows
map <leader>j <C-W>j
map <leader>k <C-W>k
map <leader>h <C-W>h
map <leader>l <C-W>l

"0 or s: Find this C symbol
"1 or g: Find this definition
"2 or d: Find functions called by this function
"3 or c: Find functions calling this function
"4 or t: Find this text string
"6 or e: Find this egrep pattern
"7 or f: Find this file
"8 or i: Find files #including this file

map <leader>cs b"zyw:exe "tab cs find 0 ".@z.""<CR>
map <leader>cg b"zyw:exe "tab cs find 1 ".@z.""<CR>
map <leader>cd b"zyw:exe "tab cs find 2 ".@z.""<CR>
map <leader>cc b"zyw:exe "tab cs find 3 ".@z.""<CR>
map <leader>ct b"zyw:exe "tab cs find 4 ".@z.""<CR>
map <leader>ce b"zyw:exe "tab cs find 6 ".@z.""<CR>
map <leader>cf b"zyw:exe "tab cs find 7 ".@z.""<CR>
map <leader>ci b"zyw:exe "tab cs find 8 ".@z.""<CR>

" Using ',hcX' searches current word and makes the vim
" window split horizontally, with search result displayed
" in the new window.
map <leader>hcs b"zyw:exe "scs find 0 ".@z.""<CR>
map <leader>hcg b"zyw:exe "scs find 1 ".@z.""<CR>
map <leader>hcd b"zyw:exe "scs find 2 ".@z.""<CR>
map <leader>hcc b"zyw:exe "scs find 3 ".@z.""<CR>
map <leader>hct b"zyw:exe "scs find 4 ".@z.""<CR>
map <leader>hce b"zyw:exe "scs find 6 ".@z.""<CR>
map <leader>hcf b"zyw:exe "scs find 7 ".@z.""<CR>
map <leader>hci b"zyw:exe "scs find 8 ".@z.""<CR>

" Hitting ',vcsX' searches current word and does a vertical
" split instead of a horizontal one
map <leader>vcs b"zyw:exe "vert scs find 0 ".@z.""<CR>
map <leader>vcg b"zyw:exe "vert scs find 1 ".@z.""<CR>
map <leader>vcd b"zyw:exe "vert scs find 2 ".@z.""<CR>
map <leader>vcc b"zyw:exe "vert scs find 3 ".@z.""<CR>
map <leader>vct b"zyw:exe "vert scs find 4 ".@z.""<CR>
map <leader>vce b"zyw:exe "vert scs find 6 ".@z.""<CR>
map <leader>vcf b"zyw:exe "vert scs find 7 ".@z.""<CR>
map <leader>vci b"zyw:exe "vert scs find 8 ".@z.""<CR>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
 \ if line("'\"") > 0 && line("'\"") <= line("$") |
 \   exe "normal! g`\"" |
 \ endif
" Remember info about open buffers on close
set viminfo^=%

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

colorscheme desert

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

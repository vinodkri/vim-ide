" Enable filetype plugins
filetype plugin on
filetype indent on

colorscheme desert
"colorscheme solarized 
"colorscheme darkblue 
"colorscheme pablo 
if &diff
    colorscheme koehler 
endif

" This will kill me !!!
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

noremap j jzz
noremap k kzz

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
" Set Cursorline highlight
set cursorline
hi CursorLine   cterm=NONE ctermbg=lightgreen ctermfg=black

"filetype indent on             " Load filetype-specific indent files
set wildmenu                    " Visual autocomplete for command menu
set lazyredraw                  " Redraw only when we need to.
set showmatch                   " Highlight matching [{()}]
set noswapfile

"Searching
set incsearch                   " Search as characters are entered
set hlsearch                    " Highlight matches
set ignorecase                  " Search without case

" Moving lines or blocks
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Smart searching 
set smartcase
set laststatus=2
set title

" Macro's
":g/pattern/normal! @a
":5,10norm! @a
":%norm! @a
" Quick access to @q
nnoremap <Space> @q

"With this set, the first Tab press (or whatever your wildchar is set to) will
"expand a filename or command in command mode to the longest common string it
"can, and a second press will display a list of all possible completions above
"the command line.
set wildmode=longest,list

"New splits appear in unintuitive places
set splitbelow
set splitright

"Jumping lands on centre of screen
nnoremap n nzz
nnoremap } }zz
nnoremap { {zz

" Ctags
set tags+=~/.vim/systags
set tags+=/workspace/sw/vinodkri/softwares/dpdk-2.2.0/tags
imap <C-o> <C-x><C-o>

" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Copy the word under the cursor into command line
"cmap <Leader>g <C-r><C-w>
nmap <Leader>g :<C-r><C-w>
" Moving around command line
cnoremap <C-A> <Home>
cnoremap <C-F> <S-Right>
cnoremap <C-B> <S-Left>

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

" Join subsequent lines.
noremap <C-i> J 

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
if has("cscope") 
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

    "Cscope shortcuts
    " f: Find this file
    " g: Find this definition
    " c: Find functions calling this function
    " s: Find this C symbol
    " t: Find assignments to
    " d: Find functions called by this function 
    command -nargs=+ Csf cs find f <args>
    command -nargs=+ Csg cs find g <args>
    command -nargs=+ Csc cs find c <args>
    command -nargs=+ Css cs find s <args>
    command -nargs=+ Cst cs find t <args>
    command -nargs=+ Csd cs find d <args>
endif   

" Escape
inoremap jj <Esc>

"Copy to Clipboard
noremap<leader>ya "ayy
noremap<leader>ys "syy
noremap<leader>yd "dyy
noremap<leader>yf "fyy
noremap<leader>ye "eyy
noremap<leader>yp "+y

" Copy the selected text into the system clipboard
"{Visual}"+y 
" Copy the text specified by {motion} into the system clipboard
"+y{motion}
" Copy the text specified by [range] into the system clipboard
":[range]yank +

"Append to clipboard
noremap<leader>yA "Ayy

"Paste from clipboard
noremap<leader>p "0p
noremap<leader>pa "ap
noremap<leader>ps "sp
noremap<leader>pd "dp
noremap<leader>pf "fp
noremap<leader>pe "ep
"+p Normal mode put command pastes system clipboard after cursor
noremap<leader>pp "+p
"<C-r>+ From insert mode (or commandline mode)
inoremap<leader>pp <C-r>+
":put + Ex command puts contents of system clipboard on a new line

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

function! InsertModeEnter()
  call InsertStatuslineColor(v:insertmode)
endfunction

function! InsertModeLeave()
  hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15
endfunction

"au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertEnter * call InsertModeEnter()
au InsertLeave * call InsertModeLeave()

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

let maplocalleader = ";"
autocmd FileType c nnoremap <buffer> <localleader>c I//<esc>
autocmd FileType python     nnoremap <buffer> <localleader>c I#<esc>

" NerdTree
"let g:netrw_liststyle=3         " thin (change to 3 for tree)
"let g:netrw_banner=0            " no banner
"let g:netrw_altv=1              " open files on right
"let g:netrw_preview=1           " open previews vertically
""let g:netrw_browse_split=2
"
"augroup NetrwGroup
"      autocmd! BufEnter * call NormalizeWidths()
"augroup END
"
"fun! VexSize(vex_width)
"    execute "vertical resize" . a:vex_width
"    set winfixwidth
"    call NormalizeWidths()
"endf
"
"fun! NormalizeWidths()
"    let eadir_pref = &eadirection
"    set eadirection=hor
"    set equalalways! equalalways
"    let &eadirection = eadir_pref
"endf
"
"fun! VexOpen(dir)
"    let g:netrw_browse_split=2
"    let vex_width=25
"    
"    execute "Vexplore " . a:dir
"    let t:vex_buf_nr = bufnr("%")
"    wincmd H
"
"    call VexSize(vex_width)
"endf
"
"fun! VexClose()
"    let cur_win_nr = winnr()
"    let target_nr = (cur_win_nr == 1 ? winnr("#") : cur_win_nr)
"
"    1wincmd w
"    close
"    unlet t:vex_buf_nr
"
"    execute(target_nr - 1) . "wincmd w"
"    call NormalizeWidths()
"endf
"
"fun! VexToggle(dir)
"    if exists("t:vex_buf_nr")
"        call VexClose()
"    else
"        call VexOpen(a:dir)
"    endif
"endf
"
"noremap <Leader><Tab> :call VexToggle(getcwd())<CR>
"noremap <Leader>` :call VexToggle("")<CR>

" Commenting blocks of code.
" autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
" autocmd FileType sh,ruby,python   let b:comment_leader = '# '
" autocmd FileType conf,fstab       let b:comment_leader = '# '
" autocmd FileType tex              let b:comment_leader = '% '
" autocmd FileType mail             let b:comment_leader = '> '
" autocmd FileType vim              let b:comment_leader = '" '
" noremap <silent> ,cc :<C-B>silent
" <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
" noremap <silent> ,cu :<C-B>silent
" <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" To Remember
" z. [z followed by a dot (.)] - to put the line with the cursor at the
" center,
" zt - to put the line with the cursor at the top
" zb - to put the line with the cursor at the bottom of the screen.
" z<retrun> - to put the line with the cursor at the top of the screen
"
"V 7.3
"set relativenumber 
"set number      

" Enable filetype plugins
filetype on
filetype plugin indent on
set nopaste
set background=dark
if &diff
    colorscheme pablo
else
    colorscheme desert
endif

syntax enable
set syntax=on
set t_ut=
" Send more characters for redraws
set ttyfast
" Set this to the name of your terminal that supports mouse codes.
" Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
set ttymouse=xterm2
set path=$PWD/**
set wildmenu
set wildmode=list:longest
" To Remember
" z. [z followed by a dot (.)] - to put the line with the cursor at the
" center,
" zt - to put the line with the cursor at the top
" zb - to put the line with the cursor at the bottom of the screen.
" z<return> - to put the line with the cursor at the top of the screen

" Set Mouse Scrolling For Normal Mode
set mouse=n
set history=1000  " Store a ton of history default
set ul=1000  " Undo levels

" Enable persistent undo
set undofile   " Maintain undo history between sessions
set undodir=~/.git/hooks/

"UI config
set number "Show line numbers
set relativenumber "Show line numbers
set laststatus=2

"set nomagic
"highlight Search ctermbg=darkmagenta ctermfg=black
highlight Search ctermbg=darkgreen ctermfg=black
"highlight IncSearch cterm=underline,bold  ctermbg=white ctermfg=black
highlight IncSearch cterm=underline,bold  ctermbg=darkgreen ctermfg=black
highlight VertSplit ctermbg=darkgreen ctermfg=black
highlight VertSplit ctermbg=black ctermfg=darkgreen
"highlight MatchParen cterm=bold ctermfg=white ctermbg=lightgrey
set foldenable
setlocal foldmethod=syntax
setlocal foldminlines=10
setlocal foldlevel=4
set backspace=2
set backspace+=indent,eol,start
set tabstop=4                   " Number of visual spaces per TAB
set softtabstop=4               " Number of spaces in tab when editing
set expandtab                   " Tabs are spaces
set shiftwidth=4
set smarttab
set wrap                        " Wrap lines
set autoindent
set infercase
set smartcase

" Set vim to save the file on focus out.
au FocusLost * :wa \| :redraw!
"Auto redraw when focus gained
au FocusGained * :redraw!

" Vim Auto complete
set complete=.,t,w,d,b,u
set completeopt=menu,longest,preview
highlight Pmenu ctermbg=darkgreen
highlight PmenuSel ctermbg=yellow
"Loop through pop completion
"inoremap <expr><tab>   pumvisible() ? \"\<c-n>" : \"\<tab>"
"inoremap <expr><s-tab> pumvisible() ? \"\<c-p>" : \"\<s-tab>"
"inoremap <expr> j pumvisible() ? \"\<c-n>" : \"j"
"inoremap <expr> k pumvisible() ? \"\<c-p>" : \"k"
" Vim Quick Fix movement
nnoremap gn :cn<CR>
nnoremap gp :cp<CR>
" Close Preview winodow that open along with omnicomplete
autocmd CompleteDone * pclose
"Moving around command line
cnoremap <c-a> <Home>
cnoremap <c-f> <S-Right>
cnoremap <c-b> <S-Left>
cnoremap <c-e> <End>
inoremap <c-a> <c-o>^
inoremap <c-a><c-a> <c-o>0
inoremap <c-e> <c-o>$
nnoremap <C-x> :b#<CR>

"My Quirky Hacks
" Tag- Use backspace to jump back
nmap <bs> <C-t>
nmap <cr> <c-]>
nmap <C-n> :cn<CR>
nmap <C-p> :cp<CR>
map <ScrollWheelUp> <c-y>
map <ScrollWheelDown> <c-e>
noremap [{ [{zz
noremap [[ [[zz
noremap ]] ]]zz
noremap %  %zz
noremap xn a<space><esc>
noremap xp i<space><esc>
noremap <space> <c-d>
noremap <s-space> <c-u>
noremap Y  y$
noremap gup :s/\<./\u&/g<CR> & :noh<CR>
noremap <C-@> i<C-@>
" Remember info about open buffers on close
set viminfo^=%
set viminfo='100,<50,s10,f1
"Command line spell corrections
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Wq ((getcmdtype() is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))
cnoreabbrev <expr> Wa ((getcmdtype() is# ':' && getcmdline() is# 'Wa')?('wa'):('Wa'))
cnoreabbrev <expr> Qa ((getcmdtype() is# ':' && getcmdline() is# 'Qa')?('qa'):('Qa'))
cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))

command VKGrep !grep --line-buffered --color=never -r "" * | fzf

function! SortBetweenBracketsAndIndent()
    let @x = 'vi{:!column -tgv='
    normal! @x
    let @x=''
endfunction
command! VKSortBrackets call SortBetweenBracketsAndIndent()

function! SortSelectedLinesAndIndent()
    let @x ='gv:!column -tgv='
    normal! @x
    let @x=''
endfunction
command! VKSortLines call SortSelectedLinesAndIndent()

function! CHeaderDefines()
    let @x='G"%p0i#ifndef wgUWi_f.s_A_yypldwidefine yypldwiendif // '
    normal! @x
    let @x=''
endfunction
command! VKCHeader call CHeaderDefines()

function! GatherFunctionDefinitions()
    let @z=''
    let @x=''
    wincmd h
    normal! gg
    let @x =']]j"Zy((]]2j@x'
    normal! @x
    wincmd l
    normal! "zpGo
    let @x ='ddkA;'
    normal! [[
    while line(".") > 1
        normal! @x
        normal! [[
    endwhile
    let @z=''
    let @x=''
endfunction
command! VKFuncDef call GatherFunctionDefinitions()

command! VKWipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

function! ConvertEnum2Switch()
    let @x ='gv:!column -tgv='
    normal! @x
    let @x=''
endfunction
command! VKEnum2Switch call ConvertEnum2Switch()

function! ConvertHashDefine2Switch()
    let @x=''
    let @y=''
    let @y ='02dwicase ýaea: break;Dýa' 
    let @x ='gv:g/define/norm!@ygv='
    normal! @x
    let @x=''
    let @y=''
endfunction
command! VKHashDefine2Switch call ConvertHashDefine2Switch()

"Function Key's Toggling!
"--------------------------------------------------------------------------
"set 2 window scroll
map <F1> :set scb!<CR>
map <F2> :GitGutterLineHighlightsToggle<CR>
map <F3> :buffers<CR>:buffer<Space>
nmap <F10> :!source ./.git/hooks/ide<CR>:silent cscope add ./.git/hooks/cscope.out<CR><CR>:silent cscope reset<CR><CR>
autocmd BufWritePost c,cpp :!source ./.git/hooks/ide<CR>:silent cscope add ./.git/hooks/cscope.out<CR><CR>:silent cscope reset<CR><CR>

"Leader Key Bindings
let mapleader = ";"
let maplocalleader = "\\"

" Disable highlight when <leader><cr> is pressed
noremap<silent> <leader><cr> :noh<cr>
noremap<silent> <leader><Esc> :ccl<cr>

noremap gj <C-W>j
noremap gk <C-W>k
noremap gh <C-W>h
noremap gl <C-W>l
set splitright
set splitbelow

" Seleting Window's
noremap 1` 1<C-W>w
noremap 2` 2<C-W>w
noremap 3` 3<C-W>w
noremap 4` 4<C-W>w
noremap 5` 5<C-W>w
noremap 6` 6<C-W>w
noremap 7` 7<C-W>w
noremap 8` 8<C-W>w
noremap 9` 9<C-W>w

" Window resizing mappings
nnoremap <C-k>  <C-w>+
nnoremap <C-j>  <C-w>-
nnoremap <C-h>  <C-w><
nnoremap <C-l> <C-w>>

" Search and Replace like a boss
nnoremap // /\v
command -nargs=1 S2 :2match search /<args>/
command -nargs=1 S3 :3match search /<args>/
command -nargs=1 IS2 :match incsearch /<args>/
nnoremap gr :%s///gc<Left><Left><Left><Left>
nnoremap grw :%s/<C-r><C-w>//gc<Left><Left><Left>
nnoremap griw :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>

nnoremap zf :call FoldColumnToggle()<cr>

function! FoldColumnToggle()
    if &foldlevel
    	setlocal foldmethod=syntax
        setlocal foldminlines=0
        setlocal foldlevel=0
    else
    	setlocal foldmethod=syntax
        setlocal foldminlines=10
        setlocal foldlevel=4
    endif
endfunction

" Command line spell corrections
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Wq ((getcmdtype() is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))
cnoreabbrev <expr> Wa ((getcmdtype() is# ':' && getcmdline() is# 'Wa')?('wa'):('Wa'))
cnoreabbrev <expr> Qa ((getcmdtype() is# ':' && getcmdline() is# 'Qa')?('qa'):('Qa'))
cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))

" Managing tabs
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
noremap<leader>te :tabedit <c-r>=expand("%:p:h")<CR>/

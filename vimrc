"#########################################################################
"#                        SETTINGS                                       #
"#########################################################################
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"set runtimepath=$VIM,$VIMRUNTIME
execute pathogen#infect()
" Enable filetype plugins
filetype plugin on
filetype indent on 

colorscheme desert

"C Syntax
set syntax=on
syntax enable
set tabstop=4                   " Number of visual spaces per TAB
set softtabstop=4               " Number of spaces in tab when editing
set expandtab                   " Tabs are spaces
set shiftwidth=4
set smarttab
set wrap                        " Wrap lines
set scrolloff=25                "Make search results appear in the middle of the screen
set autoindent
set cindent

" This will kill me !!!
"noremap <Up> <nop>
"noremap <Down> <nop>
"noremap <Left> <nop>
"noremap <Right> <nop>

" To Remember
" z. [z followed by a dot (.)] - to put the line with the cursor at the
" center,
" zt - to put the line with the cursor at the top
" zb - to put the line with the cursor at the bottom of the screen.
" z<retrun> - to put the line with the cursor at the top of the screen

" Send more characters for redraws
set ttyfast
" Set this to the name of your terminal that supports mouse codes.
" Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
set ttymouse=xterm2

" Set mouse scrolling for normal mode
set mouse=n
set cst
set csto=0
set history=1000                " Store a ton of history (default
set ul=1000                     " Undo levels

set backspace=2 
set backspace=indent,eol,start


"UI config
set number "Show line numbers
set relativenumber "Show line numbers
set hlsearch
set colorcolumn=81 
highlight ColorColumn ctermbg=3
set cursorline
hi CursorLine ctermbg=red ctermfg=black guibg=red guifg=black
hi CursorLine cterm=none
hi CursorLine gui=none

"Quick Hacks
nnoremap oj o<esc>
nnoremap ok O<esc>
nnoremap xn a<space><esc>
nnoremap xp i<space><esc>
nnoremap Y  y$
nnoremap dtw dt_
nnoremap dfw df_
nnoremap ctw ct_
nnoremap cfw cf_
nnoremap ytw yt_
nnoremap yfw yf_
"inoremap CC <Esc>C
"inoremap SS <Esc>S
"inoremap DD <Esc>dd
"inoremap UU <Esc>u
"inoremap II <Esc>I
"inoremap AA <Esc>A

imap <C-b>) <Esc>yssbi
imap <C-b>" <Esc>yss"i
imap <C-b>] <Esc>yss]i
imap <C-b>' <Esc>yss'i
imap <C-b>} <Esc>yss}i
imap <C-b>> <Esc>yss>i
            
"imap <C-v>) <Esc>csbi
"imap <C-v>" <Esc>cs"i
"imap <C-v>] <Esc>cs]i
"imap <C-v>' <Esc>cs'i
"imap <C-v>} <Esc>cs}i
"imap <C-v>> <Esc>cs>i

imap <C-x>) <Esc>dsbi
imap <C-x>" <Esc>ds"i
imap <C-x>] <Esc>ds]i
imap <C-x>' <Esc>ds'i
imap <C-x>} <Esc>ds}i
imap <C-x>> <Esc>ds>i
" Copy the word under the cursor into command line
"cmap <Leader>g <C-r><C-w>
nmap <Leader>g :<C-r><C-w>
" Moving around command line
cnoremap <C-A> <Home>
cnoremap <C-F> <S-Right>
cnoremap <C-B> <S-Left>

"" Fast quiting 
"inoremap <C-q> <Esc>:q<CR>
"nnoremap <C-q> <Esc>:q<CR>
"" Fast saving
"inoremap <C-s> <Esc>:w<CR>
"nnoremap <C-s> <Esc>:w<CR>
"" Fast saving & quitting
"inoremap <C-x> <Esc>:wq<CR>
"nnoremap <C-x> <Esc>:wq<CR>
"" Fast quiting all
"inoremap <C-Q> <Esc>:qa<CR>
"nnoremap <C-Q> <Esc>:qa<CR>
"" Fast saving all
"inoremap <C-S> <Esc>:wa<CR>
"nnoremap <C-S> <Esc>:wa<CR>
"" Fast saving & quitting all
"inoremap <C-X> <Esc>:wqa<CR>
"nnoremap <C-X> <Esc>:wqa<CR>

" short cut
noremap 1` 1<C-W>w 
noremap 2` 2<C-W>w 
noremap 3` 3<C-W>w 
noremap 4` 4<C-W>w 
noremap 5` 5<C-W>w 
noremap 6` 6<C-W>w 

" Join subsequent lines.
nnoremap <C-i> J 

"#########################################################################
"#                        LEADER KEY BINDINGS                            #
"#########################################################################

" My  Mappings for managing tabs
let mapleader = ","
let maplocalleader = "\\"
" Disable highlight when <leader><cr> is pressed
noremap<silent> <leader><cr> :noh<cr>
set splitright
set splitbelow
"Close every window in the current tabview but the current one
noremap <leader>cw <C-W>o

"set path=.,,**
noremap<leader>tn :tabnew<cr>
noremap<leader>to :tabonly<cr>
noremap<leader>tc :tabclose<cr>
noremap<leader>tm :tabmove
noremap<leader>tf :tabfind
noremap<leader>tls :tabs<cr>
noremap<leader>tsp :tab split<cr>
noremap<leader>m gT
noremap<leader>. gt
noremap<leader>n <C-W><S-t>

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


"Set manual page display
noremap<leader>man K

"""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""
function! s:config_fuzzyall(...) abort
      return extend(copy({
        \   'converters': [
        \     incsearch#config#fuzzy#converter(),
        \     incsearch#config#fuzzyspell#converter()
        \   ],
        \ }), get(a:, 1, {}))
  endfunction

  noremap <silent><expr> z/ incsearch#go(<SID>config_fuzzyall())
  noremap <silent><expr> z? incsearch#go(<SID>config_fuzzyall({'command': '?'}))
  noremap <silent><expr> zg? incsearch#go(<SID>config_fuzzyall({'is_stay': 1}))
"""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key
" binding.
" `s{char}{label}`
nmap <space> <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap <space> <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <space>j <Plug>(easymotion-j)
map <space>k <Plug>(easymotion-k)

"<Leader><space>f{char} to move to {char}
map  <space>f <Plug>(easymotion-bd-f)
nmap <space>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap <space>s <Plug>(easymotion-overwin-f2)

" Move to line
map <space>l <Plug>(easymotion-bd-jk)
nmap <space>l <Plug>(easymotion-overwin-line)

" Move to word
map  <space>w <Plug>(easymotion-bd-w)
nmap <space>w <Plug>(easymotion-overwin-w)

" You can use other keymappings like <C-l> instead of <CR> if you want to
" use these mappings as default search and somtimes want to move cursor with
" EasyMotion.
"function! s:incsearch_config(...) abort
"  return incsearch#util#deepextend(deepcopy({
"  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
"  \   'keymap': {
"  \     "\<CR>": '<Over>(easymotion)'
"  \   },
"  \   'is_expr': 0
"  \ }), get(a:, 1, {}))
"endfunction
"
"noremap <silent><expr> <space>/  incsearch#go(<SID>incsearch_config())
"noremap <silent><expr> <space>?  incsearch#go(<SID>incsearch_config({'command': '?'}))
"noremap <silent><expr> <space>g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))

" Gif config
nmap <space>s <Plug>(easymotion-s2)
nmap <space>t <Plug>(easymotion-t2)
" Gif config
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
"Gif config
map <space>l <Plug>(easymotion-lineforward)
map <space>j <Plug>(easymotion-j)
map <space>k <Plug>(easymotion-k)
map <space>h <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to
"EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

function! s:config_easyfuzzymotion(...) abort
      return extend(copy({
        \   'converters': [incsearch#config#fuzzyword#converter()],
        \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
        \   'keymap': {"\<CR>": '<Over>(easymotion)'},
        \   'is_expr': 0,
        \   'is_stay': 1
        \ }), get(a:, 1, {}))
  endfunction

noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())

""""""""""""""""""""""""""""""""""""""""""""
" Smart way to move between windows
"
noremap <leader>j <C-W>j
noremap <leader>k <C-W>k
noremap <leader>h <C-W>h
noremap <leader>l <C-W>l

nnoremap <leader>b :exec &nu==&rnu? "se nu!" : "se rnu!"<CR>
"nnoremap <leader>d :setlocal number!<cr>

" Maps Alt-[h,j,k,l] to resizing a window split
nnoremap <S-h> <C-w><
nnoremap <S-l> <C-w>>
nnoremap <S-k> <C-W>-
nnoremap <S-j> <C-W>+
nnoremap <leader>x <C-W>x

"if has("cscope") 

" use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

" check cscope for definition of a symbol before
    set csto=0

    copen 
    set cscopequickfix=s-,c-,d-,i-,t-,e-,f-

    if filereadable("cscope.out")
        cs add cscope.out  
    endif
    
    " My mappings for managing tabs
    "0 or s: Find this C symbol
    "1 or g: Find this definition
    "2 or d: Find functions called by this function
    "3 or c: Find functions calling this function
    "4 or t: Find this text string
    "6 or e: Find this egrep pattern
    "7 or f: Find this file
    "8 or i: Find files #including this file

    noremap<leader>s "zyiw:exe "tab cs find 0 ".@z.""<CR>
    noremap<leader>g "zyiw:exe "tab cs find 1 ".@z.""<CR>
    noremap<leader>d "zyiw:exe "tab cs find 2 ".@z.""<CR>
    noremap<leader>c "zyiw:exe "tab cs find 3 ".@z.""<CR>
    noremap<leader>t "zyiw:exe "tab cs find 4 ".@z.""<CR>
    noremap<leader>e "zyiw:exe "tab cs find 6 ".@z.""<CR>
    noremap<leader>f "zyiw:exe "tab cs find 7 ".@z.""<CR>
    noremap<leader>i "zyiw:exe "tab cs find 8 ".@z.""<CR>

    noremap<localleader>s "zyiw:exe "tab cs find 0 ".@z.""<CR>
    noremap<localleader>g "zyiw:exe "tab cs find 1 ".@z.""<CR>
    noremap<localleader>d "zyiw:exe "tab cs find 2 ".@z.""<CR>
    noremap<localleader>c "zyiw:exe "tab cs find 3 ".@z.""<CR>
    noremap<localleader>t "zyiw:exe "tab cs find 4 ".@z.""<CR>
    noremap<localleader>e "zyiw:exe "tab cs find 6 ".@z.""<CR>
    noremap<localleader>f "zyiw:exe "tab cs find 7 ".@z.""<CR>
    noremap<localleader>i "zyiw:exe "tab cs find 8 ".@z.""<CR>
    " Using ',hcX' searches current word and makes the vim
    " window split horizontally, with search result displayed
    " in the new window.
    noremap<leader>hs "zyiw:exe "scs find 0 ".@z.""<CR>
    noremap<leader>hg "zyiw:exe "scs find 1 ".@z.""<CR>
    noremap<leader>hd "zyiw:exe "scs find 2 ".@z.""<CR>
    noremap<leader>hc "zyiw:exe "scs find 3 ".@z.""<CR>
    noremap<leader>ht "zyiw:exe "scs find 4 ".@z.""<CR>
    noremap<leader>he "zyiw:exe "scs find 6 ".@z.""<CR>
    noremap<leader>hf "zyiw:exe "scs find 7 ".@z.""<CR>
    noremap<leader>hi "zyiw:exe "scs find 8 ".@z.""<CR>

    " Hitting ',vcsX' searches current word and does a vertical
    " split instead of a horizontal one
    noremap<leader>vs "zyiw:exe "vert scs find 0 ".@z.""<CR>
    noremap<leader>vg "zyiw:exe "vert scs find 1 ".@z.""<CR>
    noremap<leader>vd "zyiw:exe "vert scs find 2 ".@z.""<CR>
    noremap<leader>vc "zyiw:exe "vert scs find 3 ".@z.""<CR>
    noremap<leader>vt "zyiw:exe "vert scs find 4 ".@z.""<CR>
    noremap<leader>ve "zyiw:exe "vert scs find 6 ".@z.""<CR>
    noremap<leader>vf "zyiw:exe "vert scs find 7 ".@z.""<CR>
    noremap<leader>vi "zyiw:exe "vert scs find 8 ".@z.""<CR>

    "Cscope shortcuts
    " f: Find this file
    " g: Find this definition
    " c: Find functions calling this function
    " s: Find this C symbol
    " t: Find assignments to
    " d: Find functions called by this function 
    command -nargs=+ Cf cs find f <args>
    command -nargs=+ Cg cs find g <args>
    command -nargs=+ Cc cs find c <args>
    command -nargs=+ Cs cs find s <args>
    command -nargs=+ Ct cs find t <args>
    command -nargs=+ Cd cs find d <args>
    command -nargs=+ Ci cs find i <args>
    command -nargs=+ Ce cs find e <args>
"endif   

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

noremap<leader>cf "ky/{/e<CR>"Kya{
noremap<leader>pf "kp

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
set viminfo='20,<50,s10

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

autocmd FileType c nnoremap <buffer> <localleader>\ I//<esc>
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

colorscheme desert

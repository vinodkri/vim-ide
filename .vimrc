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

" Put your non-Plugin stuff after this line
set runtimepath=$VIM,$VIMRUNTIME
set nocompatible
    "######### Vundle Plugins #########
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'
    "Plugin 'bundle/YouCompleteMe'
    Plugin 'bundle/vim-surround'
    Plugin 'tpope/vim-repeat'
    Plugin 'honza/vim-snippets'
    "Plugin 'sirver/ultisnips'
    Plugin 'raimondi/delimitmate'
    Plugin 'keith/swift.vim'

    Plugin 'bundle/incsearch-easymotion.vim'
    Plugin 'bundle/incsearch-fuzzy.vim'
    Plugin 'bundle/incsearch.vim'
    Plugin 'bundle/supertab'
    Plugin 'bundle/vim-commentary'
    Plugin 'bundle/vim-easymotion'
    Plugin 'bundle/ctrlp.vim'
    Plugin 'pbogut/fzf-mru.vim'
    Plugin 'scrooloose/syntastic'

    Plugin 'bundle/vim-airline'
    Plugin 'bundle/vim-airline-themes'
    Plugin 'bundle/vim-colors-solarized'
    Plugin 'yggdroot/indentline'

    Plugin 'vimwiki/vimwiki'
    Plugin 'tibabit/vim-todo'

    "Session Management
    "Plugin 'manasthakur/vimsessionist'
    "Plugin 'tpope/vim-obsession'
    Plugin 'xolox/vim-misc'
    Plugin 'xolox/vim-session'

    "Git Latest Changes
    Plugin 'airblade/vim-gitgutter'

    "vim Maps
    Plugin 'robcsi/viewmaps.vim'

    "vim Rainbow Paranthesis
    Plugin 'kien/rainbow_parentheses.vim'
    call vundle#end()

"Airline specific settings
let g:airline_theme='wombat'

"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"========= Support for vim-repeate ============"
"silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
"============================================="

"Rainbow Paranthesis
    "===========================================================================
    let g:rbpt_colorpairs = [
        \ ['brown',       'RoyalBlue3'],
        \ ['Darkblue',    'SeaGreen3'],
        \ ['darkgray',    'DarkOrchid3'],
        \ ['darkgreen',   'firebrick3'],
        \ ['darkcyan',    'RoyalBlue3'],
        \ ['darkred',     'SeaGreen3'],
        \ ['darkmagenta', 'DarkOrchid3'],
        \ ['brown',       'firebrick3'],
        \ ['gray',        'RoyalBlue3'],
        \ ['black',       'SeaGreen3'],
        \ ['darkmagenta', 'DarkOrchid3'],
        \ ['Darkblue',    'firebrick3'],
        \ ['darkgreen',   'RoyalBlue3'],
        \ ['darkcyan',    'SeaGreen3'],
        \ ['darkred',     'DarkOrchid3'],
        \ ['red',         'firebrick3'],
        \ ]

    let g:rbpt_max = 16
    let g:rbpt_loadcmd_toggle = 0
    au VimEnter * RainbowParenthesesToggle
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces

"Vim Sessions Settings
    "===========================================================================
    " If you don't want help windows to be restored:
    set sessionoptions-=help
    let g:session_autosave_periodic=1
    let g:session_autosave=1

" Enable filetype plugins
filetype on
filetype plugin on
filetype indent on 
filetype plugin indent on

if &diff
    set background=light
else
    set background=dark
endif

colorscheme solarized

"C Syntax
syntax enable
set syntax=on

set t_ut=
" Send more characters for redraws
set ttyfast
" Set this to the name of your terminal that supports mouse codes.
" Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
set ttymouse=xterm2

set tabstop=4                   " Number of visual spaces per TAB
set softtabstop=4               " Number of spaces in tab when editing
set expandtab                   " Tabs are spaces
set shiftwidth=4
set smarttab
set wrap                        " Wrap lines
set scrolloff=25                "Make search results appear in the middle of the screen
set autoindent
set cindent
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
set cst
set csto=0
set history=1000                " Store a ton of history default
set ul=1000                     " Undo levels

set backspace=2 
set backspace=indent,eol,start


"UI config
set number "Show line numbers
set relativenumber "Show line numbers
set hlsearch
set laststatus=2
"set colorcolumn=81 
highlight ColorColumn ctermbg=3
set cursorline
hi CursorLine ctermbg=red ctermfg=black guibg=red guifg=black
hi CursorLine cterm=none
hi CursorLine gui=none

set foldenable
" autocmd FileType c setlocal foldmethod=syntax
" autocmd FileType c setlocal foldlevel=3
" autocmd FileType c copen 

autocmd FileType c call SetCFiletypeSettings()
autocmd BufRead *.h  set filetype=c
autocmd FileType h call SetCFiletypeSettings()
function SetCFiletypeSettings()
    setlocal foldmethod=syntax
    setlocal foldlevel=4
    noremap <space> zO
    :cw \| <esc><c-w>k
endfunction
autocmd FileType * setlocal foldmethod=manual
autocmd BufRead *.vimrc  setlocal  foldmethod=indent

"My Quirky Hacks
"===============================================================
    noremap oj o<esc>
    noremap ok O<esc>
    noremap xn a<space><esc>
    noremap xp i<space><esc>
    noremap Y  y$
    noremap dtw dt_
    noremap dfw df_
    noremap ctw ct_
    noremap cfw cf_
    noremap ytw yt_
    noremap yfw yf_
    noremap up :s/\<./\u&/g<CR> & :noh<cr>

"My shortcuts for YouSurroundMe
"===============================================================
    imap <C-k>) <Esc>yssbi
    imap <C-k>" <Esc>yss"i
    imap <C-k>] <Esc>yss]i
    imap <C-k>' <Esc>yss'i
    imap <C-k>} <Esc>yss}i
    imap <C-k>> <Esc>yss>i

    imap <C-x>) <Esc>dsbi
    imap <C-x>" <Esc>ds"i
    imap <C-x>] <Esc>ds]i
    imap <C-x>' <Esc>ds'i
    imap <C-x>} <Esc>ds}i
    imap <C-x>> <Esc>ds>i


" Copy the word under the cursor into command line
"cmap <leader>g <C-r><C-w>
nmap <leader>c :<C-r><C-w>

"Moving around command line
cnoremap <C-A> <Home>
cnoremap <C-F> <S-Right>
cnoremap <C-B> <S-Left>

noremap <C-n> :cn<CR>
noremap <C-b> :cp<CR>

" short cut
noremap 1` 1<C-W>w 
noremap 2` 2<C-W>w 
noremap 3` 3<C-W>w 
noremap 4` 4<C-W>w 
noremap 5` 5<C-W>w 
noremap 6` 6<C-W>w 

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

"Save & Quit All
nmap <leader>wq :cclose \| :wqa<CR> 
"Save all
nmap <leader>wa :wa<CR> 
"Quit all
nmap <leader>q :cclose \| :qa<CR> 

" Join subsequent lines.
noremap <leader>J J
noremap<leader>tn :tabnew \| :copen<cr> \| <esc><c-w>k
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

    let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key
" binding.
" `s{char}{label}`
map <space>s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap <space>s <Plug>(easymotion-overwin-f2)
" s{char}{char} to move to {char}{char}
"nmap <space>s <Plug>(easymotion-overwin-f2)


" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <space>j <Plug>(easymotion-j)
map <space>k <Plug>(easymotion-k)

map  <space>f <Plug>(easymotion-bd-f)
nmap <space>f <Plug>(easymotion-overwin-f)

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
"map  n <Plug>(easymotion-next)
"map  N <Plug>(easymotion-prev)

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

" Maps Alt-[h,j,k,l] to resizing a window split
nnoremap <S-h> <C-w><
nnoremap <S-l> <C-w>>
nnoremap <S-k> <C-W>-
nnoremap <S-j> <C-W>+
nnoremap <leader>x <C-W>x

"Cscope Settings
    "-----------------------------------------------------------
    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    set csto=0
    if &diff
    else
        set cscopequickfix=s-,c-,d-,i-,t-,e-,f-
    endif
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

"Function Key's Toggling!
    "--------------------------------------------------------------------------
    nnoremap <F6> :call QuickfixToggle()<cr>
    call togglebg#map("<F2>")
    map <F5> :!cscope -Rb <CR> & :ctags -R<CR> & :cs reset<CR><CR> 
    map <F4> :set scb!<CR> 
    map <F3> :GitGutterLineHighlightsToggle<CR>

let g:quickfix_is_open = 0

function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
    else
        " copen
        let g:quickfix_is_open = 1
    endif
endfunction

function! s:ExecuteInShell(command)
    let command = join(map(split(a:command), 'expand(v:val)'))
    let winnr = bufwinnr('^' . "__Scratch__" . '$')
    "let winnr = bufwinnr('^' . command . '$')
    silent! execute  winnr < 0 ? 'botright new ' . fnameescape("__Scratch__") : winnr . 'wincmd w'
    "silent! execute  winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
    echo 'Execute ' . command . '...'
    silent! execute 'silent %!'. command
    silent! execute 'resize ' . line('$')
    "silent! redraw
    silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
    silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
    echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)

"Funtion to close quickfix window if only one buffer exists.
aug QFClose
      au!
        au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

"NerdTree
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
"" noremap <F2>> :call VexToggle(getcwd())<CR>
"noremap <F2> :call VexToggle("")<CR>



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
set rtp+=~/vim-wow-moments
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
"FZF
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
"Incremental search
Plugin 'haya14busa/incsearch.vim'
"Git help
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-repeat'
Plugin 'airblade/vim-gitgutter'
"Indent guide lines.
Plugin 'nathanaelkane/vim-indent-guides'
"Snippets manager
Plugin 'honza/vim-snippets'
"Snippet engine
Plugin 'sirver/ultisnips'
"Highlighting C/C++ Functions
Plugin 'octol/vim-cpp-enhanced-highlight'
"Highlight typedef, enums etc
Plugin 'TagHighlight'
"Tab Renaming
"Plugin 'gcmt/taboo.vim'
"Tame QuickFix
Plugin 'romainl/vim-qf'
"Tame code comments
Plugin 'scrooloose/nerdcommenter'
"Auto insert closing parentheses
Plugin 'raimondi/delimitmate'
"Enable yanking and pasting text between vim buffers across panes/windows
Plugin 'gsiano/vmux-clipboard'

"Restore FocusGained and FocusLost events
Plugin 'tmux-plugins/vim-tmux-focus-events'

"Theme
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'edkolev/tmuxline.vim'

" ACK -- fast grep
Plugin 'mileszs/ack.vim'

"Plugin 'christoomey/vim-tmux-runner'
Plugin 'vinodkri/vim-tmux-runner'

Plugin 'Valloric/YouCompleteMe'

"Plugin 'fatih/vim-go'
"Plugin 'rust-lang/rust'

Plugin 'majutsushi/tagbar'
call vundle#end()
"}}}1

set encoding=utf-8

" Plugin Specific Configurations {{{1
    " FZF Plugin --- {{{2
        :source ~/.vim/fzf_setting_and_mappings.vim
    "}}}2
	"Incsearch Plugin --- {{{2
        :source ~/.vim/incsearch.vim
    "}}}2
	" YouCompleteMe Plugin --- {{{2
        :source ~/.vim/YouCompleteMe.vim
    ""}}}2
	" UltiSnips Plugin --- {{{2
        :source ~/.vim/UltiSnips.vim
	"}}}2
    "{{{2 NerdCommentery
        :source ~/.vim/NerdCommentery.vim
    "}}}2
    "{{{2 Rusty
        let g:rustfmt_autosave = 1
    "}}}2
    "Airline Settings {{{2
        :source ~/.vim/Airline.vim
    "}}}2
    "GitGutter Mappings {{{2
        :source ~/.vim/GitGutter.vim
    "}}}2
    "VTR {{{2
        let g:VtrUseVtrMaps = 1
    "}}}2
    "AutoTagBar {{{2
        nmap <F4> :TagbarToggle<CR>
    "}}}2
    "Indentation Guide Lines {{{2
        :source ~/.vim/IndentGuides.vim
    "}}}
    "vim-cpp-enhanced-highlight {{{2
        :source ~/.vim/vim-cpp-enhanced-highlight.vim
    ""}}}2
"}}}1

" Default settings for vim {{{1
    " Enable filetype plugins
    filetype on
    filetype plugin indent on
    set nopaste
    set background=dark
    if &diff
        colorscheme zellner 
    else
        colorscheme desert
    endif

    syntax enable
    set syntax=on

    set t_ut=
    " Send more characters for redraws
    set ttyfast
    "set lazyredraw

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
    "set undofile   " Maintain undo history between sessions
    "set undodir=~/.vim/undodir

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
    "set scrolloff=25                "Make search results appear in the middle of the screen
    set autoindent
    "set cindent
    "set smartindent
    set infercase
    set smartcase

    " Set vim to save the file on focus out.
    au FocusLost * :wa \| :redraw!
    "Auto redraw when focus gained
    au FocusGained * :redraw!

    " Vim Auto complete
    set complete=.,t,w,d,b,u
    "set complete-=i
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
    nnoremap * g*
    nnoremap # g#
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

    "My Quirky Hacks
    " Tag- Use backspace to jump back {{{2
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
        let @y ='02dwicase €ýaea: break;D€ýa' 
        let @x ='gv:g/define/norm!@ygv='
        normal! @x
        let @x=''
        let @y=''
    endfunction
    command! VKHashDefine2Switch call ConvertHashDefine2Switch()

    "Function Key's Toggling! {{{2
    "--------------------------------------------------------------------------
    "nnoremap <F6> :call QuickfixToggle()<cr>
    "set 2 window scroll
    map <F1> :set scb!<CR>
    map <F2> :GitGutterLineHighlightsToggle<CR>
    map <F3> :buffers<CR>:buffer<Space>
    nmap <F10> :!source ./.git/hooks/ide<CR>:silent cscope add ./.git/hooks/cscope.out<CR><CR>:silent cscope reset<CR><CR>
    autocmd BufWritePost c,cpp :!source ./.git/hooks/ide<CR>:silent cscope add ./.git/hooks/cscope.out<CR><CR>:silent cscope reset<CR><CR>
    "}}}2
"}}}1

"Leader Key Bindings {{{1
    let mapleader = ";"
    let maplocalleader = "\\"

    " Disable highlight when <leader><cr> is pressed
    noremap<silent> <leader><cr> :noh<cr>
    noremap<silent> <leader><Esc> :ccl<cr>

    " Managing windows {{{2
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
    "}}}2

    " Search and Replace like a boss {{{2
        nnoremap // /\v
        command -nargs=1 S2 :2match search /<args>/
        command -nargs=1 S3 :3match search /<args>/
        command -nargs=1 IS2 :match incsearch /<args>/
        nnoremap gr :%s///gc<Left><Left><Left><Left>
        nnoremap grw :%s/<C-r><C-w>//gc<Left><Left><Left>
        nnoremap griw :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
    "}}}2

    " Fold Toggle {{{2
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
    "}}}2
    "Cscope & Tag Settings {{{2
    "-----------------------------------------------------------
        :source ~/.vim/cscope_tag_settings.vim
    "}}}2
"}}}1

    " Command line spell corrections {{{2
    cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
    cnoreabbrev <expr> Wq ((getcmdtype() is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))
    cnoreabbrev <expr> Wa ((getcmdtype() is# ':' && getcmdline() is# 'Wa')?('wa'):('Wa'))
    cnoreabbrev <expr> Qa ((getcmdtype() is# ':' && getcmdline() is# 'Qa')?('qa'):('Qa'))
    cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))
    "}}}2

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
	    noremap<leader>te :tabedit <c-r>=expand("%:p:h")<CR>/
	"}}}2

    "VTR Functions {{{2
    :source ~/.vim/flexranVtrFunction.vim
    :source ~/.vim/adkVtrFunction.vim
    "}}}2
    
    "SurroundMe {{{2
        vmap [ :norm!Tab [Tab<CR>
    "}}}2
"}}}1

"Autocmd Configs {{{1
    "Vim File Settings{{{2
        function VimFileSettings()
            setlocal foldmethod=marker
            setlocal foldlevel=1
            setlocal foldminlines=10
            setlocal foldenable
            highlight Folded ctermbg=darkgrey ctermfg=white
        endfunction
        autocmd Filetype vim call VimFileSettings()
    "}}}2

    "Cpp File Settings{{{2
        function CppFileSettings()
             setlocal cindent 
             setlocal cino=j1,(0,ws,Ws)
             setlocal textwidth=80
             let c_space_errors=1
             let java_space_errors=1 
             let java_space_errors=1 
             let c_no_trail_space_error=1
             let c_no_tab_space_error=1
        endfunction
        autocmd Filetype cpp call CppFileSettings()
    "}}}2

    "C File Settings{{{2
        function CFileSettings()
            setlocal textwidth=80
            let c_space_errors=1
            let java_space_errors=1 
            let java_space_errors=1 
            let c_no_trail_space_error=1
            let c_no_tab_space_error=1
        endfunction
        autocmd Filetype cpp call CFileSettings()
    "}}}2

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
"}}}1

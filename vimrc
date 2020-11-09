
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
set rtp+=~/vim-ide
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
Plugin 'tpope/vim-obsession'
"Diff Directory
Plugin 'will133/vim-dirdiff'
"Mark git changes.
Plugin 'airblade/vim-gitgutter'
"SuperTab
Plugin 'ervandew/supertab'
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
"Plugins to help with C/C++ development env
"Plugin 'christoomey/vim-tmux-runner'
Plugin 'vinodkri/vim-tmux-runner'
Plugin 'skywind3000/asynctasks.vim'
Plugin 'skywind3000/asyncrun.vim'
"Auto complete
Plugin 'Valloric/YouCompleteMe'
"Plugin 'fatih/vim-go'
"Plugin 'rust-lang/rust'
"List tags in a bar
Plugin 'majutsushi/tagbar'

"Testing
"Plugin 'LucHermitte/lh-vim-lib'
"Plugin 'LucHermitte/lh-style'
"Plugin 'LucHermitte/lh-tags'
"Plugin 'LucHermitte/lh-dev'
"Plugin 'LucHermitte/lh-brackets'
"Plugin 'LucHermitte/searchInRuntime'
"Plugin 'LucHermitte/mu-template'
"Plugin 'tomtom/stakeholders_vim'
"Plugin 'LucHermitte/alternate-lite'
"Plugin 'LucHermitte/lh-cpp'
"Plugin 'LucHermitte/vim-refactor'

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
        :source ~/.vim/AutoTagBarSettings.vim
    "}}}2
    "Indentation Guide Lines {{{2
        :source ~/.vim/IndentGuides.vim
    "}}}
    "vim-cpp-enhanced-highlight {{{2
        :source ~/.vim/vim-cpp-enhanced-highlight.vim
    ""}}}2
    let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
    let g:SuperTabDefaultCompletionType = '<C-n>'

    let g:UltiSnipsExpandTrigger = "<tab>"
    let g:UltiSnipsJumpForwardTrigger = "<tab>"
    let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
"}}}1

" Default settings for vim
:source ~/.vim/MyQuirkyKeyBindings.vim
"Cscope & Tag Settings
:source ~/.vim/cscope_tag_settings.vim
"VTR Functions
:source ~/.vim/flexranVtrFunction.vim
:source ~/.vim/adkVtrFunction.vim
"SurroundMe
vmap [ :norm!Tab [Tab<CR>
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
        autocmd BufRead,BufNewFile *.h,*.c set filetype=c
    "}}}2

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
"}}}1

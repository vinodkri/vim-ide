let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_auto_colors = 0
let g:indent_guides_indent_levels = 6
let g:indent_guides_color_change_percent = 10
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=grey
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey
nmap <silent> yig <Plug>IndentGuidesToggle


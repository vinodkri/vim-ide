let g:airline_theme='ayu_dark'
"Tmux settings
let g:airline#extensions#tmuxline#enabled = 1
let g:tmuxline_separators = {
    \ 'left' : '',
    \ 'left_alt': '|',
    \ 'right' : '',
    \ 'right_alt' : '|',
    \ 'space' : ' '}
"Vim Settings
let g:airline#extensions#default#layout = [
      \ [ 'a', 'b', 'c' ],
      \ [ 'x', 'z' ]
      \ ]
let g:airline_extensions = ['branch', 'tabline']
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#left_sep = '||'
let g:airline#extensions#tabline#left_alt_sep = '||'
let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
let g:airline#extensions#quickfix#location_text = 'Location'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#tabs_label = 'TABS'
let g:airline#extensions#tabline#buffers_label = 'BUFFERS'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#taboo#enabled = 1


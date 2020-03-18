set cst
set csto=1
set tags=./tags;,tags;,.git/hooks/tags;

if &diff
else
    set cscopequickfix=s-,c-,d-,i-,t-,e-,f-
endif

if filereadable("cscope.out")
    cs add cscope.out
endif

" Autoloading Cscope Database
function! LoadCscope()
    let db = findfile("cscope.out", ".git/hooks/;")
    if (!empty(db))
        let path = strpart(db, 0, match(db, "/cscope.out$"))
        set nocscopeverbose " suppress duplicate connection error
        exe "cs add " . db . " " . path
        set cscopeverbose
        set autowrite
    endif
endfunction

call LoadCscope()

if filereadable(".git/hooks/my_proj.vim") 
    source .git/hooks/my_proj.vim 
endif 

" use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
function! FZFCscope(option, query)
  let color = '{ x = $1; $1 = ""; z = $3; $3 = ""; printf "\033[34m%s\033[0m:\033[31m%s\033[0m\011\033[37m%s\033[0m\n", x,z,$0; }'
  let opts = {
  \ 'source':  "cscope -dL" . a:option . " " . a:query . " | awk '" . color . "'",
  \ 'options': ['--ansi', '--prompt', '> ',
  \             '--multi', '--bind', 'alt-a:select-all,alt-d:deselect-all',
  \             '--color', 'fg:188,fg+:222,bg+:#3a3a3a,hl+:104'],
  \ 'down': '40%'
  \ }
  function! opts.sink(lines) 
    let data = split(a:lines)
    let file = split(data[0], ":")
    execute 'e ' . '+' . file[1] . ' ' . file[0]
  endfunction
  call fzf#run(opts)
endfunction

function! CscopeQuery(option)
  call inputsave()
  if a:option == '0'
    let query = input('C Symbol: ')
  elseif a:option == '1'
    let query = input('Definition: ')
  elseif a:option == '2'
    let query = input('Functions called by: ')
  elseif a:option == '3'
    let query = input('Functions calling: ')
  elseif a:option == '4'
    let query = input('Text: ')
  elseif a:option == '6'
    let query = input('Egrep: ')
  elseif a:option == '7'
    let query = input('File: ')
  elseif a:option == '8'
    let query = input('Files #including: ')
  elseif a:option == '9'
    let query = input('Assignments to: ')
  else
    echo "Invalid option!"
    return
  endif
  call inputrestore()
  if query != ""
    call FZFCscope(a:option, query)
  else
    echom "Cancelled Search!"
  endif
endfunction

"nnoremap <silent> <leader>ca :call FZFCscope('0', expand('<cword>'))<CR>
"nnoremap <silent> <Leader><Leader>ca :call CscopeQuery('0')<CR>

" My mappings for managing tabs
" 0 or s: Find this C symbol
" 1 or g: Find this definition
" 2 or d: Find functions called by this function
" 3 or c: Find functions calling this function
" 4 or t: Find this text string
" 6 or e: Find this egrep pattern
" 7 or f: Find this file
" 8 or i: Find files #including this file
" 9 or a: Find places where this symbol is assigned a value

" Hitting '\s' symbol searches current word 
"noremap<localleader>s "zyiw:exe "tab cs find 0 ".@z.""<CR>
"noremap<localleader>g "zyiw:exe "tab cs find 1 ".@z.""<CR>
"noremap<localleader>d "zyiw:exe "tab cs find 2 ".@z.""<CR>
"noremap<localleader>c "zyiw:exe "tab cs find 3 ".@z.""<CR>
"noremap<localleader>t "zyiw:exe "tab cs find 4 ".@z.""<CR>
"noremap<localleader>e "zyiw:exe "tab cs find 6 ".@z.""<CR>
"noremap<localleader>f "zyiw:exe "tab cs find 7 ".@z.""<CR>
"noremap<localleader>i "zyiw:exe "tab cs find 8 ".@z.""<CR>

noremap<localleader>s "zyiw:exe "tab cs find 0 ".@z.""<CR>
noremap<localleader>g "zyiw:exe "tab cs find 1 ".@z.""<CR>
noremap<localleader>d "zyiw:exe "tab cs find 2 ".@z.""<CR>
noremap<localleader>c "zyiw:exe "tab cs find 3 ".@z.""<CR>
noremap<localleader>t "zyiw:exe "tab cs find 4 ".@z.""<CR>
noremap<localleader>e "zyiw:exe "tab cs find 6 ".@z.""<CR>
noremap<localleader>f "zyiw:exe "tab cs find 7 ".@z.""<CR>
noremap<localleader>i "zyiw:exe "tab cs find 8 ".@z.""<CR>
noremap<localleader>a "zyiw:exe "tab cs find 9 ".@z.""<CR>

"noremap <silent> <localleader>s :call FZFCscope('0', expand('<cword>'))<CR>
"noremap <silent> <localleader>g :call FZFCscope('1', expand('<cword>'))<CR>
"noremap <silent> <localleader>d :call FZFCscope('2', expand('<cword>'))<CR>
"noremap <silent> <localleader>c :call FZFCscope('3', expand('<cword>'))<CR>
"noremap <silent> <localleader>t :call FZFCscope('4', expand('<cword>'))<CR>
"noremap <silent> <localleader>e :call FZFCscope('6', expand('<cword>'))<CR>
"noremap <silent> <localleader>f :call FZFCscope('7', expand('<cword>'))<CR>
"noremap <silent> <localleader>i :call FZFCscope('8', expand('<cword>'))<CR>
"noremap <silent> <localleader>a :call FZFCscope('9', expand('<cword>'))<CR>

" Using '\hcX' searches current word and makes the vim
" window split horizontally, with search result displayed
" in the new window.
noremap <localleader>hs "zyiw:exe "scs find s ".@z.""<CR>
noremap <localleader>hg "zyiw:exe "scs find g ".@z.""<CR>
noremap <localleader>hd "zyiw:exe "scs find d ".@z.""<CR>
noremap <localleader>hc "zyiw:exe "scs find c ".@z.""<CR>
noremap <localleader>ht "zyiw:exe "scs find t ".@z.""<CR>
noremap <localleader>he "zyiw:exe "scs find e ".@z.""<CR>
noremap <localleader>hf "zyiw:exe "scs find f ".@z.""<CR>
noremap <localleader>hi "zyiw:exe "scs find i ".@z.""<CR>
noremap <localleader>ha "zyiw:exe "scs find a ".@z.""<CR>

" Hitting '\vcsX' searches current word and does a vertical
" split instead of a horizontal one
noremap <localleader>vs "zyiw:exe "vert scs find s ".@z.""<CR>
noremap <localleader>vg "zyiw:exe "vert scs find g ".@z.""<CR>
noremap <localleader>vd "zyiw:exe "vert scs find d ".@z.""<CR>
noremap <localleader>vc "zyiw:exe "vert scs find c ".@z.""<CR>
noremap <localleader>vt "zyiw:exe "vert scs find t ".@z.""<CR>
noremap <localleader>ve "zyiw:exe "vert scs find e ".@z.""<CR>
noremap <localleader>vf "zyiw:exe "vert scs find 7 ".@z.""<CR>
noremap <localleader>vi "zyiw:exe "vert scs find i ".@z.""<CR>
noremap <localleader>va "zyiw:exe "vert scs find a ".@z.""<CR>

command -nargs=+ Cf cs find f <args>
command -nargs=+ Cg cs find g <args>
command -nargs=+ Cc cs find c <args>
command -nargs=+ Cs cs find s <args>
command -nargs=+ Ct cs find t <args>
command -nargs=+ Cd cs find d <args>
command -nargs=+ Ci cs find i <args>
command -nargs=+ Ce cs find e <args>
command -nargs=+ Ca cs find a <args>

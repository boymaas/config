" Leaders
let mapleader = ";"
let maplocalleader = ","

map <leader><leader> <c-^>

" Fast navigation to files and buffers
map <Leader>el :e %:p:h<CR>
map <Leader>lcd :lcd %:p:h<CR>

" Open project directory
command! ProjectOpenDir execute 'e ' s:find_git_root()
map <Leader>pD :ProjectOpenDir<CR>

" Quick-save
map <leader>w :w<CR>

" Quick Commenting 
vmap <Leader>' :TComment<CR>

" Quik movements between panes
map <S-Left> <C-w><Left>
map <S-Right> <C-w><Right>
map <S-Up> <C-w><Up>
map <S-Down> <C-w><Down>

" Open new file adjacent to current file
" nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>


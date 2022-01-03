" Bookmarks
let g:bookmark_save_per_working_dir = 0
let g:bookmark_auto_save = 1

let g:bookmark_no_default_key_mappings = 1

nnoremap <Leader>mm :BookmarkToggle<cr>
nnoremap <Leader>ma :BookmarkAnnotate<cr>
nnoremap <Leader>ms :BookmarkShowAll<cr>
nnoremap <Leader>mc :BookmarkClear<cr>
nnoremap <Leader>mx :BookmarkClearAll<cr>

" these will also work with a [count] prefix
" nmap <Leader>kk <Plug>BookmarkMoveUp
" nmap <Leader>jj <Plug>BookmarkMoveDown
" nmap <Leader>g <Plug>BookmarkMoveToLine

" nmap <Leader>Bj <Plug>BookmarkNext
" nmap <Leader>Bk <Plug>BookmarkPrev

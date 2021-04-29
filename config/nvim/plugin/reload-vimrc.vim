" Fast editing of nvim config
map <Leader>v :e $MYVIMRC<CR>

" Reloads vimrc after saving but keep cursor position
if !exists("*ReloadVimrc")
   fun! ReloadVimrc()
       let save_cursor = getcurpos()
       source $MYVIMRC
       call setpos(".", save_cursor)
   endfun
endif
autocmd! BufWritePost $MYVIMRC call ReloadVimrc()

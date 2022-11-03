-- Somehting after init.lua sets the showtabline=2
--
--   `verbose set showtabline`
--
-- VimEnter to the rescue
-- https://stackoverflow.com/a/6821698
vim.cmd [[
  autocmd VimEnter * verbose set showtabline=0
]]

-- Restore position of last opened file
vim.cmd [[
  autocmd BufRead * autocmd FileType <buffer> ++once
  \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
]]

-- Autoformat on save

vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]

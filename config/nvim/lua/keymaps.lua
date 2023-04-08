-- General keymaps that are not pluggin dependant
-- the file "lua/lsp/utils.lua" contains lsp-specific commands.

local Utils = require('utils')

-- local exprnnoremap = Utils.exprnnoremap
local nnoremap = Utils.nnoremap
local vnoremap = Utils.vnoremap
-- local xnoremap = Utils.xnoremap
local inoremap = Utils.inoremap
-- local tnoremap = Utils.tnoremap
-- local nmap = Utils.nmap
-- local xmap = Utils.xmap

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- LSP Mappings are defined in `plugins/navigator`
-- GitSigns are defined in `plugins/gitsigns`

-- kj to normal mode
inoremap("kj", "<Esc>")

-- Run omnifunc, mostly used for autocomplete
inoremap("<C-SPACE>", "<C-x><C-o>")

-- Save with Ctrl + S
nnoremap("<C-s>", ":w<CR>")

-- Close buffer
nnoremap("<C-c>", ":q<CR>")

-- Move around windows (shifted to the right)
nnoremap("<S-Left>", "<C-w>h")
nnoremap("<S-Down>", "<C-w>j")
nnoremap("<S-Up>", "<C-w>k")
nnoremap("<S-Right>", "<C-w>l")

-- Switch buffers (needs nvim-bufferline)
nnoremap("<TAB>", ":BufferLineCycleNext<CR>")
nnoremap("<S-TAB>", ":BufferLineCyclePrev<CR>")
nnoremap("<leader><leader>", "<c-^>")
nnoremap(";;", "<c-^>") -- old habits


-- Splits
nnoremap("<leader>ws", ":split<CR>")
nnoremap("<leader>vs", ":vsplit<CR>")

-- Populate substitution
nnoremap("<leader>s", ":s//g<Left><Left>")
nnoremap("<leader>S", ":%s//g<Left><Left>")
nnoremap("<leader><C-s>", ":%s//gc<Left><Left><Left>")

vnoremap("<leader>s", ":s//g<Left><Left>")
vnoremap("<leader><A-s>", ":%s//g<Left><Left>")
vnoremap("<leader>S", ":%s//gc<Left><Left><Left>")

-- Delete buffer
nnoremap("<A-w>", ":bd<CR>")

-- Yank to end of line
nnoremap("Y", "y$")

-- Copy to system clippboard
nnoremap("<leader>y", '"+y')
vnoremap("<leader>y", '"+y')

-- Paste from system clippboard
nnoremap("<leader><C-v>", '"+p')
vnoremap("<leader><C-v>", '"+p')

-- Clear highlight search
nnoremap("<leader>nh", ":nohlsearch<CR>")
vnoremap("<leader>nh", ":nohlsearch<CR>")

-- Fugitive
nnoremap("<leader>G", ":G<CR>")
nnoremap("<leader>gh", ":Gclog<CR>")

-- -- Show diagnostics
-- nnoremap("<leader>d", ':TroubleToggle<CR>')

-- Show line diagnostics
nnoremap("<leader>dd", '<Cmd>lua vim.diagnostic.open_float(0, {scope = "line"})<CR>')

-- Open local diagnostics in local list
nnoremap("<leader>dl", "<Cmd>lua vim.diagnostic.setloclist()<CR>")

-- Open all project diagnostics in quickfix list
nnoremap("<leader>da", "<Cmd>lua vim.diagnostic.setqflist()<CR>")

-- Telescope
nnoremap("<leader>ff", "<Cmd>Telescope find_files<CR>")
nnoremap(";f", "<Cmd>Telescope find_files<CR>") -- Old habits

nnoremap("<leader>F", "<Cmd>Telescope git_files<CR>")
nnoremap(";F", "<Cmd>Telescope git_files<CR>") -- Old habits

nnoremap("<leader>fp", "<Cmd>Telescope projects<CR>")
nnoremap(";p", "<Cmd>Telescope projects<CR>")
nnoremap("<leader>fhf", "<Cmd>Telescope find_files hidden=true<CR>")
nnoremap("<leader>fb", "<Cmd>Telescope buffers<CR>")
nnoremap(";b", "<Cmd>Telescope buffers<CR>") -- Old habits
nnoremap("<leader>fg", "<Cmd>Telescope live_grep<CR>")

-- File explorer
nnoremap("<leader>et", "<Cmd>NvimTreeToggle<CR>") -- NvimTree

-- Navigation
nnoremap("<leader>el", ":e %:p:h<cr>") -- Go into dir relative to file
nnoremap(";el", ":e %:p:h<cr>") --

-- Testing
nnoremap(";t", ":TestLast<cr>") --
nnoremap(";T", ":TestNearest<cr>") --

-- LSP Neodev configures Lua paths
-- 1. your Neovim config directory
-- 2. your Neovim runtime directory
-- 3. any plugin directory (this is an lsp root_dir that contains a /lua directory)
require 'neodev'.setup()

local lspconfig = require 'lspconfig'

lspconfig.sumneko_lua.setup({
  settings = {
  }
})

-- NOTE: for some reason neodev does not kick in
-- on startup. When :source % this file it will
-- kick in. No clue yet on "why"

-- -- rust_analuzer
-- lspconfig.rust_analyzer.setup({})

local lspconfig = require 'lspconfig'

-- lua_language_server
lspconfig.sumneko_lua.setup({
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      }
    }
  }
})

-- rust_analuzer
lspconfig.rust_analyzer.setup({})

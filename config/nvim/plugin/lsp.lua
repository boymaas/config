-- https://www.integralist.co.uk/posts/neovim/

require 'lspconfig'.rust_analyzer.setup({})

require 'mason'.setup()

require("fidget").setup()

--  Set completeopt to have a better completion experience
--  :help completeopt
--  menuone: popup even when there's only one match
--  noinsert: Do not insert text until a selection is made
--  noselect: Do not select, force user to select one from the menu

-- set completeopt=menuone,noinsert,noselect

-- " Avoid showing extra messages when using completion
-- set shortmess+=c

require 'lspconfig'

-- Allowing for diagnostic windows and all other kinds of
-- good stuff
require 'navigator'.setup({
  lsp = {
    disable_lsp = { "rust_analyzer" }
  }
})

-- TODO: figure out why this should be here
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     virtual_text = true,
--     signs = true,
--     update_in_insert = true,
--   }
-- )

local function configure_navigator(client, bufnr)
  require 'navigator.lspclient.mapping'.setup({ client = client, bufnr = bufnr }) -- setup navigator keymaps here,

  require 'navigator.dochighlight'.documentHighlight(bufnr)
  require 'navigator.codeAction'.code_action_prompt(bufnr)
  -- otherwise, you can define your own commands to call navigator functions
end

require('rust-tools').setup(
  {
    tools = { -- rust-tools options
      autoSetHints = true,
      -- hover_with_actions = true,
      inlay_hints = {
        show_parameter_hints = true,
        parameter_hints_prefix = "",
        other_hints_prefix = "",
      },
    },
    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
      on_attach = configure_navigator,
    },

    flags = {
      debounce_text_changes = 150,
    },
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        -- enable clippy on save
        checkOnSave = {
          -- TODO: 'clippy' seems to be not known. Result is no hints in buffer.
          --command = "cargo clippy  --workspace --message-format=json --all-targets --all-features"
          --command = "cargo clippy --workspace --message-format=json --all-targets"
          command = "clippy"
          --overrideCommand = ["cargo", "clippy", "--workspace", "--message-format=json", "--all-targets"]
        },
      }
    }
  }
)


--  Configure Golang LSP.
--
--  https://github.com/golang/tools/blob/master/gopls/doc/settings.md
--  https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
--  https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim
--  https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls
--  https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim
--  https://www.getman.io/posts/programming-go-in-neovim/
require 'lspconfig'.gopls.setup {
  cmd = { 'gopls' },
  settings = {
    gopls = {
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      experimentalPostfixCompletions = true,
      gofumpt = true,
      staticcheck = true,
      usePlaceholders = true,
    },
  },
  on_attach = configure_navigator,
}


--  Setup Completion
--  See https://github.com/hrsh7th/nvim-cmp#basic-configuration
local cmp = require 'cmp'
require 'cmp'.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<Down>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})

-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "L", "<cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>", { silent = true })

-- nnoremap  <silent> L <cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>
-- nnoremap <silent> <space>m  <cmd>:MinimapToggle<CR>

-- nnoremap <space>a <cmd>lua require("navigator").code_action()<cr>

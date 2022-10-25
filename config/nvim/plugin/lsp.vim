" https://www.integralist.co.uk/posts/neovim/

lua require'lspconfig'.rust_analyzer.setup({})
" lua require('nvim-lightbulb').setup({autocmd = {enabled = true}})
lua require("fidget").setup()
" lua require("trouble").setup()


lua <<EOF
require("trouble").setup {
    icons = false,
    fold_open = "v", -- icon used for open folds
    fold_closed = ">", -- icon used for closed folds
    indent_lines = true, -- add an indent guide below the fold icons
    signs = {
        -- icons / text used for a diagnostic
        error = "error",
        warning = "warn",
        hint = "hint",
        information = "info"
    },
    use_diagnostic_signs = true
  
}
EOF

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
lua <<EOF
local nvim_lsp = require'lspconfig'

local opts = {
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
        -- on_attach is a callback called when the language server attachs to the buffer
        on_attach = on_attach,
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
    },
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)


require('rust-tools').setup(opts)
EOF


" Configure Golang LSP.
"
" https://github.com/golang/tools/blob/master/gopls/doc/settings.md
" https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
" https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim
" https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls
" https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim
" https://www.getman.io/posts/programming-go-in-neovim/
"
lua <<EOF
require('lspconfig').gopls.setup{
	cmd = {'gopls'},
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
	on_attach = on_attach,
}
EOF


" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
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
EOF


" Configure LSP code navigation shortcuts
" as found in :help lsp
"

" builtin.lsp_definitions	 
nnoremap <silent> gd <cmd>lua require('telescope.builtin').lsp_definitions(require('telescope.themes').get_ivy())<cr>
nnoremap <silent> gt <cmd>lua require('telescope.builtin').lsp_type_definitions(require('telescope.themes').get_ivy())<cr>
nnoremap <silent> gi <cmd>lua require('telescope.builtin').lsp_implementations(require('telescope.themes').get_ivy())<cr>

nnoremap <silent> K         <cmd>lua vim.lsp.buf.hover()<CR>

" nnoremap <silent> <c-r>        <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gr <cmd>lua require('telescope.builtin').lsp_references(require('telescope.themes').get_ivy())<cr>
nnoremap <silent> gR <cmd>TroubleToggle lsp_references<cr>
nnoremap <silent><leader>r        <cmd>lua vim.lsp.buf.rename()<CR>
 

nnoremap <silent> <c-k>     <cmd>lua vim.lsp.buf.signature_help()<CR>


" nnoremap <silent> gc        <cmd>lua vim.lsp.buf.incoming_calls()<CR>
" nnoremap <silent> gd        <cmd>lua vim.lsp.buf.type_definition()<CR>


"" nnoremap <silent> gs        <cmd>lua vim.lsp.buf.document_symbol()<CR>
"" nnoremap <silent> gw        <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" nnoremap <silent> S          <cmd>WorkspaceSymbol<CR>
" nnoremap <silent> S S       <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

nnoremap <space>o <cmd>lua require('telescope.builtin').lsp_document_symbols(require('telescope.themes').get_ivy())<cr>
nnoremap <space>s <cmd>lua require('telescope.builtin').lsp_workspace_symbols(require('telescope.themes').get_ivy())<cr>

nnoremap gc <cmd>lua require('telescope.builtin').lsp_incoming_calls(require('telescope.themes').get_ivy())<cr>
nnoremap go <cmd>lua require('telescope.builtin').lsp_outgoing_calls(require('telescope.themes').get_ivy())<cr>


" Replaced LSP implementation with code action plugin...
"
" nnoremap <silent> ga        <cmd>lua vim.lsp.buf.code_action()<CR>
"
" nnoremap <silent> A        <cmd>CodeActionMenu<CR>
nnoremap <silent> <space>a        <cmd>lua vim.lsp.buf.code_action()<CR>

" nnoremap <silent> ]g        <cmd>lua vim.diagnostic.goto_prev()<CR>
" nnoremap <silent> [g        <cmd>lua vim.diagnostic.goto_next()<CR>
" nnoremap <silent> ]G        <cmd>lua vim.diagnostic.show()<CR>
"

nnoremap <silent> ]g        <cmd>lua require("trouble").next({skip_groups = true, jump = true});<cr>
nnoremap <silent> [g        <cmd>lua require("trouble").previous({skip_groups = true, jump = true});<cr>

" nnoremap <silent> <c-f>       <cmd>lua vim.lsp.buf.formatting()<CR>

" Replaced LSP implementation with trouble plugin...
"
" nnoremap <silent> <space>q  <cmd>lua vim.diagnostic.setloclist()<CR>
"
nnoremap <silent> <space>d  <cmd>TroubleToggle workspace_diagnostics<CR>

nnoremap <silent> <space>m  <cmd>:MinimapToggle<CR>



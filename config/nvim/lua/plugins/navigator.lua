-- Easy setup BOTH lspconfig and navigator with one liner.
-- Navigator covers around 20 most used LSP setup.

-- https://github.com/ray-x/navigator.lua#all-configure-options
-- https://github.com/ray-x/navigator.lua/blob/master/lua/navigator.lua#L14
require 'navigator'.setup({
  mason = true,
  lsp = {
    -- to play nice with rust-tools
    -- we will not run rust_analyzer setup from navigator
    disable_lsp = { "rust_analyzer" },
    ['neodev'] = { runtime_path = true },
    --
    code_action = {
      virtual_text_icon = false
    },
    code_lens_action = {
      virtual_text_icon = false
    },
    diagnostic = {
      underline = true,
      virtual_text = { spacing = 3, source = true }, -- show virtual for diagnostic message
      update_in_insert = false, -- update diagnostic message in insert mode
      severity_sort = { reverse = true },
    },
    disply_diagnostic_qf = false, -- do not show diagnostic in quickfix on save
    format_options = {
      async = false,
      timeout_ms = 5000
    }
  },

  default_mapping = false,
  -- https://github.com/ray-x/navigator.lua/blob/master/lua/navigator/lspclient/mapping.lua#L17
  keymaps =
  {
    { key = 'gr', func = require('navigator.reference').async_ref, desc = 'async_ref' },
    -- { key = '<Leader>gr', func = require('navigator.reference').reference, desc = 'reference' }, -- reference deprecated
    { mode = 'i', key = '<M-k>', func = vim.lsp.signature_help, desc = 'signature_help' },
    { key = '<c-k>', func = vim.lsp.buf.signature_help, desc = 'signature_help' },
    { key = '<Leader>o', func = require('navigator.symbols').document_symbols, desc = 'document_symbols' },
    { key = '<Leader>s', func = require('navigator.workspace').workspace_symbol_live, desc = 'workspace_symbol_live' },
    -- { key = '<c-]>', func = require('navigator.definition').definition, desc = 'definition' },
    { key = 'gd', func = require('navigator.definition').definition, desc = 'definition' },
    { key = 'gD', func = vim.lsp.buf.declaration, desc = 'declaration' },
    --
    { key = 'gp', func = require('navigator.definition').definition_preview, desc = 'definition_preview' },
    -- { key = '<Leader>gt', func = require('navigator.treesitter').buf_ts, desc = 'buf_ts' },
    -- { key = '<Leader>gT', func = require('navigator.treesitter').bufs_ts, desc = 'bufs_ts' },
    -- { key = '<Leader>ct', func = require('navigator.ctags').ctags, desc = 'ctags' },
    { key = 'K', func = vim.lsp.buf.hover, desc = 'hover' },
    { key = '<Space>a', mode = 'n', func = require('navigator.codeAction').code_action, desc = 'code_action' },
    {
      key = '<Space>a',
      mode = 'v',
      func = require('navigator.codeAction').range_code_action,
      desc = 'range_code_action',
    },
    { key = '<Space>rn', func = require('navigator.rename').rename, desc = 'rename' },
    { key = '<Leader>gi', func = vim.lsp.buf.incoming_calls, desc = 'incoming_calls' },
    { key = '<Leader>go', func = vim.lsp.buf.outgoing_calls, desc = 'outgoing_calls' },
    { key = 'gi', func = vim.lsp.buf.implementation, desc = 'implementation' },
    { key = 'gy', func = vim.lsp.buf.type_definition, desc = 'type_definition' },

    { key = 'L', func = require('navigator.diagnostics').show_diagnostics, desc = 'show_diagnostics' },
    { key = '<Leader>d', func = require('navigator.diagnostics').show_buf_diagnostics, desc = 'show_buf_diagnostics' },
    { key = '<Leader>D', func = require('navigator.diagnostics').toggle_diagnostics, desc = 'toggle_diagnostics' },

    { key = ']d', func = vim.diagnostic.goto_next, desc = 'next diagnostics' },
    { key = '[d', func = vim.diagnostic.goto_prev, desc = 'prev diagnostics' },
    { key = ']O', func = vim.diagnostic.set_loclist, desc = 'diagnostics set loclist' },
    -- { key = ']r', func = require('navigator.treesitter').goto_next_usage, desc = 'goto_next_usage' },
    -- { key = '[r', func = require('navigator.treesitter').goto_previous_usage, desc = 'goto_previous_usage' },
    -- { key = '<C-LeftMouse>', func = vim.lsp.buf.definition, desc = 'definition' },
    -- { key = 'g<LeftMouse>', func = vim.lsp.buf.implementation, desc = 'implementation' },
    { key = '<Leader>k', func = require('navigator.dochighlight').hi_symbol, desc = 'hi_symbol' },

    -- Workspace folders
    { key = '<Space>wa', func = require('navigator.workspace').add_workspace_folder, desc = 'add_workspace_folder' },
    {
      key = '<Space>wr',
      func = require('navigator.workspace').remove_workspace_folder,
      desc = 'remove_workspace_folder',
    },
    { key = '<Space>wl', func = require('navigator.workspace').list_workspace_folders, desc = 'list_workspace_folders' },


    -- { key = '<Space>ff', func = vim.lsp.buf.format, mode = 'n', desc = 'format' },
    -- { key = '<Space>ff', func = vim.lsp.buf.range_formatting, mode = 'v', desc = 'range format' },

    -- {
    --   key = '<Space>gm',
    --   func = require('navigator.formatting').range_format,
    --   mode = 'n',
    --   desc = 'range format operator e.g gmip',
    -- },

    { key = '<Space>la', mode = 'n', func = require('navigator.codelens').run_action, desc = 'run code lens action' },
  }



  ,
  icons = {
    icons = false,
    -- Code action
    code_action_icon = '', -- "",
    -- code lens
    code_lens_action_icon = '',
    -- Diagnostics
    diagnostic_head = '',
    diagnostic_err = '',
    diagnostic_warn = '',
    diagnostic_info = '',
    diagnostic_hint = '',

    diagnostic_head_severity_1 = '',
    diagnostic_head_severity_2 = '',
    diagnostic_head_severity_3 = '',
    diagnostic_head_description = '',
    diagnostic_virtual_text = '',
    diagnostic_file = '',

    -- Values
    value_changed = '',
    value_definition = '', -- it is easier to see than 🦕
    side_panel = {
      section_separator = '',
      line_num_left = '',
      line_num_right = '',
      inner_node = '├○',
      outer_node = '╰○',
      bracket_left = '⟪',
      bracket_right = '⟫',
    },
    -- Treesitter
    match_kinds = {
      var = ' ', -- "👹", -- Vampaire
      method = 'ƒ ', --  "🍔", -- mac
      ['function'] = ' ', -- "🤣", -- Fun
      parameter = '  ', -- Pi
      associated = '',
      namespace = '',
      type = ' ',
      field = '',
      module = '',
      flag = '',
    },
    treesitter_defult = '🌲',
    doc_symbols = ''
  },
})

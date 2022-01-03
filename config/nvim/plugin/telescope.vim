nnoremap <leader>F <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>f <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers({sort_lastused=true})<cr>
nnoremap <leader>B <cmd>lua require('telescope').extensions.vim_bookmarks.all()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>


nnoremap <leader>g <cmd>lua require('telescope.builtin').git_bcommits()<cr>
nnoremap <leader>G <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>gs <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap <leader>gb <cmd>lua require('telescope.builtin').git_status()<cr>

nnoremap <leader>p <cmd>lua require('session-lens').search_session()<cr>


lua << EOF
local opts = {
  log_level = 'error',
  auto_session_enable_last_session = false,
  auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
  auto_session_enabled = true,
  auto_save_enabled = true,
  auto_restore_enabled = nil,
  auto_session_suppress_dirs = nil
}

require('auto-session').setup(opts)
EOF

lua << EOF
  require('telescope').load_extension('vim_bookmarks')
EOF

lua << EOF
require('telescope').load_extension("session-lens")
require('session-lens').setup {
    path_display={'shorten'},
}

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

require('telescope').setup{
defaults = {
  -- Mappings
  mappings = {
    i = {
      -- ["<esc>"] = require('telescope.actions').close,
      },
    },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_position = "bottom",
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_defaults = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}
EOF

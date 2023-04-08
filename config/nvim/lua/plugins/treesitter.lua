-- Treesitter configuration

require('nvim-treesitter.configs').setup({
  highlight = { enable = true, additional_vim_regex_highlighting = { 'org' } },
  -- We must manually specify which parsers to install
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "cuda",
    "json",
    "julia",
    "lua",
    "python",
    "yaml",
    "org"
  },
})

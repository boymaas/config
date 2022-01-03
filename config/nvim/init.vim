" See plugin/ directory for individual setup files

call plug#begin()
" Rooting
Plug 'airblade/vim-rooter'

" Load plugins
" VIM enhancements
" https://github.com/ciaranm/securemodelines/blob/master/plugin/securemodelines.vim
Plug 'ciaranm/securemodelines'
" https://editorconfig.org/
Plug 'editorconfig/editorconfig-vim'
" https://github.com/justinmk/vim-sneak 
"Plug 'justinmk/vim-sneak'

" GUI enhancements
" Plug 'itchyny/lightline.vim'
" Highlights a yank for some while
Plug 'machakann/vim-highlightedyank'
" Extends % matcher to operate on matching text. 
Plug 'andymass/vim-matchup'
" Status line
" Lightline works out of the box
" Plug 'itchyny/lightline.vim'

" Lualine needs some more attention
Plug 'nvim-lualine/lualine.nvim'
" Plug 'kyazdani42/nvim-web-devicons'
" Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-lua/lsp-status.nvim'


" Telescope, fzf replacement
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'BurntSushi/ripgrep'
Plug 'sharkdp/fd'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}


" Semantic language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Install one of these to get everything 
" working:
" CocInstall coc-rust-analyzer
" CocInstall coc-rls
" For opening and closing brackets
" CocInstall coc-pair 

" Syntactic language support
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'rhysd/vim-clang-format'

" Plug 'fatih/vim-go'

" http://vimcasts.org/episodes/aligning-text-with-tabular-vim
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" Bookmarks
Plug 'MattesGroeger/vim-bookmarks'

" Session
Plug 'rmagatti/auto-session'
Plug 'rmagatti/session-lens'

" Colorschemes
Plug 'ayu-theme/ayu-vim'
Plug 'gruvbox-community/gruvbox'

" Minimal theme
Plug 'junegunn/goyo.vim'

" Easy surrounding
Plug 'tpope/vim-surround'

" Commenting out lines
Plug 'tomtom/tcomment_vim'

" Use same terminal for everythign
Plug 'kassio/neoterm'

" Python syntax highlighting
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

" Make snippets work with coc-snippet
Plug 'honza/vim-snippets'

" Solidity coding
Plug 'tomlion/vim-solidity'

" Universal testing 
Plug 'vim-test/vim-test'

" TSX
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" Clojure
Plug 'tpope/vim-sexp-mappings-for-regular-people', {'for': 'clojure'}
Plug 'guns/vim-sexp',    {'for': 'clojure'}
Plug 'tpope/vim-repeat', {'for': 'clojure'}
" Plug 'tpope/vim-surround', <== installed above
" Plug 'liquidz/vim-iced', {'for': 'clojure'}
Plug 'bakpakin/fennel.vim'
Plug 'Olical/conjure', {'tag': 'v4.9.0'}

" JSX Editing
Plug 'maxmellon/vim-jsx-pretty'

" Coffeescript
Plug 'kchmck/vim-coffee-script'

call plug#end()

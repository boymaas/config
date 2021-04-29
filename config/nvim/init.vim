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
Plug 'itchyny/lightline.vim'
" Highlights a yank for some while
Plug 'machakann/vim-highlightedyank'
" Extends % matcher to operate on matching text. 
Plug 'andymass/vim-matchup'

" Fuzzy finder
" Rooter changes the working directory to the project root when you open a
" file or directory.
" Plug 'airblade/vim-rooter'
" A command-line fuzzy finder
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

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
"Plug 'fatih/vim-go'
" Plug 'dag/vim-fish'
" http://vimcasts.org/episodes/aligning-text-with-tabular-vim
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" Org mode for neovim
Plug 'jceb/vim-orgmode'

" Bookmarks
Plug 'MattesGroeger/vim-bookmarks'

" Colorschemes
Plug 'ayu-theme/ayu-vim'
Plug 'gruvbox-community/gruvbox'

" Easy surrounding
Plug 'tpope/vim-surround'

" Minimal theme
Plug 'junegunn/goyo.vim'

" Commenting out lines
Plug 'tomtom/tcomment_vim'
Plug 'ivanov/vim-ipython'

Plug 'kassio/neoterm'

" TODO: look at smartparens alternative
" Plug 'vim-scripts/paredit.vim'

" Python syntax highlighting
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

" Make snippets work with coc-snippet
Plug 'honza/vim-snippets'

Plug 'tomlion/vim-solidity'

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

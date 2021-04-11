" Fish doesn't play all that well with others
set shell=/bin/bash
let mapleader = ";"
let maplocalleader = ","

" Fast editing of nvim config
map <Leader>v :e $MYVIMRC<CR>
" Reloads vimrc after saving but keep cursor position
if !exists("*ReloadVimrc")
   fun! ReloadVimrc()
       let save_cursor = getcurpos()
       source $MYVIMRC
       call setpos(".", save_cursor)
   endfun
endif
autocmd! BufWritePost $MYVIMRC call ReloadVimrc()

" Fast navigation to files and buffers
map <Leader>el :e %:p:h<CR>
map <Leader>lcd :lcd %:p:h<CR>
nmap <leader>b :Buffers<CR>


command! ProjectOpenDir execute 'e ' s:find_git_root()
map <Leader>pD :ProjectOpenDir<CR>


" Quick-save
map <leader>w :w<CR>

" Quick Commenting 
vmap <Leader>' :TComment<CR>

" Quik movements between panes
map <S-Left> <C-w><Left>
map <S-Right> <C-w><Right>
map <S-Up> <C-w><Up>
map <S-Down> <C-w><Down>

" =============================================================================
" # PLUGINS
" =============================================================================
" Load vundle
set nocompatible
filetype off

call plug#begin()
" Rooring
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
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

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

if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
    noremap <C-q> :confirm qall<CR>
end

" deal with colors
if !has('gui_running')
  set t_Co=256
endif
if (match($TERM, "-256color") != -1) && (match($TERM, "screen-256color") == -1)
  " screen does not (yet) support truecolor
  set termguicolors
endif

set background=dark

set termguicolors     " enable true colors support
let ayucolor="light"  " for light version of theme
let ayucolor="mirage" " for mirage version of theme
let ayucolor="dark"   " for dark version of theme
colorscheme ayu
colorscheme gruvbox
"
syntax on

" Plugin settings
let g:secure_modelines_allowed_items = [
                \ "textwidth",   "tw",
                \ "softtabstop", "sts",
                \ "tabstop",     "ts",
                \ "shiftwidth",  "sw",
                \ "expandtab",   "et",   "noexpandtab", "noet",
                \ "filetype",    "ft",
                \ "foldmethod",  "fdm",
                \ "readonly",    "ro",   "noreadonly", "noro",
                \ "rightleft",   "rl",   "norightleft", "norl",
                \ "colorcolumn"
                \ ]

" Lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \   'cocstatus': 'coc#status'
      \ },
      \ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

" Javascript
let javaScript_fold=0

" Java
let java_ignore_javadoc=1

" Latex
let g:latex_indent_enabled = 1
let g:latex_fold_envs = 0
let g:latex_fold_sections = []


" Don't confirm .lvimrc
let g:localvimrc_ask = 0

" racer + rust
" https://github.com/rust-lang/rust.vim/issues/192
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'pbcopy'
let g:racer_cmd = "/Users/bmaas/.cargo/bin/racer"
let g:racer_experimental_completer = 1
let $RUST_SRC_PATH = systemlist("rustc --print sysroot")[0] . "/lib/rustlib/src/rust/src"
let g:rust_fold = 2
let g:cargo_shell_command_runner = '!'

" I want the root to be the one that contains the
" Cargo.toml file
let g:rooter_cd_cmd = 'lcd'
let g:rooter_patterns = ['Cargo.toml', '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile']


" Some quick bindings
" TODO: make this based on filetype

map <C-l> zz
map ,cc :Cbuild<CR>
map ,ct :Ctest -- --nocapture --test-threads=1<CR>
map ,ce :Crun<CR>
map ,cb :Cbench<CR>


nmap <silent> <leader>t  :TestLast<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>T  :TestNearest<CR>
nmap <silent> <leader>tg :TestVisit<CR>

set shell=/bin/zsh

" Completion
" Better display for messages
set cmdheight=1
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" Golang
let g:go_play_open_browser = 0
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_bin_path = expand("~/dev/go/bin")


" Python settings
let g:nvim_ipy_perform_mappings = 0

" Terminal Settings
tmap <Esc> <C-\><C-n>
tmap <S-Left> <C-\><C-n><C-w><Left>
tmap <S-Right> <C-\><C-n><C-w><Right>
tmap <S-Up> <C-\><C-n><C-w><Up>
tmap <S-Down> <C-\><C-n><C-w><Down>

nnoremap <leader>tl :Tclear<cr>

" =============================================================================
" # Editor settings
" =============================================================================
filetype plugin indent on
set autoindent
set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set encoding=utf-8
set scrolloff=2
set noshowmode
set hidden
set nowrap
set nojoinspaces
let g:sneak#s_next = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_frontmatter = 1
set printfont=:h10
set printencoding=utf-8
set printoptions=paper:letter
" Always draw sign column. Prevent buffer moving when adding/deleting sign.
set signcolumn=yes

" Settings needed for .lvimrc
set exrc
set secure

" Sane splits
set splitright
set splitbelow

" Permanent undo
set undodir=~/.vimdid
set undofile

" Decent wildmenu
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

" Use wide tabs
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" =============================================================================
" # GUI settings
" =============================================================================
set guioptions-=T " Remove toolbar
set vb t_vb= " No more beeps
set backspace=2 " Backspace over newlines
set nofoldenable
set ttyfast
" https://github.com/vim/vim/issues/1735#issuecomment-383353563
set lazyredraw
set synmaxcol=500
set laststatus=2
set relativenumber " Relative line numbers
set number " Also show current absolute line
set diffopt+=iwhite " No whitespace in vimdiff
" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
set colorcolumn=80 " and give me a colored column
set showcmd " Show (partial) command in status line.
set mouse=a " Enable mouse usage (all modes) in terminals
set shortmess+=c " don't give |ins-completion-menu| messages.

" Show those damn hidden characters
" Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
set listchars=nbsp:¬,extends:»,precedes:«,trail:•

" =============================================================================
" # Keyboard shortcuts
" =============================================================================
" ; as :
" nnoremap ; :

" Ctrl+c and Ctrl+j as Esc
" Ctrl-j is a little awkward unfortunately:
" https://github.com/neovim/neovim/issues/5916
" So we also map Ctrl+k
inoremap <C-j> <Esc>

nnoremap <C-g> <Esc>
inoremap <C-g> <Esc>
vnoremap <C-g> <Esc>
snoremap <C-g> <Esc>
xnoremap <C-g> <Esc>
cnoremap <C-g> <Esc>
onoremap <C-g> <Esc>
lnoremap <C-g> <Esc>
tnoremap <C-g> <Esc>

nnoremap <C-k> <Esc>
inoremap <C-k> <Esc>
vnoremap <C-k> <Esc>
snoremap <C-k> <Esc>
xnoremap <C-k> <Esc>
cnoremap <C-k> <Esc>
onoremap <C-k> <Esc>
lnoremap <C-k> <Esc>
tnoremap <C-k> <Esc>

nnoremap <C-c> <Esc>
inoremap <C-c> <Esc>
vnoremap <C-c> <Esc>
snoremap <C-c> <Esc>
xnoremap <C-c> <Esc>
cnoremap <C-c> <Esc>
onoremap <C-c> <Esc>
lnoremap <C-c> <Esc>
tnoremap <C-c> <Esc>

" Ctrl+h to stop searching
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

" Suspend with Ctrl+f
inoremap <C-f> :sus<cr>
vnoremap <C-f> :sus<cr>
nnoremap <C-f> :sus<cr>

" Jump to start and end of line using the home row keys
map H ^
map L $

" Neat X clipboard integration
" ,p will paste clipboard into buffer
" ,c will copy entire buffer into clipboard
noremap <leader>p :read !pbpaste<cr>
noremap <leader>c :w !pbcopy<cr><cr>

" <leader>s for Rg search
noremap <leader>pa :grep <c-r><c-v>

let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)


" Find file relative to project dir
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'FZF' s:find_git_root()
" Open hotkeys
map <Leader>F :ProjectFiles<CR>
map <Leader>f :FZF<CR>

let g:fzf_history_dir = '~/.local/share/fzf-history'


" Open new file adjacent to current file
"nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" No arrow keys --- force yourself to use the home row
" nnoremap <up> <nop>
" nnoremap <down> <nop>
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>

" Left and right can switch buffers
"nnoremap <left> :bp<CR>
"nnoremap <right> :bn<CR>

" Move by line
nnoremap j gj
nnoremap k gk

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 'Smart' nevigation
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-.> to trigger completion.
inoremap <silent><expr> <c-.> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> ]n :cnext<cr>
nmap <silent> [n :cprev<cr>


" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
nmap <silent> <TAB> <Plug>(coc-range-select)

" Show actions available at this location
nnoremap <silent> <space>a  :CocAction<cr>
vnoremap <silent> <space>a <Plug>(coc-codeaction-selected)

nmap <leader>qf  <Plug>(coc-fix-current)


" Expand snippets on TAB 
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Mappings for CoCList
" " Show all diagnostics.
nnoremap <silent><nowait> <space>d  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


" Bookmarks
let g:bookmark_save_per_working_dir = 0
let g:bookmark_auto_save = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" <leader>, shows/hides hidden characters
nnoremap <leader>, :set invlist<cr>

" <leader>q shows stats
nnoremap <leader>q g<c-g>

" Keymap for replacing up to next _ or -
noremap <leader>m ct_

" I can type :help on my own, thanks.
map <F1> <Esc>
imap <F1> <Esc>


" =============================================================================
" # Autocommands
" =============================================================================

" Prevent accidental writes to buffers that shouldn't be edited
autocmd BufRead *.orig set readonly
autocmd BufRead *.pacnew set readonly

" Leave paste mode when leaving insert mode
autocmd InsertLeave * set nopaste

" Jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Follow Rust code style rules
au Filetype rust source ~/.config/nvim/scripts/spacetab.vim
au Filetype rust set colorcolumn=100

" Help filetype detection
autocmd BufRead *.plot set filetype=gnuplot
autocmd BufRead *.md set filetype=markdown
autocmd BufRead *.lds set filetype=ld
autocmd BufRead *.tex set filetype=tex
autocmd BufRead *.trm set filetype=c
autocmd BufRead *.xlsx.axlsx set filetype=ruby

" Script plugins
autocmd Filetype html,xml,xsl,php source ~/.config/nvim/scripts/closetag.vim

autocmd Filetype javascript se sw=2
autocmd Filetype solidity se sw=2
autocmd Filetype less se sw=2

" Clojure / ClojureScript
let g:iced_enable_default_key_mappings = v:true

" =============================================================================
" # Footer
" =============================================================================

" nvim
if has('nvim')
	runtime! plugin/python_setup.vim
endif

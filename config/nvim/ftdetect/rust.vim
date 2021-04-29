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

map ,cc :Cbuild<CR>
map ,ct :Ctest -- --nocapture --test-threads=1<CR>
map ,ce :Crun<CR>
map ,cb :Cbench<CR>

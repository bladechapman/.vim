
Plug 'rust-lang/rust.vim'
let g:ale_linters.rust = ['cargo', 'rls']
let g:ale_fixers.rust = ['rustfmt']
let g:ale_rust_rls_toolchain = 'stable'

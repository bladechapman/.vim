augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

Plug 'w0rp/ale'
nmap <silent> <C-j> <Plug>(ale_previous_wrap)
nmap <silent> <C-k> <Plug>(ale_next_wrap)
let g:ale_fixers = {
    \'javascript': ['eslint'],
    \'jsx': ['eslint'],
    \'python': 'autopep8'
\}
let g:ale_linters = {}
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_lint_on_enter = 0
let g:ale_enabled = 1
let g:ale_sign_error = '🔺'
let g:ale_sign_warning = '🔸'
nnoremap <silent><F5> :ALEFix<cr>


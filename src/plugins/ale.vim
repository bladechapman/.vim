
Plug 'w0rp/ale'
nmap <silent> <C-j> <Plug>(ale_previous_wrap)
nmap <silent> <C-k> <Plug>(ale_next_wrap)
let g:ale_fixers = { 'javascript': ['eslint'], }
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_lint_on_enter = 0
let g:ale_enabled = 1
let g:ale_sign_error = '🔺'
let g:ale_sign_warning = '🔸'
nnoremap <silent><F5> :ALEFix<cr>


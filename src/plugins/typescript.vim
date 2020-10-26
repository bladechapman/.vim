Plug 'leafgarland/typescript-vim'

" REQUIRED: Add a syntax file. YATS is the best
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}

" autocmd FileType typescript nnoremap <buffer> <leader>t :TSDef<cr>
let g:ale_fixers.typescript = ['eslint']
let g:ale_fixers.typescriptreact = ['eslint']

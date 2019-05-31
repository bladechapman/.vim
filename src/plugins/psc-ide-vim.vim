
let g:psc_ide_syntastic_mode = 1

autocmd BufWritePre * if count(['purescript'],&filetype)
    \ | execute "Prebuild"
    \ | endif

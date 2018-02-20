:let g:VIMDIR = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')
function utils#Resource(path)
    execute 'source' . g:VIMDIR . '/' . a:path
endfunction

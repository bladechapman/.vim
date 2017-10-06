" Auto install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" fzf/ag search
" make sure to install fzf via HomeBrew
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
nnoremap <leader>o :Files<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>F :Ag<cr>
nnoremap <leader>f :Lines<cr>
" Ag - exclude the path and lines from the search
" https://github.com/junegunn/fzf/wiki/Examples-(vim)#narrow-ag-results-within-vim
function! s:ag_to_qf(line)
  let parts = split(a:line, ':')
  return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
        \ 'text': join(parts[3:], ':')}
endfunction
function! s:ag_handler(lines)
  if len(a:lines) < 2 | return | endif
  let cmd = get({'ctrl-x': 'split',
               \ 'ctrl-v': 'vertical split',
               \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
  let list = map(a:lines[1:], 's:ag_to_qf(v:val)')
  let first = list[0]
  execute cmd escape(first.filename, ' %#\')
  execute first.lnum
  execute 'normal!' first.col.'|zz'
  if len(list) > 1
    call setqflist(list)
    copen
    wincmd p
  endif
endfunction
command! -nargs=* Ag call fzf#run({
\ 'source':  printf('ag --nogroup --column --color "%s"',
\                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
\ 'sink*':    function('<sid>ag_handler'),
\ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
\            '--multi --bind=ctrl-a:select-all,ctrl-d:deselect-all '.
\            '--color hl:68,hl+:110',
\ 'down':    '50%'
\ })

" asynchronous lint engine
Plug 'w0rp/ale'
nmap <silent> <C-j> <Plug>(ale_previous_wrap)
nmap <silent> <C-k> <Plug>(ale_next_wrap)
let g:ale_fixers = { 'javascript': ['eslint'], }
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_sign_error = '🔺'
let g:ale_sign_warning = '🔸'
let g:ale_sign_column_always = 1
nnoremap <silent><F5> :ALEFix<cr>

" easymotion for better navigation
Plug 'easymotion/vim-easymotion'
map  / <plug>(easymotion-sn)
omap / <plug>(easymotion-tn)

" vim-airline status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='minimalist'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_highlighting_cache = 1

" vim-commentary for easier commenting
Plug 'tpope/vim-commentary'

" vim-repeat for allowing '.' repeats on supported plugins
Plug 'tpope/vim-repeat'

" vim-surround for better surrounding character support
Plug 'tpope/vim-surround'

" plugin for automatic surrounding character closing
Plug 'Raimondi/delimitmate'
let delimitMate_expand_cr = 1
set backspace=2

" vim indent guide
Plug 'Yggdroot/indentLine'
let g:indentLine_char = '⎸'
let g:indentLine_showFirstIndentLevel=1

" vim-polyglot for all the syntax highlighting
Plug 'sheerun/vim-polyglot'

" extreme tab completion
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

" colors
Plug 'sickill/vim-monokai'

" Initialize plugin system
call plug#end()


" Delete buffer while keeping window layout (don't close buffer's windows).
" Version 2008-11-18 from http://vim.wikia.com/wiki/VimTip165
if v:version < 700 || exists('loaded_bclose') || &cp
  finish
endif
let loaded_bclose = 1
if !exists('bclose_multiple')
  let bclose_multiple = 1
endif

" Display an error message.
function! s:Warn(msg)
  echohl ErrorMsg
  echomsg a:msg
  echohl NONE
endfunction

" Command ':Bclose' executes ':bd' to delete buffer in current window.
" The window will show the alternate buffer (Ctrl-^) if it exists,
" or the previous buffer (:bp), or a blank buffer if no previous.
" Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
" An optional argument can specify which buffer to close (name or number).
function! s:Bclose(bang, buffer)
  if empty(a:buffer)
    let btarget = bufnr('%')
  elseif a:buffer =~ '^\d\+$'
    let btarget = bufnr(str2nr(a:buffer))
  else
    let btarget = bufnr(a:buffer)
  endif
  if btarget < 0
    call s:Warn('No matching buffer for '.a:buffer)
    return
  endif
  if empty(a:bang) && getbufvar(btarget, '&modified')
    call s:Warn('No write since last change for buffer '.btarget.' (use :Bclose!)')
    return
  endif
  " Numbers of windows that view target buffer which we will delete.
  let wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget')
  if !g:bclose_multiple && len(wnums) > 1
    call s:Warn('Buffer is in multiple windows (use ":let bclose_multiple=1")')
    return
  endif
  let wcurrent = winnr()
  for w in wnums
    execute w.'wincmd w'
    let prevbuf = bufnr('#')
    if prevbuf > 0 && buflisted(prevbuf) && prevbuf != w
      buffer #
    else
      bprevious
    endif
    if btarget == bufnr('%')
      " Numbers of listed buffers which are not the target to be deleted.
      let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget')
      " Listed, not target, and not displayed.
      let bhidden = filter(copy(blisted), 'bufwinnr(v:val) < 0')
      " Take the first buffer, if any (could be more intelligent).
      let bjump = (bhidden + blisted + [-1])[0]
      if bjump > 0
        execute 'buffer '.bjump
      else
        execute 'enew'.a:bang
      endif
    endif
  endfor
  execute 'bdelete'.a:bang.' '.btarget
  execute wcurrent.'wincmd w'
endfunction
command! -bang -complete=buffer -nargs=? Bclose call s:Bclose('<bang>', '<args>')

syntax enable
silent! colorscheme monokai
set number
set backspace=2
set cursorline
set hlsearch
set incsearch
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set foldmethod=indent
set foldignore=
set autoread
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set undodir=~/.vim/undo

let g:python2_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

autocmd FileType javascript setlocal shiftwidth=4 softtabstop=4
autocmd FileType html setlocal shiftwidth=2 softtabstop=2
autocmd FileType haskell setlocal shiftwidth=2 softtabstop=2
autocmd FileType * exe "normal zR"

nnoremap <leader>c :ccl<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>w :Bclose<cr>
nnoremap <leader>W :bufdo Bclose<cr>

nnoremap <leader>h :wincmd h<cr>
nnoremap <leader>j :wincmd j<cr>
nnoremap <leader>k :wincmd k<cr>
nnoremap <leader>l :wincmd l<cr>

nnoremap <leader>s :w<cr>

map <SPACE> <leader>

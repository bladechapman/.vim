" Auto install vim-plug
if empty(glob(g:VIMDIR . '/autoload/plug.vim'))
    execute 'silent !curl -fLo ' . g:VIMDIR . '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(VIMDIR . '/plugged')

Plug 'purescript-contrib/purescript-vim'

Plug 'FrigoEU/psc-ide-vim'

Plug 'tpope/vim-sensible'

Plug 'tpope/vim-commentary'

Plug 'tpope/vim-repeat'

Plug 'tpope/vim-surround'

call utils#Resource('src/plugins/ale.vim')

call utils#Resource('src/plugins/rust.vim')

call utils#Resource('src/plugins/typescript.vim')

call utils#Resource('src/plugins/deoplete.vim')

call utils#Resource('src/plugins/colors.vim')

call utils#Resource('src/plugins/delimitmate.vim')

call utils#Resource('src/plugins/fzf.vim')

call utils#Resource('src/plugins/vim-airline.vim')

call utils#Resource('src/plugins/easymotion.vim')

" Initialize plugin system
call plug#end()

call utils#Resource('src/plugins/psc-ide-vim.vim')


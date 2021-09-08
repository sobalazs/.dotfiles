source ~/.config/nvim/nvim.conf

call plug#begin('~/.vim/plugged')
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh'
    \ }
call plug#end()

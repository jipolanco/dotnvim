let b:commentary_format = '// %s'

" Google style C++ (see `clang-format -style=google -dump-config`)
setlocal textwidth=80
setlocal expandtab
setlocal shiftwidth=2
setlocal tabstop=8

" Mappings for clang-format
map <c-k> :pyf $HOME/.vim/clang-format.py<cr>
imap <c-k> <c-o>:pyf $HOME/.vim/clang-format.py<cr>

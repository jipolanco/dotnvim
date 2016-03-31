let b:commentary_format = '// %s'

" Google style C++ (see `clang-format -style=google -dump-config`)
setlocal textwidth=80
setlocal expandtab
setlocal shiftwidth=2
setlocal tabstop=8

" Mappings for clang-format
if has('python3')
    map <c-k> :py3file $HOME/.config/nvim/clang-format.py<cr>
    imap <c-k> <c-o>:py3file $HOME/.config/nvim/clang-format.py<cr>
else
    map <c-k> :pyfile $HOME/.config/nvim/clang-format_py2.py<cr>
    imap <c-k> <c-o>:pyfile $HOME/.config/nvim/clang-format_py2.py<cr>
end

" Disable neomake (conflicts with YouCompleteMe)
let g:neomake_cpp_enabled_makers = []

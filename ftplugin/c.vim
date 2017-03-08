" The configuration is very similar to the one used for C++.

" Google style C (see `clang-format -style=google -dump-config`)
setlocal textwidth=80
setlocal expandtab
setlocal shiftwidth=2

setlocal tabstop=2

" Mappings for clang-format
if has('python3')
    map <localleader>f :py3file $HOME/.config/nvim/clang-format.py<cr>
else
    map <localleader>f :pyfile $HOME/.config/nvim/clang-format_py2.py<cr>
end

" Disable neomake (conflicts with YouCompleteMe)
let g:neomake_c_enabled_makers = []

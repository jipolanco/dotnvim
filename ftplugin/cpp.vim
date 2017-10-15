let b:commentary_format = '// %s'

" Google style C++ (see `clang-format -style=google -dump-config`)
setlocal textwidth=80
setlocal expandtab
setlocal shiftwidth=2
setlocal tabstop=2

" Folding
syn sync fromstart
setlocal foldmethod=syntax
set foldnestmax=4
let c_no_comment_fold = 1

" Mappings for clang-format
if has('python3')
    map <localleader>f :py3file $HOME/.config/nvim/clang-format.py<cr>
end

" Disable neomake (conflicts with YouCompleteMe)
let g:neomake_cpp_enabled_makers = []

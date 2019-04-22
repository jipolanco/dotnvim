let b:commentary_format = '// %s'

" Similar to Google style C++ (see `clang-format -style=google -dump-config`)
setlocal textwidth=80
setlocal expandtab
setlocal shiftwidth=2
setlocal tabstop=8

" Folding
syn sync fromstart
setlocal foldmethod=syntax
set foldnestmax=4
let g:c_no_comment_fold = 1

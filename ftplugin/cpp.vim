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
let g:c_no_comment_fold = 1

" Mappings for clang-format
if has('python3')
    map <localleader>f :py3file $HOME/.config/nvim/clang-format.py<cr>
end

" LanguageClient + cquery
" https://github.com/cquery-project/cquery/wiki/Neovim
" setlocal completefunc=LanguageClient#complete
" setlocal formatexpr=LanguageClient_textDocument_rangeFormatting()

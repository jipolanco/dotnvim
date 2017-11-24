" See ":h commentary.txt" (vim-commentary plugin).
let b:commentary_format = '# %s'

" Tagbar.
" Needs ctags definitions from (add to ~/.ctags):
" https://github.com/JuliaLang/julia/blob/master/contrib/ctags .
let g:tagbar_type_julia = {
    \ 'ctagstype' : 'julia',
    \ 'kinds'     : ['f:function']
    \ }

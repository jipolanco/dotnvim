" LaTeX-to-Unicode (L2U) via tab key doesn't play nicely with YouCompleteMe...
let g:latex_to_unicode_tab = 0
let g:latex_to_unicode_suggestions = 0
let g:latex_to_unicode_auto = 1

" Use <c-space> as an alternative L2U mapping (instead of tab).
inoremap <C-Space> <C-x><C-o>

" See ":h commentary.txt" (vim-commentary plugin).
let b:commentary_format = '# %s'

" Tagbar.
" Needs ctags definitions from (add to ~/.ctags):
" https://github.com/JuliaLang/julia/blob/master/contrib/ctags .
let g:tagbar_type_julia = {
    \ 'ctagstype' : 'julia',
    \ 'kinds'     : ['f:function']
    \ }

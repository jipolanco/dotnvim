let g:tex_flavor = 'latex'

setlocal shiftwidth=2
setlocal tabstop=2

" Use conceal mode (see ":h tex-conceal").
setlocal conceallevel=2
let g:tex_conceal = 'abdmgs'

" Treat all tex files as style files (*.sty).
" This means that underscores are considered as keywords.
" (see ":h g:tex_stylish").
let g:tex_stylish = 1

" Spellcheck.
setlocal spell
setlocal spelllang=en_gb
let g:tex_comment_nospell = 1   " Don't check comments.

" Syntastic.
let g:syntastic_tex_checkers = ['chktex', 'lacheck']

" ========================================================================== "
" Vimtex plugin.

" Use okular for forward search.
" NOTE: backward search doesn't work right now with neovim.
" It works with vim/gvim though (see ":h vimtex-synctex-backward-search").
let g:vimtex_view_method = 'okular'

" See ":h vimtex-complete-youcompleteme".
if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = [
      \ 're!\\[A-Za-z]*(ref|cite)[A-Za-z]*([^]]*])?{([^}]*, ?)*'
      \ ]

" See ":h vimtex-faq-surround".
augroup latexSurround
    autocmd!
    autocmd FileType tex call s:latexSurround()
augroup END

function! s:latexSurround()
    let b:surround_{char2nr("e")}
                \ = "\\begin{\1environment: \1}\n\t\r\n\\end{\1\1}"
    let b:surround_{char2nr("c")} = "\\\1command: \1{\r}"
endfunction

" ========================================================================== "

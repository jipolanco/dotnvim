setlocal shiftwidth=2

" Use conceal mode (see ":h tex-conceal").
setlocal conceallevel=2
let g:tex_conceal = 'amg'

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

" Don't fold using vimtex in diff mode.
" NOTE: this doesn't work!!!
" if &diff
"     let g:vimtex_fold_enabled = 0
" else
"     let g:vimtex_fold_enabled = 1
" end
let g:vimtex_fold_enabled = 1
let g:vimtex_fold_envs = 0

" Open table of contents (shortcut \lt) and table of labels (\ly) at the right.
let g:vimtex_index_split_pos = 'vert rightbelow'

" Don't open the quickfix window automatically when there are only warnings.
let g:vimtex_quickfix_open_on_warning = 0

" Use okular for forward search.
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'

" See ":h vimtex-complete-youcompleteme".
if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = [
      \ 're!\\[A-Za-z]*cite[A-Za-z]*(\[[^]]*\]){0,2}{[^}]*',
      \ 're!\\[A-Za-z]*ref({[^}]*|range{([^,{}]*(}{)?))',
      \ 're!\\hyperref\[[^]]*',
      \ 're!\\includegraphics\*?(\[[^]]*\]){0,2}{[^}]*',
      \ 're!\\(include(only)?|input){[^}]*',
      \ 're!\\\a*(gls|Gls|GLS)(pl)?\a*(\s*\[[^]]*\]){0,2}\s*\{[^}]*',
      \ 're!\\includepdf(\s*\[[^]]*\])?\s*\{[^}]*',
      \ 're!\\includestandalone(\s*\[[^]]*\])?\s*\{[^}]*',
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

" See ":h vimtex-faq-neovim"
" Requires neovim-remote: https://github.com/mhinz/neovim-remote
if has('nvim')
    let g:vimtex_compiler_progname = 'nvr'
endif

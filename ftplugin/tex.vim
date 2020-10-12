setlocal shiftwidth=2

" Use conceal mode (see ":h tex-conceal").
" let g:tex_conceal = 'abdmg'
setlocal conceallevel=0

setlocal wrap
setlocal textwidth=0

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
let g:vimtex_quickfix_open_on_warning = 0

let g:vimtex_fold_enabled = 1
let g:vimtex_format_enabled = 0

" Use lualatex as default latexmk engine.
" This can be overriden using a TeX program directive (see ":h vimtex-tex-program").
" let g:vimtex_compiler_latexmk_engines = {'_':  '-lualatex'}

" Config for okular.
let g:vimtex_view_method = 'general'
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimtex_view_use_temp_files = 0

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

" Use local `texdoc` to open documentation (instead of searching online on
" texdoc.net).
" Copied from ":h g:vimtex_doc_handlers"
let g:vimtex_doc_handlers = ['MyHandler']
function! MyHandler(context)
  call vimtex#doc#make_selection(a:context)
  if !empty(a:context.selected)
    execute '!texdoc' a:context.selected '&'
  endif
  return 1
endfunction

" See ":h vimtex-faq-neovim"
" Requires neovim-remote: https://github.com/mhinz/neovim-remote
if has('nvim')
    let g:vimtex_compiler_progname = 'nvr'
endif

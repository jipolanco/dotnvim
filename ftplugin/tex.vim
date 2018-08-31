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
let g:vimtex_quickfix_open_on_warning = 0

" let g:vimtex_fold_enabled = 1
let g:vimtex_format_enabled = 1

" Use lualatex as default latexmk engine.
" This can be overriden using a TeX program directive (see ":h vimtex-tex-program").
" let g:vimtex_compiler_latexmk_engines = {'_':  '-lualatex'}

" Remove -pdf option from default latexmk parameters.
" This way, the value of $pdf_mode in .latexmkrc is respected.
" In particular, if $pdf_mode = 4, pdf files are created using lualatex.
" let g:vimtex_compiler_latexmk = {
"     \ 'options' : [
"     \   '-verbose',
"     \   '-file-line-error',
"     \   '-synctex=1',
"     \   '-interaction=nonstopmode',
"     \ ],
"     \}

" Open table of contents (shortcut \lt) and table of labels (\ly) at the right.
" let g:vimtex_index_split_pos = 'vert rightbelow'

" Don't open the quickfix window automatically when there are only warnings.
" let g:vimtex_quickfix_open_on_warning = 0

" Config for zathura.
" let g:vimtex_view_method = 'zathura'
" let g:vimtex_view_use_temp_files = 1

" Config for okular.
let g:vimtex_view_method = 'general'
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'

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

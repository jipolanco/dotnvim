setlocal shiftwidth=2
setlocal tabstop=2

" Use conceal mode (see ":h tex-conceal").
setlocal conceallevel=2
let g:tex_conceal = 'abdmg'

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
let g:vimtex_fold_enabled = 0
let g:vimtex_fold_envs = 0

let g:vimtex_latexmk_continuous = 1
let g:vimtex_latexmk_background = 1  " always run latexmk in the background
let g:vimtex_latexmk_options = '-verbose -file-line-error -synctex=1 -interaction=nonstopmode'

" Open table of contents (shortcut \lt) and table of labels (\ly) at the right.
let g:vimtex_index_split_pos = 'vert rightbelow'

" Don't open the quickfix window automatically when there are only warnings.
let g:vimtex_quickfix_open_on_warning = 0

" Use okular for forward search.
" NOTE: backward search doesn't work right now with neovim.
" It works with vim/gvim though (see ":h vimtex-synctex-backward-search").
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique @pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'

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

" See ":h vimtex-faq-neovim"
" Requires neovim-remote: https://github.com/mhinz/neovim-remote
if has('nvim')
    let g:vimtex_latexmk_progname = 'nvr'
endif

" ========================================================================== "
" LatexBox plugin.

" Forward search with Okular (mapping is only defined if LatexBox is loaded).
if exists('g:LatexBox_quickfix')
    nnoremap <silent> <LocalLeader>ls :silent
                \ !okular --unique
                \ <C-R>=LatexBox_GetOutputFile()<CR>
                \ \#src:<C-R>=line('.')<CR><C-R>=expand('%:p')<CR> &<CR>
endif

let g:LatexBox_viewer = 'okular --unique'
let g:LatexBox_latexmk_async = 1
let g:LatexBox_latexmk_preview_continuously = 1
let g:LatexBox_quickfix = 2   " set to 4 to disable opening quickfix when no errors
let g:LatexBox_split_side = 'rightbelow'
let g:LatexBox_ignore_warnings = []

let g:LatexBox_Folding = 1
let g:LatexBox_fold_envs = 0
" let g:LatexBox_fold_automatic = 0  " uncomment this if things are too slow

" ========================================================================== "

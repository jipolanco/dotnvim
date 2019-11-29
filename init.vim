set encoding=utf-8
scriptencoding utf-8
filetype indent plugin on

" Use true colours in terminal.
if has('termguicolors')
    set termguicolors
end

" ========================================================================== "
" PLUGINS
call plug#begin('~/.local/share/nvim/plugged')

Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'
Plug 'alx741/vinfo'
Plug 'w0rp/ale'
" Plug 'andymass/vim-matchup'
Plug 'christoomey/vim-tmux-navigator'
Plug 'honza/vim-snippets'
Plug 'junegunn/vim-easy-align'
" Plug 'KabbAmine/zeavim.vim'
" Plug 'Konfekt/FastFold'
Plug 'kshenoy/vim-signature'
Plug 'Lokaltog/vim-easymotion'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
" Plug 'neomake/neomake'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdtree'
Plug 'SirVer/ultisnips'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'lambdalisue/gina.vim'
Plug 'tpope/vim-repeat'
if !has('nvim')
    Plug 'tpope/vim-sensible'
endif
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'Valloric/ListToggle'
Plug 'Konfekt/FastFold'

Plug 'Shougo/echodoc.vim'
Plug 'Shougo/neco-vim'

Plug 'neoclide/coc-neco'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Coc plugins
" Not sure if this works...
" (https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#use-vims-plugin-manager-for-coc-extension)
" Plug 'fannheyward/coc-texlab', {'do': 'yarn install --frozen-lockfile'}

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Language-specific plugins.
" Plug 'bfredl/nvim-ipy'    " ipython

Plug 'JuliaEditorSupport/julia-vim'
" let g:default_julia_version = 'devel'
let g:latex_to_unicode_tab = 0
let g:latex_to_unicode_auto = 1
let g:latex_to_unicode_file_types = '.*'
let g:latex_to_unicode_file_types_blacklist = 'tex'
" noremap <expr> <F7> LaTeXtoUnicode#Toggle()
" inoremap <expr> <F7> LaTeXtoUnicode#Toggle()

Plug 'lervag/vimtex'
Plug 'chriskempson/base16-vim'
Plug 'dag/vim-fish'
Plug 'jvirtanen/vim-octave'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-after'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'Vimjas/vim-python-pep8-indent'

Plug 'hail2u/vim-css3-syntax'

" Colourschemes.
Plug 'nanotech/jellybeans.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'Wutzara/vim-materialtheme'
Plug 'morhetz/gruvbox'
Plug 'iCyMind/NeoSolarized'
Plug 'joshdick/onedark.vim'
Plug 'mhartington/oceanic-next'

call plug#end()

" ========================================================================== "
" THEME / APPEARANCE

if $VIM_BACKGROUND ==# 'light'
    set background=light
else
    set background=dark
end

colorscheme NeoSolarized
let g:airline_theme = 'solarized'
set winhighlight=

" Fix solarized8 / NeoSolarized colour schemes in vim + tmux (see README.md of
" NeoSolarized)
if !has('nvim')
    set t_8f=[38;2;%lu;%lu;%lum
    set t_8b=[48;2;%lu;%lu;%lum
end

set laststatus=2
set statusline+=%{gutentags#statusline()}

" Disable cursor styling if inside an ssh session.
if $SSH_CONNECTION !=# ''
    set guicursor=
end

" Height of the command bar
set cmdheight=2

" Numbers.
set number
set relativenumber

" Always draw sign column.
set signcolumn=yes

set lazyredraw  " don't redraw during macros, etc.

set showcmd
set showmatch
set linebreak

set hidden

" ========================================================================== "
" GENERAL STUFF
let g:mapleader = "\<Space>"
let g:maplocalleader = '\'

set wildignore+=*.o,*~,*.pyc
set splitright
set mouse=a
set mousemodel=popup_setpos

" "Y" yanks from cursor to end of line.
noremap Y y$

" Searching.
set ignorecase
set smartcase
set hlsearch

if executable('rg')
    " Use ripgrep instead of grep. Taken from
    " https://github.com/BurntSushi/ripgrep/issues/425#issuecomment-381446152
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif

" Tabs / indenting.
set expandtab
set shiftwidth=4
set tabstop=8
set smartindent

set textwidth=80

" Wrapping
set wrap
set sidescroll=1

" Automatically insert comment leader in new lines.
" NOTE: this is overriden by the ftplugins of several languages
" (for example C++ and vimscript).
set formatoptions+=r    " after hitting <Enter> in Insert mode
" set formatoptions+=o    " after hitting 'o' or 'O' in Normal mode

" Recognise numbered lists.
set formatoptions+=n

" Settings copied from Fedora's /etc/vimrc (Fedora 21).
augroup fedora
    autocmd!
    " In text files, always limit the width of text to 78 characters
    autocmd BufRead *.txt set tw=78
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line ("'\"") <= line("$") |
                \   exe "normal! g'\"" |
                \ endif
    " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
    autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
    " start with spec file template
    autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
augroup END

let g:netrw_browsex_viewer = 'xdg-open'
let g:netrw_home = expand('~/.local/share/nvim')

" ========================================================================== "
" LaTeX / vimtex (see also ftplugin/tex.vim)
let g:tex_flavor = 'latex'
let g:latexrefman_use_example_mappings = 1

" See ":h vimtex-faq-neovim"
" Requires neovim-remote: https://github.com/mhinz/neovim-remote
if has('nvim')
    let g:vimtex_compiler_progname = 'nvr'
endif

augroup set_latex_filetypes
    autocmd!
    autocmd BufRead,BufNewFile *.pgf       set filetype=tex
    autocmd BufRead,BufNewFile *.tikz      set filetype=tex
    autocmd BufRead,BufNewFile *.pdf_tex   set filetype=tex
    autocmd BufRead,BufNewFile .latexmkrc  set filetype=perl
augroup END

" Man pages (defines :Man and <leader>K).
if !has('nvim')
    runtime! ftplugin/man.vim
end

" Other file types.
augroup set_other_filetypes
    autocmd!
    autocmd BufRead,BufNewFile *.md           set filetype=markdown
    autocmd BufRead,BufNewFile *.plt,.gnuplot set filetype=gnuplot
augroup END

" Rust
let g:rust_conceal = 1
let g:rust_conceal_mod_path = 0
let g:rust_conceal_pub = 1
let g:rust_recommended_style = 1
let g:rust_fold = 1
let g:rustfmt_autosave = 1
" let g:ftplugin_rust_source_path = $RUST_SRC_PATH

" ========================================================================== "
" PLUGINS
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
" let g:EditorConfig_disable_rules = ['trim_trailing_whitespace']

let g:echodoc#enable_at_startup = 1

let g:surround_indent = 1

" COC {{{
augroup COC
  " Stuff adapted from
  " https://github.com/neoclide/coc.nvim#example-vim-configuration

  " Smaller updatetime for CursorHold & CursorHoldI
  set updatetime=300

  " don't give |ins-completion-menu| messages.
  " set shortmess+=c

  " always show signcolumns
  set signcolumn=yes

  " Use tab for trigger completion with characters ahead and navigate.
  " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
  " Coc only does snippet and additional edit on confirm.
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

  " Use `[d` and `]d` to navigate diagnostics
  nmap <silent> [d <Plug>(coc-diagnostic-prev)
  nmap <silent> ]d <Plug>(coc-diagnostic-next)

  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Show documentation in preview window with alt-K
  nnoremap <silent> <M-k> :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction


  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Remap for rename current word
  nmap <F2> <Plug>(coc-rename)

  " Remap for format selected region
  vmap <localleader>f  <Plug>(coc-format-selected)
  nmap <localleader>f  <Plug>(coc-format-selected)

  augroup COC_mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

    " Correct highlighting of comments in coc-settings.json.
    autocmd FileType json syntax match Comment +\/\/.\+$+
  augroup end

  " Remap for do codeAction of selected region, ex: `<leader>aap` for current
  " paragraph
  vmap <localleader>a  <Plug>(coc-codeaction-selected)
  nmap <localleader>a  <Plug>(coc-codeaction-selected)

  " Remap for do codeAction of current line
  nmap <localleader>ac  <Plug>(coc-codeaction)

  " Fix autofix problem of current line
  nmap <localleader>qf  <Plug>(coc-fix-current)

  " Use `:Format` to format current buffer
  command! -nargs=0 Format :call CocAction('format')

  " Use `:Fold` to fold current buffer
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " Add diagnostic info for https://github.com/itchyny/lightline.vim
  let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
        \ },
        \ 'component_function': {
        \   'cocstatus': 'coc#status'
        \ },
        \ }

  " Using CocList
  " Show all diagnostics
  nnoremap <silent> <leader>d  :<C-u>CocList diagnostics<cr>
  " Manage extensions
  nnoremap <silent> <leader>e  :<C-u>CocList extensions<cr>
  " Show commands
  nnoremap <silent> <leader>c  :<C-u>CocList commands<cr>
  " Find symbol of current document
  nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>
  " Search workspace symbols
  nnoremap <silent> <leader>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent> <leader>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent> <leader>k  :<C-u>CocPrev<CR>
  " Resume latest coc list
  nnoremap <silent> <leader>p  :<C-u>CocListResume<CR>
augroup end

" }}}

" Airline {{{

" Gutentags integration.
" Show "TAGS" in the status line while gutentags is generating tags.
function! GutentagsStatus(...)
    let w:airline_section_a = '%{gutentags#statusline()}'
endfunction
" call airline#add_statusline_func('GutentagsStatus')

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " show tab number
let g:airline_powerline_fonts = 1

" }}}

" ALE {{{
" Disable ALE for some languages (using LanguageClient or COC instead).
let g:ale_linters = {}
let g:ale_linters.c = []
let g:ale_linters.cpp = []
let g:ale_linters.fortran = []
let g:ale_linters.julia = []
" let g:ale_linters.pandoc = []
let g:ale_linters.perl = ['perl', 'perlcritic']
let g:ale_linters.python = []
let g:ale_linters.rust = []
let g:ale_linters.tex = ['chktex', 'lacheck']

let g:ale_linter_aliases = {'pandoc': 'markdown'}
let g:ale_python_mypy_options = '--ignore-missing-imports'

" }}}

" UltiSnips (and also NCM2) {{{
" See also docs for ncm2-ultisnips plugin.
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsSnippetsDir = '~/.config/nvim/UltiSnips'
" let g:UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
let g:UltiSnipsExpandTrigger = '<c-u>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
let g:UltiSnipsListSnippets = '<m-u>'
let g:UltiSnipsRemoveSelectModeMappings = 0
" inoremap <silent> <c-u> <c-r>=cm#sources#ultisnips#trigger_or_popup("\<Plug>(ultisnips_expand)")<cr>

" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
" inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" }}}

" Gutentags {{{
" Write tags files to this folder:
let g:gutentags_cache_dir = '/tmp/gutentags'

" Don't generate tags for project documentation (e.g. doxygen-generated files)
" and some CMake-generated files.
let g:gutentags_ctags_exclude = ['doc', 'CMakeFiles']

" }}}

" Pandoc {{{
" vim-pandoc-after plugin (integrates vim-pandoc with other plugins)
let g:pandoc#after#modules#enabled = ['ultisnips']
let g:pandoc#modules#disabled = ['chdir']
let g:pandoc#formatting#mode = 'sa'

" Don't use italics, they don't work for me in neovim + tmux (default: 1).
" let g:pandoc#syntax#style#emphases = 0
let g:pandoc#command#latex_engine = 'lualatex'

" Remove trailing whitespace from Pandoc markdown files (which are generated
" by autoformatting).
augroup PANDOC_TRAILING
    autocmd BufWritePre *.md :%s/\s\+$//e
augroup END

" }}}

" GitGutter {{{
" Note: gitgutter default mappings "ic" and "ac" conflict with vimtex (for LaTeX
" commands), so we disable them and manually define a few mappings.
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
nmap [c <Plug>(GitGutterPrevHunk)
nmap ]c <Plug>(GitGutterNextHunk)

" }}}

" More mappings {{{

" Use <leader>h to clear the highlighting of :set hlsearch.
" Copied from vim-sensible plugin, which uses <C-L>, but this mapping conflicts
" with vim-tmux-navigator.
nnoremap <silent> <leader>h :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><leader>h

" This changes the behaviour of j and k in wrapped lines.
" noremap j gj
" noremap k gk

" Change dir to the directory of the open buffer.
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>

nnoremap <silent> <F8> :TagbarToggle<CR>
nnoremap <leader>n :NERDTreeToggle<cr>

" FZF {{{
nnoremap <leader>b :Buffers<cr>
" Files in the directory of the current file.
nnoremap <leader>f :Files %:p:h<cr>
" Git files (mapping is compatible with fugitive!).
nnoremap <leader>gf :GFiles<cr>
nnoremap <leader>T :Tags<cr>
nnoremap <leader>t :BTags<cr>
" Note: <leader>l is used by ListToggle
nnoremap <leader>L :BLines<cr>
nnoremap <leader>H :History<cr>
nnoremap <leader>: :History:<cr>
nnoremap <leader>/ :History/<cr>
nnoremap <leader>w :Windows<cr>
" }}}

" Fugitive {{{
nmap <leader>gg :Gstatus<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gw :Gwrite<CR>
nmap <leader>ge :Gedit<CR>
" }}}

" This fixes comment indenting in Python (see ":h smartindent").
inoremap # X#

" DelimitMate: use <c-l> to jump over a delimiter
imap <c-l> <Plug>delimitMateS-Tab

" easy-align {{{
" (mappings copied from README.md)
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" Underline a line of text
" Based on http://vim.wikia.com/wiki/Underline_using_dashes_automatically
nmap <leader>= yypv$r=
nmap <leader>- yypv$r-

" Like 'do' and 'dp' (diff-obtain and diff-put) normal-mode commands, but for
" visual mode.
vnoremap <silent> <leader>do :diffget<cr>
vnoremap <silent> <leader>dp :diffput<cr>

" Terminal mappings {{{
" (see ":h terminal-emulator")
if has('nvim')
    " Stuff taken from ":h terminal-input".
    " NOTE: using just one <Esc> conflicts with the terminal vi-mode.
    tnoremap <Esc><Esc> <C-\><C-n>      " exit terminal mode
end

" }}}

" }}}

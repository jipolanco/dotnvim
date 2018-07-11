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

" ncm2 stuff
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-ultisnips'
Plug 'ncm2/ncm2-abbrfuzzy'

Plug 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'next',
            \ 'do': 'bash install.sh',
            \ }
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/neco-vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Language-specific plugins.
" Plug 'bfredl/nvim-ipy'    " ipython

Plug 'JuliaEditorSupport/julia-vim'
let g:default_julia_version = 'devel'
let g:latex_to_unicode_tab = 0
" let g:latex_to_unicode_suggestions = 0
let g:latex_to_unicode_auto = 1
" let g:latex_to_unicode_file_types = '.*'
" noremap <expr> <F7> LaTeXtoUnicode#Toggle()
" inoremap <expr> <F7> LaTeXtoUnicode#Toggle()

Plug 'lervag/vimtex'
Plug 'chriskempson/base16-vim'
Plug 'dag/vim-fish'
Plug 'jvirtanen/vim-octave'
Plug 'keith/tmux.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-after'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'

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

" Airline + gutentags integration.
" Show "TAGS" in the status line while gutentags is generating tags.
function! GutentagsStatus(...)
    let w:airline_section_a = '%{gutentags#statusline()}'
endfunction
" call airline#add_statusline_func('GutentagsStatus')

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " show tab number
let g:airline_powerline_fonts = 1

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

" Tabs / indenting.
set expandtab
set shiftwidth=4
set tabstop=4
set smartindent

set textwidth=80

" Wrapping
set wrap
set sidescroll=5

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

" Fix 'gx' mapping in Gnome 3.18 (not sure why it wasn't working...)
let g:netrw_browsex_viewer = 'xdg-open'

" ========================================================================== "
" LaTeX
let g:tex_flavor = 'latex'
let g:latexrefman_use_example_mappings = 1

augroup set_latex_filetypes
    autocmd!
    autocmd BufRead,BufNewFile *.pgf     set filetype=tex
    autocmd BufRead,BufNewFile *.tikz    set filetype=tex
    autocmd BufRead,BufNewFile *.pdf_tex set filetype=tex
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

" ncm2 (formerly neovim completion manager)
let g:ncm2#matcher = 'abbrfuzzy'
let g:ncm2#sorter = 'abbrfuzzy'

" TODO try "preview"
set completeopt=noinsert,menuone,noselect

augroup my_cm_setup
  autocmd!

  " enable ncm2 for all buffers
  autocmd BufEnter * call ncm2#enable_for_buffer()

  " enable auto complete for `<backspace>`, `<c-w>` keys.
  " known issue https://github.com/ncm2/ncm2/issues/7
  autocmd TextChangedI * call ncm2#auto_trigger()

  " LaTeX / vimtex
  " TODO test! not sure if this works
  autocmd User Ncm2Plugin call ncm2#register_source({
        \ 'name' : 'vimtex',
        \ 'priority': 8,
        \ 'subscope_enable': 1,
        \ 'scope': ['tex'],
        \ 'mark': 'tex',
        \ 'on_complete': ['ncm2#on_complete#delay', 180,
        \                 'ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
        \ })
        " \ 'cm_refresh_patterns': g:vimtex#re#ncm,
        " \ 'cm_refresh': {'omnifunc': 'vimtex#complete#omnifunc'},
augroup END

" See ":h NCM2-vimrc"
set shortmess+=c
inoremap <c-c> <ESC>
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" imap <expr> <CR>  (pumvisible() ?  "\<c-y>\<Plug>(expand_or_nl)" : "\<CR>")
" imap <expr> <Plug>(expand_or_nl) (cm#completed_is_snippet() ? "\<C-U>":"\<CR>")

" LanguageClient
" For some ideas, see https://github.com/cquery-project/cquery/wiki/Neovim
let g:LanguageClient_serverCommands = {
            \ 'python': ['pyls'],
            \ 'c': ['~/opt/cquery/bin/cquery', '--log-file=/tmp/cquery.log'],
            \ 'cpp': ['~/opt/cquery/bin/cquery', '--log-file=/tmp/cquery.log'],
            \ 'rust': ['rustup', 'run', 'stable', 'rls'],
\ }
" \ 'julia': ['julia', '--startup-file=no', '--history-file=no', '-e', '
" \       using LanguageServer;
" \       server = LanguageServer.LanguageServerInstance(STDIN, STDOUT, false);
" \       server.runlinter = true;
" \       run(server);
" \   '],
let g:LanguageClient_settingsPath = expand('~/.config/nvim/settings.json')
let g:LanguageClient_loadSettings = 1

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

" Use location instead of quickfix list for diagnostics.
let g:LanguageClient_diagnosticsList = 'Location'

function! LanguageClientSetMaps()
    " Mappings proposed at:
    " https://github.com/cquery-project/cquery/wiki/Neovim
    nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
    nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
    nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
    nnoremap <silent> gs :call LanguageClient#textDocument_documentSymbol()<CR>
    nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
    nnoremap <silent> <F5> :call LanguageClient_contextMenu()<CR>
endfunction

augroup LanguageClient_config
    autocmd!
    autocmd User LanguageClientStarted
                \ setlocal
                \ formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
    autocmd User LanguageClientStarted
                \ setlocal completefunc=LanguageClient#complete
    autocmd User LanguageClientStarted
                \ exec LanguageClientSetMaps()
augroup END

" ALE
" Disable ALE for python, C, C++, Rust (using LanguageClient instead).
let g:ale_linters = {
            \   'c': [],
            \   'cpp': [],
            \   'python': [],
            \   'tex': ['chktex', 'lacheck'],
            \   'pandoc': [],
            \   'perl': ['perl', 'perlcritic'],
            \   'rust': [],
            \}

let g:ale_linter_aliases = {'pandoc': 'markdown'}
let g:ale_python_mypy_options = '--ignore-missing-imports'

" UltiSnips (and also NCM)
" See also docs for ncm2-ultisnips plugin.
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsSnippetsDir = '~/.config/nvim/UltiSnips'
let g:UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
let g:UltiSnipsListSnippets = '<m-u>'
let g:UltiSnipsRemoveSelectModeMappings = 0
" inoremap <silent> <c-u> <c-r>=cm#sources#ultisnips#trigger_or_popup("\<Plug>(ultisnips_expand)")<cr>

" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" Surround
let g:surround_indent = 1

" Gutentags -- write tags files to this folder:
let g:gutentags_cache_dir = '/tmp/gutentags'

" Don't generate tags for project documentation (e.g. doxygen-generated files)
" and some CMake-generated files.
let g:gutentags_ctags_exclude = ['doc', 'CMakeFiles']

" Pandoc
" vim-pandoc-after plugin (integrates vim-pandoc with other plugins)
let g:pandoc#after#modules#enabled = ['ultisnips']
let g:pandoc#formatting#mode = 'sa'

" Don't use italics, they don't work for me in neovim (default: 1).
let g:pandoc#syntax#style#emphases = 0
let g:pandoc#command#latex_engine = 'lualatex'

" Remove trailing whitespace from Pandoc markdown files (which are generated
" by autoformatting).
augroup PANDOC_TRAILING
    autocmd BufWritePre *.md :%s/\s\+$//e
augroup END

" GitGutter
" Note: gitgutter default mappings "ic" and "ac" conflict with vimtex (for LaTeX
" commands), so we disable them and manually define a few mappings.
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
nmap [c <Plug>GitGutterPrevHunk
nmap ]c <Plug>GitGutterNextHunk

" ========================================================================== "
" MORE MAPPINGS.

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

" FZF
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

" Fugitive
nmap <leader>gg :Gstatus<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gw :Gwrite<CR>
nmap <leader>ge :Gedit<CR>

" This fixes comment indenting in Python (see ":h smartindent").
inoremap # X#

" DelimitMate: use <c-l> to jump over a delimiter
imap <c-l> <Plug>delimitMateS-Tab

" easy-align (mappings copied from README.md)
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Underline a line of text
" Based on http://vim.wikia.com/wiki/Underline_using_dashes_automatically
nmap <leader>= yypv$r=
nmap <leader>- yypv$r-

" Terminal mappings (see ":h terminal-emulator").
if has('nvim')
    " Stuff taken from ":h terminal-input".
    " NOTE: using just one <Esc> conflicts with the terminal vi-mode.
    tnoremap <Esc><Esc> <C-\><C-n>      " exit terminal mode

    " To use `ALT+{h,j,k,l}` to navigate windows from any mode:
    tnoremap <A-h> <C-\><C-N><C-w>h
    tnoremap <A-j> <C-\><C-N><C-w>j
    tnoremap <A-k> <C-\><C-N><C-w>k
    tnoremap <A-l> <C-\><C-N><C-w>l
    inoremap <A-h> <C-\><C-N><C-w>h
    inoremap <A-j> <C-\><C-N><C-w>j
    inoremap <A-k> <C-\><C-N><C-w>k
    inoremap <A-l> <C-\><C-N><C-w>l
    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l
end

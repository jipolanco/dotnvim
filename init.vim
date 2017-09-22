set encoding=utf-8
scriptencoding utf-8
filetype indent plugin on

let b:use_ycm = 0
let b:use_deoplete = 1 && !b:use_ycm

" Use true colours in terminal.
if has('termguicolors')
    set termguicolors
end

" ========================================================================== "
" PLUGINS
call plug#begin('~/.config/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'alx741/vinfo'
" Plug 'scrooloose/syntastic'
Plug 'w0rp/ale'
Plug 'christoomey/vim-tmux-navigator'
Plug 'honza/vim-snippets'
Plug 'junegunn/vim-easy-align'
Plug 'KabbAmine/zeavim.vim'
Plug 'Konfekt/FastFold'
Plug 'kshenoy/vim-signature'
Plug 'Lokaltog/vim-easymotion'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdtree'
Plug 'SirVer/ultisnips'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
if !has('nvim')
    Plug 'tpope/vim-sensible'
endif
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'Valloric/ListToggle'
if b:use_ycm
    Plug 'Valloric/YouCompleteMe'
elseif b:use_deoplete
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Shougo/echodoc.vim'
    " Plug 'ervandew/supertab'
    " Plug 'zchee/deoplete-clang'
    " Plug 'tweekmonster/deoplete-clang2'
    Plug 'Rip-Rip/clang_complete'
    Plug 'Shougo/neco-vim'
endif
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Language-specific plugins.
" Plug 'bfredl/nvim-ipy'    " ipython

Plug 'JuliaEditorSupport/julia-vim'
let g:default_julia_version = '0.6'

Plug 'lervag/vimtex'
Plug 'poppyschmo/vim-latexrefman'
Plug 'chriskempson/base16-vim'
Plug 'dag/vim-fish'
Plug 'jvirtanen/vim-octave'
Plug 'keith/tmux.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-after'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'Vimjas/vim-python-pep8-indent'

Plug 'hail2u/vim-css3-syntax'
" Plug 'skammer/vim-css-color'

" Colourschemes.
Plug 'nanotech/jellybeans.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'Wutzara/vim-materialtheme'
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-solarized8'
Plug 'iCyMind/NeoSolarized'
Plug 'joshdick/onedark.vim'
Plug 'mhartington/oceanic-next'

if &termguicolors
    " Load patched solarized.
    Plug 'frankier/neovim-colors-solarized-truecolor-only'
else
    Plug 'altercation/vim-colors-solarized'
end

call plug#end()

" ========================================================================== "
" THEME / APPEARANCE

if $VIM_BACKGROUND ==# 'light'
    set background=light
else
    set background=dark
end
colorscheme NeoSolarized

" let g:onedark_terminal_italics = 0
" colorscheme onedark

if has('nvim')
    set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
                \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
                \,sm:block-blinkwait175-blinkoff150-blinkon175
end

" Fix solarized8 / NeoSolarized colour schemes in vim + tmux (see README.md of
" NeoSolarized)
if !has('nvim')
    set t_8f=[38;2;%lu;%lu;%lum
    set t_8b=[48;2;%lu;%lu;%lum
    " let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    " let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
end

set laststatus=2
set statusline+=%{gutentags#statusline()}

" Airline + gutentags integration.
" Show "TAGS" in the status line while gutentags is generating tags.
function! GutentagsStatus(...)
    let w:airline_section_a = '%{gutentags#statusline()}'
endfunction
call airline#add_statusline_func('GutentagsStatus')

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " show tab number
" let g:airline_symbols_ascii = 1  " unicode symbols look weird...
let g:airline#extensions#vimtex#enabled = 0  " doesn't work!

" Height of the command bar
set cmdheight=2

" Numbers.
set number
set relativenumber

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
let g:rust_conceal_pub = 0
let g:rust_fold = 1
let g:rustfmt_autosave = 1
let g:ftplugin_rust_source_path = $RUST_SRC_PATH

" ========================================================================== "
" PLUGINS
let g:NERDTreeQuitOnOpen=1

let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_rust_checkers = ['rustc']

" Run Neomake when writing a file.
" autocmd! BufWritePost * Neomake

if b:use_deoplete
    let g:deoplete#enable_at_startup = 1

    " deoplete-clang & deoplete-clang2
    let g:deoplete#sources#clang#libclang_path = '/usr/lib64/libclang.so'
    let g:deoplete#sources#clang#clang_header = '/usr/include/clang'
    let g:deoplete#sources#clang#executable = '/usr/bin/clang'

    " clang_complete
    let g:clang_library_path = '/usr/lib64'

                " \ 'cpp': ['~/opt/clang/bin/clangd'],
    let g:LanguageClient_serverCommands = {
                \ 'julia': ['julia', '--startup-file=no', '--history-file=no', '-e', '
                \       using LanguageServer;
                \       server = LanguageServer.LanguageServerInstance(STDIN, STDOUT, false);
                \       server.runlinter = true;
                \       run(server);
                \   '],
                \ 'python': ['~/opt/miniconda3/envs/py3/bin/pyls'],
    \ }
    " Automatically start language servers.
    let g:LanguageClient_autoStart = 1

    " Deoplete + vimtex
    if !exists('g:deoplete#omni#input_patterns')
        let g:deoplete#omni#input_patterns = {}
    endif
    let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete

    nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
    nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
    nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

    " https://github.com/ervandew/supertab#frequently-asked-questions
    " let g:SuperTabDefaultCompletionType = '<c-n>'
    inoremap <silent><expr><tab> pumvisible() ? "\<C-n>" : "\<tab>"
    inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
endif



" LaTeX: disable proselint (it's nice, but uses a lot of CPU)
if b:use_ycm
    " Disable ALE for C and C++ (conflicts with YCM).
    let g:ale_linters = {
                \   'c': [],
                \   'cpp': [],
                \   'python': ['flake8', 'mypy'],
                \   'tex': ['chktex', 'lacheck'],
                \}
else
    " Right now cppcheck and clangcheck are the only linters that detect
    " compile_commands.json files.
    " TODO add cppcheck for c and cpp
    " Disable ALE for python (use python-language-server instead).
    let g:ale_linters = {
                \   'c': ['clangcheck'],
                \   'cpp': ['clangcheck'],
                \   'python': [],
                \   'tex': ['chktex', 'lacheck'],
                \}
endif
let g:ale_linter_aliases = {'pandoc': 'markdown'}
let g:ale_python_mypy_options = '--ignore-missing-imports'

let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsSnippetsDir = '~/.config/nvim/UltiSnips'

" Alternative triggers that work in gvim/vim.
inoremap <c-cr> <c-r>=UltiSnips#ExpandSnippet()<cr>
inoremap <c-\>  <c-r>=UltiSnips#ExpandSnippet()<cr>

if b:use_ycm
    " let g:ycm_collect_identifiers_from_tags_files = 1
    let g:ycm_seed_identifiers_with_syntax = 1
    " let g:ycm_global_ycm_extra_conf = '~/.nvim/ycm_extra_conf.default.py'
    let g:ycm_filepath_completion_use_working_dir = 1
    let g:ycm_max_diagnostics_to_display = 300
    let g:ycm_python_binary_path = 'python3'
    let g:ycm_rust_src_path = $RUST_SRC_PATH
    " let g:ycm_log_level = 'debug'
endif

let g:surround_indent = 1

" CtrlP: ignore files in .gitignore.
" From https://github.com/kien/ctrlp.vim/issues/174#issuecomment-49747252
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Gutentags -- write tags files to this folder:
let g:gutentags_cache_dir = '/tmp/gutentags'
" Don't generate tags for project documentation (e.g. doxygen-generated files)
" and some CMake-generated files.
let g:gutentags_ctags_exclude = ['doc', 'CMakeFiles']

" vim-pandoc-after plugin (integrates vim-pandoc with other plugins)
let g:pandoc#after#modules#enabled = ['ultisnips']
" let g:pandoc#formatting#mode = 'ha'  " hard wraps, autoformatting
let g:pandoc#formatting#mode = 'sa'
" (default = 1) don't use italics, they don't work for me in neovim
let g:pandoc#syntax#style#emphases = 0
let g:pandoc#command#latex_engine = 'lualatex'

" Remove trailing whitespace from Pandoc markdown files (which are generated
" by autoformatting).
augroup PANDOC_TRAILING
    autocmd BufWritePre *.md :%s/\s\+$//e
augroup END

" Disable gitgutter mappings. Some conflict with vimtex (for example "ic",
" "ac" for LaTeX commands).
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0

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

" YouCompleteMe
if b:use_ycm
    nnoremap <leader>jJ :YcmCompleter GoTo<CR>
    nnoremap <leader>jj :YcmCompleter GoToImprecise<CR>
    nnoremap <leader>j? :YcmCompleter GetDoc<CR>
    nnoremap <leader>jD :YcmCompleter GoToDefinition<CR>
    nnoremap <leader>jd :YcmCompleter GoToDeclaration<CR>
    nnoremap <leader>jf :YcmCompleter FixIt<CR>
endif

" Fugitive
nmap <leader>gg :Gstatus<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gw :Gwrite<CR>
nmap <leader>ge :Gedit<CR>

" Solarized8: toggle between dark and light variants (taken from their README.md)
nnoremap  <leader>B :<c-u>exe "colors" (g:colors_name =~# "dark"
    \ ? substitute(g:colors_name, 'dark', 'light', '')
    \ : substitute(g:colors_name, 'light', 'dark', '')
    \ )<cr>

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

" Terminal mappings (see ":h nvim-terminal-emulator-input").
" if has('nvim')
"     tnoremap <M-h> <C-\><C-n><C-w>h     " move to left window
"     tnoremap <M-j> <C-\><C-n><C-w>j     " etc...
"     tnoremap <M-k> <C-\><C-n><C-w>k
"     tnoremap <M-l> <C-\><C-n><C-w>l

"     " NOTE: using just one <Esc> conflicts with the terminal vi-mode.
"     tnoremap <Esc><Esc> <C-\><C-n>      " exit terminal mode
" end

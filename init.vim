filetype indent plugin on
set encoding=utf-8

if has('nvim')
    " Use true colours in terminal.
    set termguicolors   " neovim >= 0.1.5
end

" ========================================================================== "
" PLUGINS
call plug#begin('~/.config/nvim/plugged')

" Plug 'ctrlpvim/ctrlp.vim'
" Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'benekastah/neomake'
Plug 'christoomey/vim-tmux-navigator'
Plug 'honza/vim-snippets'
Plug 'junegunn/vim-easy-align'
Plug 'KabbAmine/zeavim.vim'
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
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'Valloric/ListToggle'
Plug 'Valloric/YouCompleteMe'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Language-specific plugins.
" Plug 'bfredl/nvim-ipy'    " ipython
Plug 'JuliaLang/julia-vim'
" Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'lervag/vimtex'
Plug 'chriskempson/base16-vim'
Plug 'dag/vim-fish'
Plug 'jvirtanen/vim-octave'
Plug 'keith/tmux.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-after'
Plug 'vim-pandoc/vim-pandoc-syntax'

Plug 'hail2u/vim-css3-syntax'
" Plug 'skammer/vim-css-color'

" Colourschemes.
Plug 'nanotech/jellybeans.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'Wutzara/vim-materialtheme'
Plug 'morhetz/gruvbox'

if has('nvim') && &termguicolors
    " Load patched solarized.
    Plug 'frankier/neovim-colors-solarized-truecolor-only'
else
    Plug 'altercation/vim-colors-solarized'
end

call plug#end()

" ========================================================================== "
" THEME / APPEARANCE

let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
set background=dark

if $TERM_COLOURSCHEME == 'gruvbox'
    let g:gruvbox_italic = 1
    colorscheme gruvbox
    let g:airline_theme = 'gruvbox'
else
    colorscheme solarized
    let g:airline_theme = 'solarized'
end

" let g:airline_powerline_fonts = 0
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#tab_nr_type = 1 " show tab number

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
let mapleader = ","
let maplocalleader = "\\"
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
set nowrap
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
let g:netrw_browsex_viewer = "xdg-open"

" ========================================================================== "
" LaTeX
let g:tex_flavor = 'latex'

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

" ========================================================================== "
" PLUGINS
let NERDTreeQuitOnOpen=1

let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_always_populate_loc_list = 1

" Run Neomake when writing a file.
autocmd! BufWritePost * Neomake

let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsExpandTrigger = '<a-cr>'     " alt-enter

" This fixes autocompletion of snippets with YCM.
" https://github.com/Valloric/YouCompleteMe/issues/1214#issuecomment-77366433
" let g:UltiSnipsUsePythonVersion = 3

" Alternative triggers that work in gvim/vim.
inoremap <c-cr> <c-r>=UltiSnips#ExpandSnippet()<cr>
inoremap <c-\>  <c-r>=UltiSnips#ExpandSnippet()<cr>

let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
" let g:ycm_global_ycm_extra_conf = '~/.nvim/ycm_extra_conf.default.py'
let g:ycm_filepath_completion_use_working_dir = 1
let g:ycm_max_diagnostics_to_display = 300

let g:surround_indent = 1

" CtrlP: ignore files in .gitignore.
" From https://github.com/kien/ctrlp.vim/issues/174#issuecomment-49747252
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Gutentags -- write tags files to this folder:
let g:gutentags_cache_dir = '~/.cache/gutentags'

" vim-pandoc-after plugin (integrates vim-pandoc with other plugins)
let g:pandoc#after#modules#enabled = ["ultisnips"]
let g:pandoc#formatting#mode = "ha"  " hard wraps, autoformatting
" (default = 1) don't use italics, they don't work for me in neovim
let g:pandoc#syntax#style#emphases = 0

" Remove trailing whitespace from Pandoc markdown files (which are generated
" by autoformatting).
autocmd BufWritePre *.md :%s/\s\+$//e


" Disable gitgutter mappings. Some conflict with vimtex (for example "ic",
" "ac" for LaTeX commands).
let g:gitgutter_map_keys = 0

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

nnoremap <silent> <F9> :TagbarToggle<CR>
nnoremap <leader>n :NERDTreeToggle<cr>

" CtrlP
" nnoremap <leader>b :CtrlPBuffer<cr>
" nnoremap <leader>m :CtrlPMRU<cr>
" nnoremap <leader>T :CtrlPTag<cr>
" nnoremap <leader>t :CtrlPBufTagAll<cr>
" nnoremap <leader>u :CtrlPUndo<cr>
" nnoremap <leader>M :CtrlPMixed<cr>
" nnoremap <leader>L :CtrlPLine<cr>     " <leader>l is used by ListToggle?
" nnoremap <leader>D :CtrlPDir<cr>      " <leader>d is used by YCM

" FZF (instead of CtrlP)
nnoremap <c-p> :FZF<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>T :Tags<cr>
nnoremap <leader>t :BTags<cr>
nnoremap <leader>L :Lines<cr>     " <leader>l is used by ListToggle?

" YouCompleteMe
nnoremap <leader>jJ :YcmCompleter GoTo<CR>
nnoremap <leader>jj :YcmCompleter GoToImprecise<CR>
nnoremap <leader>j? :YcmCompleter GetDoc<CR>
nnoremap <leader>jD :YcmCompleter GoToDefinition<CR>
nnoremap <leader>jd :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>jf :YcmCompleter FixIt<CR>

" Fugitive
nmap <leader>gg :Gstatus<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gw :Gwrite<CR>
nmap <leader>ge :Gedit<CR>

" This fixes comment indenting in Python (see ":h smartindent").
inoremap # X#

" DelimitMate: use <c-l> to jump over a delimiter
imap <c-l> <Plug>delimitMateS-Tab

" easy-align
" Mappings copied from ":h easy-align-4"
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

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

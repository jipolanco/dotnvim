"" PLUGINS {{{
" Using https://github.com/junegunn/vim-plug
call plug#begin(stdpath('data') . '/plugged')

" Editing
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'

" Snippets
" Plug 'honza/vim-snippets'
Plug 'rafamadriz/friendly-snippets'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Mappings
Plug 'Valloric/ListToggle'
Plug 'tpope/vim-unimpaired'

" Theming
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Colourschemes
Plug 'overcache/NeoSolarized'

" Completion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'GoldsteinE/compe-latex-symbols'

" Languages
Plug 'JuliaEditorSupport/julia-vim'
Plug 'lervag/vimtex'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-after'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'cespare/vim-toml'
Plug 'dag/vim-fish'

" Tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'jpalardy/vim-slime'

" Others
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'kshenoy/vim-signature'

call plug#end()

" }}}

"" OPTIONS {{{
set termguicolors
set number
set relativenumber
set lazyredraw  " don't redraw during macros
set cmdheight=2
set showcmd
set showmatch
set linebreak
set hidden
set splitright
set mouse=a
set mousemodel=popup_setpos
set wrap

set formatoptions+=r  " continue comment after hitting <Enter>
set formatoptions+=n  " recognise numbered lists

" Searching
set ignorecase
set smartcase
set hlsearch

" Indenting, etc.
set expandtab
set shiftwidth=4
set tabstop=8
set smartindent
set textwidth=80

" Completion
set completeopt=menuone,noselect  " for nvim-compe
set shortmess+=c

" Appearance
colorscheme NeoSolarized
let g:airline_theme = "solarized"
let g:airline_powerline_fonts = 1

let g:mapleader = "\<Space>"
let g:maplocalleader = '\'

" }}}

"" AUTOCOMMANDS {{{

" Jump to last position when reopening a file
autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \ exe "normal! g'\"" |
            \ endif

" }}}

"" NETRW {{{

let g:netrw_browsex_viewer = "xdg-open"

" }}}

"" LANGUAGE PLUGINS {{{

" Julia
let g:latex_to_unicode_tab = "command"
let g:latex_to_unicode_auto = 1
let g:latex_to_unicode_file_types = '.*'
let g:latex_to_unicode_file_types_blacklist = 'tex'

let g:julia_indent_align_brackets = 0
let g:julia_indent_align_funcargs = 0

highlight link juliaParDelim Delimiter
highlight link juliaSemicolon Operator
highlight link juliaFunctionCall Identifier

" LaTeX - VimTeX

let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'

" }}}

"" VIM-VSNIP {{{

let g:vsnip_snippet_dir = stdpath("config") . "/vsnip"

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" }}}

"" VIM-SLIME {{{
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
let g:slime_paste_file = tempname()
" }}}

"" COMPE-NVIM {{{

lua << EOF
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    -- Other sources
    latex_symbols = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' })
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

highlight link CompeDocumentation NormalFloat

" }}}

"" DELIMITMATE {{{

imap <c-l> <Plug>delimitMateS-Tab

" }}}

"" FUGITIVE {{{

nnoremap <leader>gg :Git<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gd :Gdiffsplit<cr>

" }}}

"" NVIM_LSPCONFIG {{{

lua << EOF
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>F", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>F", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
-- local servers = { "pyright", "rust_analyzer", "tsserver" }
local servers = { "julials", "bashls", "texlab", "fortls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

nvim_lsp.julials.setup = {
  on_attach = on_attach,
  settings = {
    julia = {
      NumThreads = 1,
      lint = {
        call = false,
        constif = false,
        datadecl = true,
        iter = true,
        missingrefs = "none"
      }
    }
  }
}

nvim_lsp.texlab.setup = {
  on_attach = on_attach,
  settings = {
    latex = {
      build = {
        executable = "latexmk",
        onSave = false
      },
      forwardSearch = {
        executable = "okular",
        args = {"--unique", "file:%p#src:%l%f"},
        onSave = false
      },
      lint = {
        onChange = false,
        onSave = true
      }
    }
  }
}

EOF

" }}}

"" FZF {{{

nnoremap <leader>b :Buffers<cr>
nnoremap <leader>f :Files %:p:h<cr>
nnoremap <leader>t :Tags<cr>
nnoremap <leader>T :BTags<cr>
nnoremap <leader>gf :GFiles<cr>
nnoremap <leader>: :History:<cr>
nnoremap <leader>/ :History/<cr>
nnoremap <leader>t :BTags<cr>
nnoremap <leader>T :Tags<cr>

" }}}

"" OTHER MAPPINGS {{{

" `Y` yanks from cursor to end of line
noremap Y y$

" Use <leader>h to clear the highlighting of :set hlsearch.
" Copied from vim-sensible plugin, which uses <C-L>, but this mapping conflicts
" with vim-tmux-navigator.
nnoremap <silent> <leader>h :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><leader>h

nnoremap <silent> <leader>cd :cd %:p:h<cr>

" nnoremap <expr> j v:count ? 'j' : 'gj'
" nnoremap <expr> k v:count ? 'k' : 'gk'

" }}}

"" PLUGINS {{{

" Loads lua/plugins.lua
lua require('plugins')

" }}}

"" UltiSnips {{{

let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsListSnippets = "<c-u>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"

" }}}

"" OPTIONS {{{

set shell=/bin/bash
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
set completeopt=menu,menuone,noselect  " for nvim-cmp
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
let g:vimtex_compiler_progname = 'nvr'

let g:vimtex_quickfix_open_on_warning = 0

let g:vimtex_fold_manual = 1

" let g:vimtex_matchparen_enabled = 0
" let g:matchup_override_vimtex = 1
" let g:matchup_matchparen_deferred = 1

" }}}

"" VIM-SLIME {{{
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
let g:slime_paste_file = tempname()
let g:slime_bracketed_paste = 1

" To be combined with b:slime_cell_delimiter in ftplugin/*.vim
nmap <c-c>c <Plug>SlimeSendCell
" }}}

"" CMP-NVIM {{{

lua << EOF

-- Adapted from https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion#coq_nvim

-- Setup lspconfig.
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { "julials", "bashls", "texlab", "fortls" }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        -- on_attach = my_custom_on_attach,
        capabilities = capabilities
    }
end

-- luasnip setup
-- local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'

cmp.setup {
    snippet = {
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false, -- false => must explicitly select item in menu
        }),
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
        }, {
        { name = 'buffer' },
        { name = 'path' },
        -- { name = 'latex_symbols' },
    }),
    formatting = {
        format = require("lspkind").cmp_format({with_text = true, maxwidth = 50,
            menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                -- latex_symbols = "[Latex]",
            })
        }),
    },
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
        }
    })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
    { name = 'path' }
    }, {
    { name = 'cmdline' }
    })
})

EOF

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

nvim_lsp.julials.setup {
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

nvim_lsp.texlab.setup {
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

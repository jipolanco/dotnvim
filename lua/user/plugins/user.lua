return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  -- "EdenEast/nightfox.nvim",

  {
    "khaveesh/vim-fish-syntax",
    ft = "fish",  -- only gets loaded when a fish file is opened
  },

  {
    "vim-pandoc/vim-pandoc",
    ft = {"markdown", "pandoc"},
  },

  {
    "vim-pandoc/vim-pandoc-syntax",
    ft = {"markdown", "pandoc"},
  },

  {
    "JuliaEditorSupport/julia-vim",
    lazy = false,  -- always enable, to be able to use latex-to-unicode in non-Julia files
    config = function()
      vim.g.latex_to_unicode_tab = "command"
      vim.g.latex_to_unicode_auto = 1
      vim.g.latex_to_unicode_file_types = '.*'
      vim.g.latex_to_unicode_file_types_blacklist = 'tex'
      vim.g.julia_indent_align_brackets = 0
      vim.g.julia_indent_align_funcargs = 0
    end,
  },

  {
    "lervag/vimtex",
    ft = "tex",
    config = function()
      vim.g.vimtex_view_method = "general"
      vim.g.vimtex_view_general_viewer = "okular"
      vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
      vim.g.vimtex_quickfix_open_on_warning = 0
      vim.g.vimtex_fold_manual = 1
    end,
  },

  {
    "jpalardy/vim-slime",
    lazy = false,
    config = function()
      vim.g.slime_target = "tmux"
      vim.g.slime_default_config = { socket_name = "default", target_pane = "{last}" }
      vim.g.slime_paste_file = vim.call("tempname")
      vim.g.slime_bracketed_paste = 1
    end,
  },

  {
    "kylechui/nvim-surround",
    lazy = false,
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },

  -- {
  --   "TimUntersberger/neogit",
  --   requires = {
  --     "nvim-lua/plenary.nvim",
  --     "sindrets/diffview.nvim",
  --   },
  --   config = function()
  --     require("neogit").setup { 
  --       integrations = {
  --         diffview = true,
  --       },
  --     }
  --   end,
  -- },
}

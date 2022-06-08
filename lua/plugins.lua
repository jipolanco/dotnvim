-- https://github.com/wbthomason/packer.nvim#quickstart
--
-- packer.nvim installation:
--
--   git clone --depth 1 https://github.com/wbthomason/packer.nvim \
--       ~/.local/share/nvim/site/pack/packer/start/packer.nvim
--
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

-- Bootstraping (from README.md)
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local use = require('packer').use

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Editing
  use 'easymotion/vim-easymotion'
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'Raimondi/delimitMate'
  use 'junegunn/vim-easy-align'
  -- use 'andymass/vim-matchup'

  -- Snippets
  use 'honza/vim-snippets'
  use 'SirVer/ultisnips'

  -- Git
  use 'airblade/vim-gitgutter'
  use 'tpope/vim-fugitive'

  -- Mappings
  use 'Valloric/ListToggle'
  use 'tpope/vim-unimpaired'

  -- Theming
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'

  -- Colourschemes
  use 'overcache/NeoSolarized'

  -- Completion
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  -- use 'GoldsteinE/compe-latex-symbols'
  use 'quangnguyen30192/cmp-nvim-ultisnips'
  use 'onsails/lspkind-nvim'

  -- Languages
  use 'JuliaEditorSupport/julia-vim'
  use 'lervag/vimtex'
  use 'vim-pandoc/vim-pandoc'
  use 'vim-pandoc/vim-pandoc-after'
  use 'vim-pandoc/vim-pandoc-syntax'
  use 'quarto-dev/quarto-vim'
  use 'cespare/vim-toml'
  use 'dag/vim-fish'

  -- Tmux
  use 'christoomey/vim-tmux-navigator'
  use 'jpalardy/vim-slime'

  -- Others
  use { 'junegunn/fzf', run = function() vim.fn['fzf#install()']() end }
  use 'junegunn/fzf.vim'
  use 'kshenoy/vim-signature'
end)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    "nvim-telescope/telescope.nvim",
    -- "folke/tokyonight.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/playground",
    "theprimeagen/harpoon",
    "nvim-lua/plenary.nvim",
    "williamboman/mason.nvim",
    "mbbill/undotree",
    "tpope/vim-fugitive",
    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {'L3MON4D3/LuaSnip'},
    {
        "scottmckendry/cyberdream.nvim", 
        lazy = false, 
        priority = 1000  
    },
    "nvim-lua/plenary.nvim",
    "j-hui/fidget.nvim"
}

require("lazy").setup(plugins, opts)

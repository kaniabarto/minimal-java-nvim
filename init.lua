-- Bootstrap plugin manager (lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

-- Install required plugins
require("lazy").setup({
    {
        'williamboman/mason.nvim',
    },
    {
        'mfussenegger/nvim-jdtls',
        dependencies = 'hrsh7th/cmp-nvim-lsp',
    },
    {
        'hrsh7th/nvim-cmp',
        version = false,
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
        },
    },
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            'antoinemadec/FixCursorHold.nvim',
            'rcasia/neotest-java',
        },
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = 'mfussenegger/nvim-dap',
    },
})

require'mason'.setup()
require'cmp'.setup({
    snippet = {
        expand = function(args)
            require'luasnip'.lsp_expand(args.body)
        end
    },
    mapping = {
        ['<C-c>'] = require'cmp'.mapping.abort(),
        ['<CR>'] = require'cmp'.mapping.confirm(),
        ['<C-n>'] = require'cmp'.mapping.select_next_item(),
        ['<C-p>'] = require'cmp'.mapping.select_prev_item(),
    },
    sources = {
        {
            name = 'nvim_lsp',
        },
    },
})
require'neotest'.setup({
    adapters = {
        require'neotest-java',
    },
})

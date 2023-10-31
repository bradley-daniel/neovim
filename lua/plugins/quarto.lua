return {
    'quarto-dev/quarto-nvim',
    dependencies = {
        'jmbuhr/otter.nvim',
        'hrsh7th/nvim-cmp',
        'neovim/nvim-lspconfig',
        'nvim-treesitter/nvim-treesitter'
    },
    ft = { "quarto", "markdown" },
    config = function()
        local opts = {
            debug = false,
            closePreviewOnExit = true,
            lspFeatures = {
                enabled = true,
                languages = { 'r', 'python', 'julia', 'bash' },
                chunks = 'curly', -- 'curly' or 'all'
                diagnostics = {
                    enabled = true,
                    triggers = { "BufWritePost" }
                },
                completion = {
                    enabled = true,
                },
            },
            keymap = {
                hover = 'K',
                definition = 'gd',
                rename = '<leader>lR',
                references = 'gr',
            }
        }
        require('quarto').setup(opts)
    end,

}

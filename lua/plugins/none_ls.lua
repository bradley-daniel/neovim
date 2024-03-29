return {
    "nvimtools/none-ls.nvim",
    -- event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    config = function()
        local null_ls = require('null-ls')
        require('null-ls').setup({
            sources = {
                -- null_ls.builtins.formatting.black,
                -- null_ls.builtins.diagnostics.flake8,

                -- null_ls.builtins.diagnostics.ruff,
            },
        })
    end,
}

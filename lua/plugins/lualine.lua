return {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
    -- See `:help lualine.txt`
    -- dependencies = {
    --     'catppuccin/nvim',
    -- },
    opts = {
        options = {
            globalstatus = true,
            icons_enabled = false,
            -- theme = "base16";
            -- theme = 'catppuccin',
            component_separators = '|',
            section_separators = '',
        },
    },
}

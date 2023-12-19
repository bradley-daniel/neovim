return {
    {
        "catppuccin/nvim",
        enabled = true,
        priority = 1000,
        lazy = false,
        config = function()
            local opts = {
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                term_color = true,
                color_overrides = {
                    mocha = {
                        base = "#14191e",
                        mantle = "#14191e",
                        crust = "#bac2de",
                    },
                },
                custom_highlights = function(colors)
                    return {
                        ['@function.builtin'] = { fg = colors.blue },
                    }
                end,
                -- higlight_overrides = {
                --     all = function(colors)
                --         return {
                --             Comment = { fg = "#000000" },
                --         }
                --     end,
                -- },
                --     transparent_background = true,
                --     custom_highlights = function(colors)
                --         local u = require("catppuccin.utils.colors")
                --         return {
                --             CursorLine = {
                --                 bg = u.vary_color(
                --                     {
                --                         latte = u.lighten(colors.mantle, 0.70, colors.base)
                --                     },
                --                     u.darken(colors.surface0, 0.64, colors.base)
                --                 ),
                --             },
                --         }
                --     end,
            }
            require('catppuccin').setup(opts)
            vim.cmd [[ colorscheme catppuccin ]]
            -- vim.cmd [[ colorscheme kanagawa ]]
        end,
    },
    {
        "rebelot/kanagawa.nvim"
    }
}

return {
    "lukas-reineke/indent-blankline.nvim",
    version = "2.x.x",
    event = "BufReadPre",
    opts = {
        buftype_exclude = { "terminal", "nofile" },
        filetype_exclude = {
            "help",
            "startify",
            "dashboard",
            "lazy",
            "neogitstatus",
            "NvimTree",
            "Trouble",
            "text",
        },
        indent = {
            higlight = {
                "CursorColumn",
                "Whitespace",
            },
            char = "│",
        },
        whitespace = {
            higlight = {
                "CursorColumn",
                "Whitespace",
            },
            show_trailing_blankline_indent = false,
            use_treesitter = true,
        },
        mappings = {
            ["o"] = "Toggle",
        },
        scope = { enable = true },

        -- char = "│",
        -- context_char = "│",
        -- show_trailing_blankline_indent = false,
        -- show_first_indent_level = true,
        -- show_current_context = true,
    },
}

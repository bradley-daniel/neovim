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
        char = "│",
        context_char = "│",
        show_trailing_blankline_indent = false,
        show_first_indent_level = true,
        use_treesitter = true,
        show_current_context = true,
    },
}

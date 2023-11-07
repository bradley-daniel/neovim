return {
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    'ThePrimeagen/harpoon',
    event = { "VeryLazy" },
    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        vim.keymap.set("n", "<leader>m", mark.add_file, { desc = "Harpoon mark" })
        vim.keymap.set("n", "<leader>he", ui.toggle_quick_menu, { desc = "Harpoon Menu"})

        vim.keymap.set("n", "ma", function() ui.nav_file(1) end, { desc = "Harpoon nav_file 1" })
        vim.keymap.set("n", "ms", function() ui.nav_file(2) end, { desc = "Harpoon nav_file 2" })
        vim.keymap.set("n", "md", function() ui.nav_file(3) end, { desc = "Harpoon nav_file 3" })
        vim.keymap.set("n", "mf", function() ui.nav_file(4) end, { desc = "Harpoon nav_file 4" })
    end,

}

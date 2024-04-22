return {
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    'ThePrimeagen/harpoon',
    event = { "VeryLazy" },
    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")


        -- vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
        -- vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
        --
        -- vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
        -- vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
        -- vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
        -- vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

        vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon mark" })
        vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Harpoon Menu"})
        --
        vim.keymap.set("n", "<C-a>", function() ui.nav_file(1) end, { desc = "Harpoon nav_file 1" })
        vim.keymap.set("n", "<C-s>", function() ui.nav_file(2) end, { desc = "Harpoon nav_file 2" })
        vim.keymap.set("n", "<C-d>", function() ui.nav_file(3) end, { desc = "Harpoon nav_file 3" })
        vim.keymap.set("n", "<C-f>", function() ui.nav_file(4) end, { desc = "Harpoon nav_file 4" })
    end,

}

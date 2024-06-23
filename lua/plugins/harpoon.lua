return {
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	event = { "VeryLazy" },
	config = function()
		local harpoon = require("harpoon.list")

		local harpoon = require("harpoon"):setup({})

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end)
		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		vim.keymap.set("n", "<C-S-P>", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<C-S-N>", function()
			harpoon:list():next()
		end)

		for i=1, 5 do
			local keymap = string.format("<leader>%d", i)
            -- print(keymap)
			vim.keymap.set("n", keymap, function()
				harpoon:list():select(i)
			end)
		end
	end,
}

return {
	"utilyre/barbecue.nvim",
	event = { "VeryLazy" },
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons", -- optional dependency
	},
	config = function()
		require("barbecue").setup({})
		require("barbecue.ui").toggle(true)
	end,
}

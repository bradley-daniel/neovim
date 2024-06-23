return {
	"numToStr/Comment.nvim",
	config = function()
		require("Comment").setup()

		-- Comment code
		vim.keymap.set(
			{ "n" },
			"<leader>/",
			"<plug>(comment_toggle_linewise_current)",
			{ desc = "[/] comment current line" }
		)
		vim.keymap.set(
			{ "x", "v" },
			"<leader>/",
			"<plug>(comment_toggle_linewise_visual)",
			{ desc = "[/] comment current line" }
		)
	end,
}

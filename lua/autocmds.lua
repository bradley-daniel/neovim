-- Command to show command line when recording macros
vim.api.nvim_create_autocmd({ "RecordingEnter", "CmdlineEnter" }, {
	callback = function()
		vim.opt.cmdheight = 1
	end,
})

vim.api.nvim_create_autocmd({ "RecordingLeave", "CmdlineLeave" }, {
	callback = function()
		vim.opt.cmdheight = 0
	end,
})

-- Show higlighting when yanking
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	group = highlight_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_user_command("Wrap", function()
	pcall(function()
		vim.opt.wrap = true
		vim.opt.linebreak = true
	end)
end, {})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "<space>lr", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "lf", require("conform").format, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set({ "n", "v" }, "<space>la", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>i", function()
			vim.diagnostic.open_float(nil, { border = "rounded", focus = false, scope = "line" })
		end, { desc = "[i] nfo Diagnostics" })
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.py" },
	callback = function()
		require("lint").try_lint()
	end,
})

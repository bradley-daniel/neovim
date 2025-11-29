return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				nix = { "alejandra" },
				rust = { "rustfmt" },
				quarto = { "prettier" },
				python = { "ruff_format" },
				markdown = { "prettierd", "prettier" },
				javascript = { "prettierd", "prettier" },
				typescript = { "prettierd", "prettier" },
				html = { "prettierd", "prettier" },
				typescriptreact = { "prettierd", "prettier" },
				json = { "prettierd", "prettier" },
				c = { "clang-format" },
			},
		})

		require("conform").formatters.prettier = {
			options = {
				ft_parsers = {
					quarto = "markdown",
				},
			},
		}
	end,
}

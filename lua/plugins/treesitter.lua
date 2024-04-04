return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
	priority = 1,
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/playground",
	},
	config = function()
		-- -@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup({
			-- Add languages to be installed here that you want installed for treesitter
			ensure_installed = {
				-- Neovim
				"vimdoc",
				"vim",
				"lua",
				-- Programing lanugages
				"c",
				"cpp",
				"rust",

				"go",
				"python",
				"typescript",
				"javascript",
                "tsx",

				"bash",
				"nix",
				--
				-- -- Other
				"html",
				"json",
				"toml",
				-- 'yaml',
				"htmldjango",
				--
				-- -- Quarto / markdown
				"markdown",
				"markdown_inline",
				--
				-- -- Graphing in quarto
				"dot",
				"mermaid",

				-- Database
				"sql",
			},

			autotag = { enable = true },

			-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
			auto_install = false,
			sync_install = false,
			ignore_install = {},
			modules = {},

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
		})
	end,
}

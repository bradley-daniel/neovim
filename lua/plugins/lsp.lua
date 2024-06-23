return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPost", "BufNewFile" },
	opts = { inlay_hints = true },
	dependencies = {
		"j-hui/fidget.nvim",
		{ "folke/neodev.nvim", opts = {} },

		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",

		{ "L3MON4D3/LuaSnip" },
		{ "rafamadriz/friendly-snippets" },
		{ "saadparwaiz1/cmp_luasnip" },
	},
	config = function()
		require("fidget").setup({})
		require("neodev").setup({})

		local lspconfig = require("lspconfig")

		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		require("luasnip.loaders.from_vscode").lazy_load()

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, cmp_lsp.default_capabilities())
		-- local capabilities = cmp_lsp.default_capabilities()

		-- servers (https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
		local servers = {
			clangd = {},
			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
						check = {
							command = "clippy",
						},
					},
				},
			},
			pyright = {},
			tsserver = {},
			html = {},
			nil_ls = {},
			cssls = {},

			lua_ls = {
				other = {},
			},
			marksman = {
				filetypes = {
					"markdown",
					"markdown.mdx",
					"quarto",
				},
			},
            gopls = {}
		}

		for lsp, config in pairs(servers) do
			local opts = {
				capabilities = capabilities,
			}
			for key, value in pairs(config) do
				opts[key] = value
			end
			lspconfig[lsp].setup(opts)
		end

		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			completion = { completeopt = "menu,menuone,noinsert" },
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
				{ name = "buffer" },
				{ name = "path" },
			}, {
				{ name = "buffer" },
			}),

			---@diagnostic disable-next-line: missing-fields
			formatting = {
				max_width = 120,
				fields = { "kind", "abbr", "menu" },
				source_names = {
					nvim_lsp = "[LSP]",
					path = "[Path]",
					cmp_tabnine = "[Tabnine]",
					vsnip = "[Snippet]",
					luasnip = "[Snippet]",
					buffer = "[Buffer]",
					treesitter = "[TreeSitter]",
				},
				format = function(_, vim_item)
					vim_item.kind = string.format("%s ", vim.icons.kind[vim_item.kind] or "?")
					vim_item.abbr = string.sub(vim_item.abbr, 0, 30)
					return vim_item
				end,
			},
			window = {
				documentation = {
					zindex = 1,
				},
			},
		})

		vim.diagnostic.config({
			-- update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		local signs = {
			Error = vim.icons.diagnostics.Error,
			Warn = vim.icons.diagnostics.Warning,
			Hint = vim.icons.diagnostics.Hint,
			Info = vim.icons.diagnostics.Information,
		}

		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end
	end,
}

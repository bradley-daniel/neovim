return {
	"neovim/nvim-lspconfig",
	event = { "VeryLazy" },
	opts = { inlay_hints = true },
	dependencies = {
		"j-hui/fidget.nvim",
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

		-- Rust Server Cancelled Error Workaround
		for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
			local default_diagnostic_handler = vim.lsp.handlers[method]
			vim.lsp.handlers[method] = function(err, result, context, config)
				if err ~= nil and err.code == -32802 then
					return
				end
				return default_diagnostic_handler(err, result, context, config)
			end
		end

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
			ts_ls = {},
			html = {},
			nil_ls = {},
			cssls = {},
			lua_ls = {},
			marksman = {
				filetypes = {
					"markdown",
					"markdown.mdx",
					"quarto",
				},
			},
			gopls = {},
		}

		for lsp, config in pairs(servers) do
			local opts = {
				capabilities = capabilities,
			}
			for key, value in pairs(config) do
				opts[key] = value
			end
			vim.lsp.config[lsp] = opts
			vim.lsp.enable(lsp)
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
				max_width = 60,
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
					if vim_item.menu ~= nil then
						vim_item.menu = string.sub(vim_item.menu, 0, 10)
					end
					return vim_item
				end,
			},
			window = {
				completion = {
					scrolloff = 10,
					scrollbar = true,
				},
				documentation = {
					max_height = 40,
					zindex = 1,
					scrollbar = true,
					scrolloff = 8,
				},
			},
		})

		local signs = {
			ERROR = vim.icons.diagnostics.Error,
			WARN = vim.icons.diagnostics.Warning,
			HINT = vim.icons.diagnostics.Hint,
			INFO = vim.icons.diagnostics.Information,
		}

		vim.diagnostic.config({
			underline = true,
			severity_sort = true,
			signs = {
				text = {
					[vim.diagnostic.severity.INFO] = signs.INFO,
					[vim.diagnostic.severity.HINT] = signs.HINT,
					[vim.diagnostic.severity.WARN] = signs.WARN,
					[vim.diagnostic.severity.ERROR] = signs.ERROR,
				},
			},
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = true,
				header = "",
				prefix = "",
			},
		})

		-- for type, icon in pairs(signs) do
		-- 	local hl = "DiagnosticSign" .. type
		-- 	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		-- end
	end,
}

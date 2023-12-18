return {
    'VonHeikemen/lsp-zero.nvim',
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    branch = 'v1.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },
        { 'j-hui/fidget.nvim',           tag = 'legacy', opts = {} },

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-nvim-lua' },
        { 'folke/neodev.nvim' },

        -- pandoc
        { 'hrsh7th/cmp-calc' },
        { 'jmbuhr/cmp-pandoc-references' },

        -- Snippets
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },
        { 'saadparwaiz1/cmp_luasnip' },


        -- Esthetic
        { 'folke/trouble.nvim' },


        -- Misc
        {
            'stevearc/conform.nvim',
        },


        -- Rust
        {
            'simrat39/rust-tools.nvim',
            ft = "rust",
            config = function()
                local opts = {
                    tools = {
                        inlay_hints = {
                            -- automatically set inlay hints (type hints)
                            -- default: true
                            auto = true,

                            -- Only show inlay hints for the current line
                            only_current_line = true,

                            -- whether to show parameter hints with the inlay hints or not
                            -- default: true
                            show_parameter_hints = true,

                            -- prefix for parameter hints
                            -- default: "<-"
                            parameter_hints_prefix = "<- ",

                            -- prefix for all the other hints (type, chaining)
                            -- default: "=>"
                            other_hints_prefix = "=> ",

                            -- whether to align to the length of the longest line in the file
                            max_len_align = false,

                            -- padding from the left if max_len_align is true
                            max_len_align_padding = 1,

                            -- whether to align to the extreme right or not
                            right_align = false,

                            -- padding from the right if right_align is true
                            right_align_padding = 7,

                            -- The color of the hints
                            highlight = "Comment",
                        },
                    }
                }
                require('rust-tools').setup(opts);
                require('rust-tools').inlay_hints.enable()
            end,
        },
        {
            'saecki/crates.nvim',
            tag = 'v0.4.0',
            dependencies = { 'nvim-lua/plenary.nvim' },
            config = function()
                require('crates').setup()
            end,
        },
    },
    config = function()
        local lsp = require 'lsp-zero'

        require('neodev').setup {}



        lsp.preset 'minimal'
        lsp.nvim_workspace()
        lsp.set_preferences {
            sign_icons = {
                error = vim.icons.diagnostics.Error,
                warn = vim.icons.diagnostics.Warning,
                hint = vim.icons.diagnostics.Hint,
                info = vim.icons.diagnostics.Information,
            },
        }
        require('lspconfig').rust_analyzer.setup({
            settings = {
                ["rust-analyzer"] = {
                    imports = {
                        granularity = {
                            group = "module",
                        },
                        prefix = "self",
                    },
                    cargo = {
                        buildScripts = {
                            enable = true,
                        },
                    },
                    procMacro = {
                        enable = true
                    },
                }
            }
        })

        -- Configure Servers
        lsp.setup_servers {
            'lua_ls',
            'rust_analyzer',
            'clangd',
            'pyright',
            'nil_ls',
            'hls',
        }
        vim.api.nvim_create_user_command("Format", function(args)
            local range = nil
            if args.count ~= -1 then
                local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                range = {
                    start = { args.line1, 0 },
                    ["end"] = { args.line2, end_line:len() },
                }
            end
            require("conform").format({ async = true, lsp_fallback = true, range = range })
        end, { range = true })

        lsp.on_attach(function(_, bufnr)
            local nmap = function(keys, func, desc)
                if desc then
                    desc = 'LSP: ' .. desc
                end
                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end

            nmap('<leader>lr', vim.lsp.buf.rename, '[r]rename')
            nmap('<leader>la', vim.lsp.buf.code_action, '[C]ode [A]ction')
            -- nmap("<leader>lf", vim.lsp.buf.format, '[F]ormat')
            nmap("<leader>lf", "<cmd>Format<cr>", '[F]ormat')
            -- nmap("<leader>la", vim.lsp.buf.code_action, '[C]ode Action')

            nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
            nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
            nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
            nmap('<leader>lD', vim.lsp.buf.type_definition, 'Type [D]efinition')
            nmap('<leader>ld', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
            nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

            -- See `:help K` for why this keymap
            nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
            nmap('<C-P>', vim.lsp.buf.signature_help, 'Signature Documentation')

            -- Lesser used LSP functionality
            nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
            vim.keymap.set('n', '<leader>i', function()
                local found_float = false
                if found_float then
                    return
                end

                vim.diagnostic.open_float(nil, { border = "rounded", focus = false, scope = 'line' })
            end, { desc = '[i] nfo Diagnostics' })
        end)

        lsp.setup()


        -- Might remove
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = '[q] Open diagnostics list' })

        local cmp = require 'cmp'
        local cmp_window = require "cmp.config.window"
        local cmp_mapping = require "cmp.config.mapping"
        local cmp_action = require('lsp-zero').cmp_action()
        local luasnip = require 'luasnip'

        require('luasnip.loaders.from_vscode').lazy_load()
        luasnip.config.setup {}


        cmp.setup {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert {
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete {},

                ['<CR>'] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            },
            formatting = {
                max_width = 120,
                fields = { 'kind', 'abbr', 'menu' },
                source_names = {
                    nvim_lsp = "[LSP]",
                    emoji = "[Emoji]",
                    path = "[Path]",
                    calc = "[Calc]",
                    cmp_tabnine = "[Tabnine]",
                    vsnip = "[Snippet]",
                    luasnip = "[Snippet]",
                    buffer = "[Buffer]",
                    tmux = "[TMUX]",
                    copilot = "[Copilot]",
                    treesitter = "[TreeSitter]",
                    latex_symbols = "[tex]",
                    pandoc_references = "[ref]",
                    ['vim-dadbod-completion'] = "[DB]",
                },
                format = function(entry, vim_item)
                    vim_item.kind = string.format("%s ", vim.icons.kind[vim_item.kind] or "?")
                    vim_item.abbr = string.sub(vim_item.abbr, 0, 50)
                    vim_item.menu = ({
                        nvim_lsp = "[LSP]",
                        emoji = "[Emoji]",
                        path = "[Path]",
                        calc = "[Calc]",
                        cmp_tabnine = "[Tabnine]",
                        vsnip = "[Snippet]",
                        luasnip = "[Snippet]",
                        buffer = "[Buffer]",
                        tmux = "[TMUX]",
                        copilot = "[Copilot]",
                        treesitter = "[TreeSitter]",
                        latex_symbols = "[tex]",
                        pandoc_references = "[ref]",
                        ['vim-dadbod-completion'] = "[DB]",
                    })[entry.source.name]
                    return vim_item
                end,
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'otter' },
                { name = 'pandoc_references' },
                { name = 'latex_symbols' },
                { name = 'vim-dadbod-completion' },
                { name = 'buffer' },
                { name = "path" },
            },
            window = {
                completion = cmp_window.bordered(),
                documentation = {
                    border = 'double',
                    zindex = 1,
                },
            },
        }

        vim.diagnostic.config {
            virtual_text = true,
        }

        require('conform').setup {
            formatters_by_ft = {
                lua = { 'stylua' },
                nix = { 'alejandra' },
                rust = { 'rustfmt' },
                markdown = { 'mdformat' },
                python = { 'ruff_format' }
            },
        }
    end,
}

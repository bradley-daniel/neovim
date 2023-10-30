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
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lua' },
        { 'onsails/lspkind.nvim' },
        { 'folke/neodev.nvim' },


        -- Snippets
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },

        -- Esthetic
        { 'folke/trouble.nvim' },

        -- Misc
        {
            'stevearc/conform.nvim',
        },

        -- Flutter
        {
            'akinsho/flutter-tools.nvim',
            lazy = false,
            dependencies = {
                'nvim-lua/plenary.nvim',
                'stevearc/dressing.nvim', -- optional for vim.ui.select
            },
            config = true,
        },

        -- Rust
        { 'simrat39/rust-tools.nvim' },
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

        lsp.preset 'recommended'
        lsp.nvim_workspace()
        lsp.set_preferences {
            sign_icons = {
                error = vim.icons.diagnostics.Error,
                warn = vim.icons.diagnostics.Warning,
                hint = vim.icons.diagnostics.Hint,
                info = vim.icons.diagnostics.Information,
            },
        }

        -- Configure Servers
        lsp.setup_servers {
            'lua_ls',
            'rust_analyzer',
            -- 'zls',
            -- 'tsserver',
            'clangd',
            -- 'tailwindcss',
            -- 'dartls',
            'pyright'
            -- 'gopls',
        }

        require('lspconfig').nil_ls.setup {
            settings = {
                ['nil'] = {
                    nix = {
                        -- maxMemoryMB = 7680,
                        flake = {
                            autoArchive = true,
                            autoEvalInputs = true,
                        },
                    },
                },
            },
        }
        lsp.on_attach(function(_, bufnr)
            local nmap = function(keys, func, desc)
                if desc then
                    desc = 'LSP: ' .. desc
                end
                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end

            nmap('<leader>lr', vim.lsp.buf.rename, '[r]rename')
            -- nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
            nmap("<leader>lf", vim.lsp.buf.format, '[F]ormat')
            nmap("<leader>la", vim.lsp.buf.code_action, '[C]ode Action')

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
        end)

        lsp.setup()

        local cmp = require 'cmp'
        local cmp_action = require('lsp-zero').cmp_action()



        vim.api.nvim_create_autocmd('BufRead', {
            group = vim.api.nvim_create_augroup('CmpSourceCargo', { clear = true }),
            pattern = 'Cargo.toml',
            callback = function()
                cmp.setup.buffer { sources = { { name = 'crates' } } }
            end,
        })

        -- local opts = { silent = true }
        -- vim.keymap.set('n', '<leader>cp', require('crates').show_popup, opts)
        --


        local luasnip = require 'luasnip'

        require('luasnip.loaders.from_vscode').lazy_load()
        luasnip.config.setup {}

        cmp.setup {
            mapping = {
                ['<Tab>'] = cmp_action.luasnip_supertab(),
                ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
            },
            window = {
                ---@diagnostic disable-next-line: undefined-field
                completion = cmp.config.window.bordered(),
                ---@diagnostic disable-next-line: undefined-field
                documentation = {
                    border = 'rounded', -- or 'double' or 'rounded' or 'none'
                    position = 'below', -- or 'above', 'below', 'right', 'left'
                },
            },
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
            formatting = {
                fields = { 'kind', 'abbr', 'menu' },
                format = function(_, vim_item)
                    vim_item.kind = vim.icons.kind[vim_item.kind] or "?"
                    vim_item.abbr = string.sub(vim_item.abbr, 0, 50)
                    return vim_item
                end,
            },
        }

        vim.opt.signcolumn = 'yes' -- Disable lsp signals shifting buffer

        vim.diagnostic.config {
            virtual_text = true,
        }

        require('conform').setup {
            formatters_by_ft = {
                lua = { 'stylua' },
                nix = { 'alejandra' },
                rust = { 'rustfmt' },
                markdown = { 'mdformat' },
                python = { 'black' }
            },
        }
    end,
}

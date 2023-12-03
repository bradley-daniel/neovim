local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' 󰁂 %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, 'MoreMsg' })
    return newVirtText
end

return {
    "kevinhwang91/nvim-ufo",
    event = { "InsertEnter" },
    dependencies = { "kevinhwang91/promise-async" },
    opts = {
        fold_virt_text_handler = handler,
        preview = {
            mappings = {
                scrollB = "<C-b>",
                scrollF = "<C-f>",
                scrollU = "<C-u>",
                scrollD = "<C-d>",
            },
        },
        provider_selector = function(_, filetype, buftype)
            local function handleFallbackException(bufnr, err, providerName)
                if type(err) == "string" and err:match "UfoFallbackException" then
                    return require("ufo").getFolds(bufnr, providerName)
                else
                    return require("promise").reject(err)
                end
            end

            return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
                or function(bufnr)
                    return require("ufo")
                        .getFolds(bufnr, "lsp")
                        :catch(function(err) return handleFallbackException(bufnr, err, "treesitter") end)
                        :catch(function(err) return handleFallbackException(bufnr, err, "indent") end)
                end
        end,
    },
    init = function()
        vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
        vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    end
}
-- use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}
--
-- vim.o.foldcolumn = '1' -- '0' is not bad
-- vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
-- vim.o.foldlevelstart = 99
-- vim.o.foldenable = true
--
-- -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
-- vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
-- vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
--
-- -- Option 1: coc.nvim as LSP client
-- use {'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile'}
-- require('ufo').setup()
-- --
--
-- -- Option 2: nvim lsp as LSP client
-- -- Tell the server the capability of foldingRange,
-- -- Neovim hasn't added foldingRange to default capabilities, users must add it manually
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.foldingRange = {
--     dynamicRegistration = false,
--     lineFoldingOnly = true
-- }
-- local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
-- for _, ls in ipairs(language_servers) do
--     require('lspconfig')[ls].setup({
--         capabilities = capabilities
--         -- you can add other fields for setting up lsp server in this table
--     })
-- end
-- require('ufo').setup()
-- --
--
-- -- Option 3: treesitter as a main provider instead
-- -- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
-- -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
-- use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
-- require('ufo').setup({
--     provider_selector = function(bufnr, filetype, buftype)
--         return {'treesitter', 'indent'}
--     end
-- })
-- --
--
-- -- Option 4: disable all providers for all buffers
-- -- Not recommend, AFAIK, the ufo's providers are the best performance in Neovim
-- require('ufo').setup({
--     provider_selector = function(bufnr, filetype, buftype)
--         return ''
--     end
-- })

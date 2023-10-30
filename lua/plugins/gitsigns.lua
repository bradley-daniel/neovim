return {
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
        -- See `:help gitsigns.txt`
        signs = {
            add = {
                hl = "GitSignsAdd",
                text = vim.icons.ui.BoldLineLeft,
                numhl = "GitSignsAddNr",
                linehl = "GitSignsAddLn",
            },
            change = {
                hl = "GitSignsChange",
                text = vim.icons.ui.BoldLineLeft,
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn",
            },
            delete = {
                hl = "GitSignsDelete",
                text = vim.icons.ui.Triangle,
                numhl = "GitSignsDeleteNr",
                linehl = "GitSignsDeleteLn",
            },
            topdelete = {
                hl = "GitSignsDelete",
                text = vim.icons.ui.Triangle,
                numhl = "GitSignsDeleteNr",
                linehl = "GitSignsDeleteLn",
            },
            changedelete = {
                hl = "GitSignsChange",
                text = vim.icons.ui.BoldLineLeft,
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn",
            },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
            interval = 1000,
            follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        status_formatter = nil, -- Use default
        update_debounce = 200,
        max_file_length = 40000,
        preview_config = {
            -- Options passed to vim_open_win
            border = "rounded",
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1,
        },
        yadm = { enable = false },
        on_attach = function(bufnr)
            vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk,
                { buffer = bufnr, desc = 'Preview git hunk' })

            -- don't override the built-in and fugitive keymaps
            local gs = package.loaded.gitsigns
            vim.keymap.set({ 'n', 'v' }, ']c', function()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
            vim.keymap.set({ 'n', 'v' }, '[c', function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
        end,
    },
}

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
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

vim.api.nvim_create_user_command('Wrap', function()
    pcall(function()
        vim.opt.wrap = true
        vim.opt.linebreak = true
    end)
end, {})

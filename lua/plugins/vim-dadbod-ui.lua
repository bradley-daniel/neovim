return {
    'kristijanhusak/vim-dadbod-ui',
    name = "dbui",
    dependencies = {
        { 'tpope/vim-dadbod',                     lazy = true },
        { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
        { "tpope/vim-dotenv" }
    },
    cmd = {
        'DBUI',
        'DBUIToggle',
        'DBUIAddConnection',
        'DBUIFindBuffer',
    },
    init = function()
        vim.g.db_ui_disable_mappings = 1

        vim.cmd [[ autocmd FileType dbui nmap <buffer>  I <Plug>(DBUI_GotoFirstSibling) ]]
        vim.cmd [[ autocmd FileType dbui nmap <buffer>  o <Plug>(DBUI_SelectLine) ]]
        vim.cmd [[ autocmd FileType dbui nmap <buffer>  H <Plug>(DBUI_ToggleDetails) ]]
        vim.cmd [[ autocmd FileType dbui nmap <buffer>  d <Plug>(DBUI_DeleteLine) ]]
        vim.cmd [[ autocmd FileType dbui nmap <buffer>  R <Plug>(DBUI_DeleteLine) ]]


        vim.api.nvim_set_hl(0, 'NotificationInfo', {
            fg = '#8aadf4',
        })
        -- vim.lsp.ha
        vim.api.nvim_set_hl(0, 'NotificationWarning', {
            fg = '#8aadf4',
        })

        vim.api.nvim_set_hl(0, 'NotificationError', {
            fg = '#8aadf4',
        })


        vim.g.db_ui_use_nerd_fonts = 1
    end,
}

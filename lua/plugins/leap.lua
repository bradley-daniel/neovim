return {
    'ggandor/leap.nvim',
    config = function()
        require('leap').add_default_mappings()

        vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' }) -- or some grey

        vim.api.nvim_set_hl(0, 'LeapMatch', {
            -- For light themes, set to 'black' or similar.
            fg = 'white',
            bold = true,
            nocombine = true,
        })

        vim.api.nvim_set_hl(0, 'LeapLabelPrimary', {
            fg = '#ee99a0', bold = true, nocombine = true,
        })

        vim.api.nvim_set_hl(0, 'LeapLabelSecondary', {
            fg = '#8aadf4', bold = true, nocombine = true,
        })

        require('leap').opts.highlight_unlabeled_phase_one_targets = true
    end,
}

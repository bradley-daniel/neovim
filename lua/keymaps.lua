vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")


vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- split windows
vim.keymap.set('n', '<leader>\"', vim.cmd.split, { desc = "split window" })
vim.keymap.set('n', '<leader>%', vim.cmd.vsplit, { desc = "split window" })

-- Copy - Paste Commands
vim.keymap.set({ "x", "v", 'n' }, "<leader>p", [["+p]], { desc = "[p]aste System Clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[y]ank system Clipboard" })


-- Void delete and paste
vim.keymap.set("x", "<leader>P", [["_dP]], { desc = "[P]aste void" })
vim.keymap.set({ "x", "n", "v" }, "<leader>d", [["_d]], { desc = "[d]elete void" })

-- Stay in place J motion
vim.keymap.set("n", "J", "mzJ`z")

-- Undo tree
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "[U]ndotree Toggle" })


-- vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', { desc = 'Nvimtree' })
vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>', { desc = 'Nvimtree' })


-- Search center
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Split manegment
vim.keymap.set('n', '<leader>wh', '<C-w>t<C-w>H', { desc = "Vertical to Horizontal" })
vim.keymap.set('n', '<leader>wk', '<C-w>t<C-w>K', { desc = "Horizontal to Vertical" })
vim.keymap.set('n', '<leader>wc', '<C-w>c', { desc = "Quit pane" })


vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +5<cr>')
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -5<cr>')
vim.keymap.set('n', '<C-Down>', '<cmd>resize +5<cr>')
vim.keymap.set('n', '<C-Up>', '<cmd>resize -5<cr>')


-- Might remove
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = '[q] Open diagnostics list' })

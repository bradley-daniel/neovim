vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- split windows
vim.keymap.set('n', '<leader>\"', vim.cmd.split, { desc = "Split Horizontal" })
vim.keymap.set('n', '<leader>%', vim.cmd.vsplit, { desc = "split Vertical" })

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

vim.keymap.set("i", "<C-c>", "<Esc>")

-- vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', { desc = 'Nvimtree' })
-- vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>', { desc = 'Nvimtree' })
vim.keymap.set('n', '<leader>e', '<cmd>Oil<cr>', { desc = 'FileExpoloer' })


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


vim.keymap.set('n', '<leader>bc', '<cmd>:bn|:bd#<cr>', {desc = "[B]uffer close"})

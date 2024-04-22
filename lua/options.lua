-- vim configs --
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.showtabline = 0

vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- vim.o.foldenable = true -- enable fold for nvim-ufo
-- vim.o.foldlevel = 99 -- set high foldlevel for nvim-ufo
-- vim.o.foldlevelstart = 99 -- start with all code unfolded
-- vim.o.foldcolumn = "0"

vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"

vim.opt.cmdheight = 0

vim.opt.cursorline = true

vim.o.confirm = true
--
-- vim.opt.pumblend = 5 -- Popup blend
vim.opt.pumheight = 15 -- Maximum number of entries in a popup
vim.opt.laststatus = 3

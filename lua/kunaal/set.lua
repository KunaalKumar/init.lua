vim.opt.guicursor=""

vim.opt.tabstop=4
vim.opt.softtabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab=true

vim.opt.hlsearch=true
vim.opt.incsearch=true

vim.opt.swapfile=false
vim.opt.backup=false
vim.opt.undodir=os.getenv("HOME").."/.vim/undodir"
vim.opt.undofile=true

vim.opt.wrap=false

vim.opt.number=true
vim.opt.relativenumber=true

vim.opt.signcolumn="yes"

vim.opt.updatetime=50

vim.g.mapleader = " "

vim.o.autoread = true

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- enable 24-bit colour
vim.opt.termguicolors = true

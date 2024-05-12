vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.guicursor=""

vim.opt.tabstop=2
vim.opt.softtabstop=2
vim.opt.shiftwidth=2
vim.opt.expandtab=true

vim.opt.hlsearch=true
vim.keymap.set("n", "<ESC>", ":nohlsearch<CR>")
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
vim.o.autoread = true

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- enable 24-bit colour
vim.opt.termguicolors = true

vim.g.have_nerd_font = 1
vim.opt.mouse = "a"
--vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"
vim.opt.cursorline = false
vim.opt.scrolloff = 10


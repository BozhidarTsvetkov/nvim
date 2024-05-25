vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({"n", "v"}, "<leader>p", [["+p]])
vim.keymap.set("n", "<leader>P", [["+P]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")


-- Remove newbie crutches in Normal, Insert and Visual Mode
vim.keymap.set({ "n", "v", "i" }, "<Down>", "<nop>")
vim.keymap.set({ "n", "v", "i" }, "<Up>", "<nop>")
vim.keymap.set({ "n", "v" }, "<Left>", "<nop>")
vim.keymap.set({ "n", "v" }, "<Right>", "<nop>")

vim.keymap.set({ "n" }, "<Down>", "<C-w>j")
vim.keymap.set({ "n" }, "<Up>", "<C-w>k")
vim.keymap.set({ "n" }, "<Left>", "<C-w>h")
vim.keymap.set({ "n" }, "<Right>", "<C-w>l")


-- These mappings control the size of splits (height/width)
vim.keymap.set("n", "<C-A-m>", "<c-w>5<")
vim.keymap.set("n", "<C-A-/>", "<c-w>5>")
vim.keymap.set("n", "<C-A-.>", "<C-W>+")
vim.keymap.set("n", "<C-A-,>", "<C-W>-")

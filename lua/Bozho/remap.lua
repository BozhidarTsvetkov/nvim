local keymap = function(tbl)
	local opts = { noremap = true, silent = true }
	local mode = tbl['mode']
	tbl['mode'] = nil
	local bufnr = tbl['bufnr']
	tbl['bufnr'] = nil

	for k, v in pairs(tbl) do
		if tonumber(k) == nil then
			opts[k] = v
		end
	end

	if bufnr ~= nil then
		vim.api.nvim_buf_set_keymap(bufnr, mode, tbl[1], tbl[2], opts)
	else
		vim.api.nvim_set_keymap(mode, tbl[1], tbl[2], opts)
	end
end

nmap = function(tbl)
	tbl['mode'] = 'n'
	keymap(tbl)
end

imap = function(tbl)
	tbl['mode'] = 'i'
	keymap(tbl)
end

vim.g.mapleader = " "

local set = vim.keymap.set

set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

set("n", "J", "mzJ`z")
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")


-- greatest remap ever
set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
set({"n", "v"}, "<leader>y", [["+y]])
set("n", "<leader>Y", [["+Y]])
set({"n", "v"}, "<leader>p", [["+p]])
set("n", "<leader>P", [["+P]])

set({"n", "v"}, "<leader>d", [["_d]])

-- This is going to get me cancelled
set("i", "<C-c>", "<Esc>")


-- Remove newbie crutches in Normal, Insert and Visual Mode
set({ "n", "v", "i" }, "<Down>", "<nop>")
set({ "n", "v", "i" }, "<Up>", "<nop>")
set({ "n", "v" }, "<Left>", "<nop>")
set({ "n", "v" }, "<Right>", "<nop>")

set({ "n" }, "<Down>", "<C-w>j")
set({ "n" }, "<Up>", "<C-w>k")
set({ "n" }, "<Left>", "<C-w>h")
set({ "n" }, "<Right>", "<C-w>l")


-- These mappings control the size of splits (height/width)
set("n", "<C-A-m>", "<c-w>5<")
set("n", "<C-A-/>", "<c-w>5>")
set("n", "<C-A-.>", "<C-W>+")
set("n", "<C-A-,>", "<C-W>-")

-- similar to tmux split 
set("n", "<leader>%", ":vsplit<CR>")
set("n", "<leader>\"", ":split<CR>")

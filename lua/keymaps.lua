-- ==============================================================================================
-- KEYMAPS
-- ==============================================================================================
local u = require('utils')

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Keymaps for better default experience
u.map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
u.map("n", "<leader>bD", "<cmd>%bd|e#|bd#<cr>", { desc = "Close all but the current buffer" })
u.map("n", "<S-X>", "<cmd>bd!<cr>", { desc = "Close buffer" })
-- greatest remap ever
-- speedy mode
u.map({ "v", "n" }, "<S-j>", "5j")
u.map({ "v", "n" }, "<S-k>", "5k")
-- Easier ESC
u.map({ 'i', 'v' }, "<C-c>", "<esc>")
u.map("n", "<C-c>", ":nohlsearch<cr><esc>")
-- Remap for dealing with word wrap
u.map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
u.map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- save to file with strg + s
u.map("n", "<C-s>", ":w<cr>", { noremap = true })
-- fix the remove linebreak key combo e.g. shift + J -> strg + J
u.map("v", "<C-j>", "J")
-- u.map("n", "<S-L>", ":bnext<cr>", { noremap = true })
-- u.map("n", "<S-H>", ":bprevious<cr>", { noremap = true })
-- With this you can use > < multiple time for changing indent when you visual selected text.
u.map("v", "<", "<gv")
u.map("v", ">", ">gv")
-- deactivate arrow keys in normal mode
u.map("n", "<up>", "<nop>")
u.map("n", "<left>", "<nop>")
u.map("n", "<right>", "<nop>")
u.map("n", "<down>", "<nop>")
-- cycle through buffers
u.map("n", "[b", ":bprevious<CR>", { desc = "Previous Buffer" })
u.map("n", "]b", ":bnext<CR>", { desc = "Next Buffer" })
u.map("n", "[B", ":bfirst<CR>", { desc = "First Buffer" })
u.map("n", "]B", ":blast<CR>", { desc = "Last Buffer" })
-- cycle through tabs
u.map("n", "[t", ":tabprevious<CR>", { desc = "Previous Tab" })
u.map("n", "]t", ":tabnext<CR>", { desc = "Next Tab" })
u.map("n", "[T", ":tabfirst<CR>", { desc = "First Tab" })
u.map("n", "]T", ":tablast<CR>", { desc = "Last Tab" })
-- diagnostics
u.map('n', '<leader>tl', vim.diagnostic.setloclist)
u.map('n', '<leader>tq', vim.diagnostic.setqflist)
-- search
u.map('n', '<C-f>', "<cmd>silent !tmux neww tmux-sessionizer<cr>")

-- name = "Tmux",
-- 				h = { "<cmd>silent !tmux splitw <cr>", "Tmux Vertical Pane" },
-- 				v = { "<cmd>silent !tmux splitw -hf<cr>", "Tmux Horizontal Pane" },

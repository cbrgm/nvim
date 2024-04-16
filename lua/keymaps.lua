-- ==============================================================================================
-- KEYMAPS
-- ==============================================================================================
local u = require('utils')

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

u.map({ 'n', 'v' }, '<leader>Q', 'ZZ', { silent = true })

u.map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
u.map("n", "<leader>bD", "<cmd>%bd|e#|bd#<cr>", { desc = "Close all but the current buffer" })
u.map("n", "<leader>bd", "<cmd>bd!<cr>", { desc = "Close buffer" })
-- u.map("n", "<leader>q", "<cmd>bd!<cr>", { desc = "Close buffer" })
u.map("n", "<leader>q", u.closeEmptyNvim, { desc = "Close buffer" })

-- Buffers
u.map("n", "<C-L>", ":bnext<cr>")
u.map("n", "<C-H>", ":bprevious<cr>")
u.map("n", "[b", ":bprevious<CR>", { desc = "Previous Buffer" })
u.map("n", "]b", ":bnext<CR>", { desc = "Next Buffer" })
u.map("n", "[B", ":bfirst<CR>", { desc = "First Buffer" })
u.map("n", "]B", ":blast<CR>", { desc = "Last Buffer" })
u.map("n", "<leader><leader>", "<cmd>:e #<cr>", { desc = "Switch to Other Buffer" })

-- Tabs
u.map("n", "[t", ":tabprevious<CR>", { desc = "Previous Tab" })
u.map("n", "]t", ":tabnext<CR>", { desc = "Next Tab" })
u.map("n", "[T", ":tabfirst<CR>", { desc = "First Tab" })
u.map("n", "]T", ":tablast<CR>", { desc = "Last Tab" })

-- Paste but dont overwrite
u.map("x", "<leader>p", "\"_dP", { desc = "Paste without buffer overwrite" })
u.map({ "n" }, "<leader>Y", "\"+Y", { desc = "Paste without buffer overwrite" })
u.map({ "n", "v" }, "<leader>y", "\"+y", { desc = "Paste without buffer overwrite" })
-- u.map({ 'n', 'v' }, "<leader>d", "\"_d", { desc = "Delete without buffer orverwrite" })

-- With this you can use > < multiple time for changing indent when you visual selected text.
u.map("v", "<", "<gv")
u.map("v", ">", ">gv")

-- deactivate arrow keys in normal mode
u.map("n", "<up>", "<nop>")
u.map("n", "<left>", "<nop>")
u.map("n", "<right>", "<nop>")
u.map("n", "<down>", "<nop>")

-- Center window when moving up/down half page or when using search
u.map("n", "<C-d>", "<C-d>zz")
u.map("n", "<C-u>", "<C-u>zz")
u.map("n", "n", "nzzzv")
u.map("n", "N", "Nzzzv")

-- Stay in line when removing line breaks
u.map("v", "J", "mzJ`z")

-- Easier ESC
u.map({ 'i', 'v' }, "<C-c>", "<esc>")
u.map("n", "<C-c>", ":nohlsearch<cr><esc>")

-- Remap for dealing with word wrap
u.map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
u.map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Save to file with strg + s
u.map("n", "<C-s>", ":w<cr>", { noremap = true })

-- Search
-- u.map('n', '<C-f>', "<cmd>silent !tmux neww tmux-sessionizer<cr>")
u.map('n', '<leader>ov', "<cmd>silent !tmux splitw -f<cr>", { desc = "Open Tmux Terminal (Vertical)" })
u.map('n', '<leader>oh', "<cmd>silent !tmux splitw -hf<cr>", { desc = "Open Tmux Terminal (Horizontal)" })

-- Quickfix / Location list
u.map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Open Location List" })
u.map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Open Quickfix List" })

-- Toggle Options
u.map("n", "<leader>ts", function() u.toggle("spell") end, { desc = "Toggle Spelling" })
u.map("n", "<leader>tw", function() u.toggle("wrap") end, { desc = "Toggle Word Wrap" })
u.map("n", "<leader>tn", function() u.toggle("relativenumber", true) end,
  { desc = "Toggle Line Numbers" })
u.map("n", "<leader>td", u.toggle_diagnostics, { desc = "Toggle Diagnostics" })

-- diagnostics
u.map('n', '<leader>tl', vim.diagnostic.setloclist, { desc = "Toggle LocList" })
u.map('n', '<leader>tq', vim.diagnostic.setqflist, { desc = "Toggle QuickFix" })

-- cowboy mode
-- u.cowboy()

-- =============================================================================================
-- PLUGIN: HARPOON
-- ==============================================================================================
local u = require('utils')
local ok, harpoon = pcall(require, "harpoon")
if not ok then return end

local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")

harpoon.setup({
	save_on_toggle = false, -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
	save_on_change = true, -- saves the harpoon file upon every change. disabling is unrecommended.
	enter_on_sendcmd = false, -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
	tmux_autoclose_windows = false, -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
	excluded_filetypes = { "harpoon" }, -- filetypes that you want to prevent from adding to the harpoon list menu.
	mark_branch = false, -- set marks specific to each git branch inside git repository
})

u.map("n", "<leader><leader>", function() harpoon_mark.add_file() end)
u.map("n", "<leader>e", function() harpoon_ui.toggle_quick_menu() end)
-- u.map("n", "<S-L>", function()
-- 	harpoon_ui.nav_next()
-- end, { noremap = true })
-- u.map("n", "<S-H>", function()
-- 	harpoon_ui.nav_prev()
-- end, { noremap = true })

-- quick access
u.map("n", "<C-h>", function() harpoon_ui.nav_file(1) end)
u.map("n", "<C-j>", function() harpoon_ui.nav_file(2) end)
u.map("n", "<C-k>", function() harpoon_ui.nav_file(3) end)
u.map("n", "<C-l>", function() harpoon_ui.nav_file(4) end)

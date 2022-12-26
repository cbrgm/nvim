-- ==============================================================================================
-- PLUGIN: DIFFVIEW
-- ==============================================================================================
local u = require('utils')

local diffview_ok, diffview = pcall(require, "diffview")
if not diffview_ok then return end

diffview.setup({})

vim.api.nvim_create_user_command("DiffviewToggle", function(e)
	local view = require("diffview.lib").get_current_view()

	if view then
		vim.cmd("DiffviewClose")
	else
		vim.cmd("DiffviewOpen " .. e.args)
	end
end, { nargs = "*" })

-- git: diff
u.map("n", "<leader>gD", ":DiffviewToggle origin/main...HEAD<CR>",
	{ desc = "Git Diff (main)", noremap = true, silent = true })
u.map("n", "<leader>gd", ":DiffviewToggle HEAD~<CR>",
	{ desc = "Git Diff (head~1)", noremap = true, silent = true })

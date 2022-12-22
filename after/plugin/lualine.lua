-- ==============================================================================================
-- PLUGIN: LUALINE
-- ==============================================================================================
local ok, lualine = pcall(require, 'lualine')
if not ok then return end

local pwd = function()
	return vim.fn.getcwd()
end

local timer = function()
	return require("countdown").get_time()
end

lualine.setup {
	options = {
		icons_enabled = false,
		theme = "auto",
		component_separators = '',
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = { "" },
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		}
	},
	sections = {},
	inactive_sections = {},
	tabline = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { pwd, "filename" },
		lualine_x = { timer, "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" }
	},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
}

lualine.hide({
	place = { 'statusline', 'winbar' }, -- The segment this change applies to.
	unhide = false, -- whether to reenable lualine again/
})

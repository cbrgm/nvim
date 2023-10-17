-- ==============================================================================================
-- PLUGIN: INDENT_BLANKLINE
-- ==============================================================================================
local ok, indent_blankline = pcall(require, "ibl")
if not ok then return end

indent_blankline.setup {
	indent = { char = "┊" },
	whitespace = {
		remove_blankline_trail = false,
	},
	scope = { enabled = false },
}

-- ==============================================================================================
-- PLUGIN: INDENT_BLANKLINE
-- ==============================================================================================
local u = require('utils')
local ok, indent_blankline = pcall(require, "indent_blankline")
if not ok then return end

indent_blankline.setup {
	char = '┊',
	show_trailing_blankline_indent = false,
}

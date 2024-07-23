-- ==============================================================================================
-- THEME: WHICH-KEY
-- ==============================================================================================
local ok, wk = pcall(require, "which-key")
if not ok then return end

wk.setup {
	layout = {
		align = "left",
	},
}

wk.add({
	mode = { "n", "v" },
	{ "<leader>b", group = "buffer" },
	{ "<leader>c", group = "code" },
	{ "<leader>f", group = "file" },
	{ "<leader>g", group = "git" },
	{ "<leader>h", group = "help" },
	{ "<leader>o", group = "open" },
	{ "<leader>s", group = "search" },
	{ "<leader>t", group = "toggle" },
	{ "<leader>x", group = "diagnostics/quickfix" },
	{ "[",         group = "prev" },
	{ "]",         group = "next" },
	{ "g",         group = "goto" },
})

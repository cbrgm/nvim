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

wk.register({
	mode = { "n", "v" },
	["g"] = { name = "+goto" },
	["]"] = { name = "+next" },
	["["] = { name = "+prev" },
	["<leader>b"] = { name = "+buffer" },
	["<leader>c"] = { name = "+code" },
	["<leader>f"] = { name = "+file" },
	["<leader>g"] = { name = "+git" },
	["<leader>h"] = { name = "+help" },
	["<leader>o"] = { name = "+open" },
	["<leader>s"] = { name = "+search" },
	["<leader>t"] = { name = "+toggle" },
	["<leader>x"] = { name = "+diagnostics/quickfix" },
})

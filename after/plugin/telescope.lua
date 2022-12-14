-- ==============================================================================================
-- PLUGIN: TELESCOPE
-- ==============================================================================================
local u = require('utils')
local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then return end

local trouble_ok, trouble = pcall(require, "trouble.providers.telescope")
if not trouble_ok then return end

telescope.setup {
	extensions = {
		file_browser = {
			hijack_netrw = true,
			hidden = true,
			theme = "ivy",
			hlsearch = true,
			mappings = {
				i = {
					["<c-n>"] = require("telescope").extensions.file_browser.actions.create,
					["<c-r>"] = require("telescope").extensions.file_browser.actions.rename,
					["<c-h>"] = require("telescope").extensions.file_browser.toggle_hidden,
					["<c-x>"] = require("telescope").extensions.file_browser.remove,
					["<c-p>"] = require("telescope").extensions.file_browser.move,
					["<c-y>"] = require("telescope").extensions.file_browser.copy,
					["<c-a>"] = require("telescope").extensions.file_browser.select_all,
				},
			},
		},
	},
	pickers = {
		find_files = {
			hidden = true,
			theme = "ivy",
		},
		buffers = {
			ignore_current_buffer = true,
			sort_lastused = true,
			theme = "ivy",
		},
		live_grep = {
			theme = "ivy",
		},
		oldfiles = {
			theme = "ivy",
		},
		git_files = {
			theme = "ivy",
		},
		git_branches = {
			theme = "ivy",
		},
		projects = {
			theme = "ivy",
		},
	},
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--follow",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--no-ignore",
			"--trim",
		},
		file_ignore_patterns = {
			"%.git/.*",
			"%.vim/.*",
			"node_modules/.*",
			"%.idea/.*",
			"vendor/.*",
			"%.vscode/.*",
			"%.history/.*",
		},
		mappings = {
			i = {
				-- Close on first esc instead of going to normal mode
				-- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
				["<esc>"] = require("telescope.actions").close,
				["<C-j>"] = require("telescope.actions").move_selection_next,
				["<PageUp>"] = require("telescope.actions").results_scrolling_up,
				["<PageDown>"] = require("telescope.actions").results_scrolling_down,
				["<C-u>"] = require("telescope.actions").preview_scrolling_up,
				["<C-d>"] = require("telescope.actions").preview_scrolling_down,
				["<C-k>"] = require("telescope.actions").move_selection_previous,
				["<C-q>"] = require("telescope.actions").send_selected_to_qflist,
				["<C-l>"] = require("telescope.actions").send_to_qflist,
				["<Tab>"] = require("telescope.actions").toggle_selection + require("telescope.actions").move_selection_worse,
				["<S-Tab>"] = require("telescope.actions").toggle_selection + require("telescope.actions").move_selection_better,
				["<cr>"] = require("telescope.actions").select_default,
				["<c-v>"] = require("telescope.actions").select_vertical,
				["<c-s>"] = require("telescope.actions").select_horizontal,
				["<c-t>"] = trouble.open_with_trouble,
				-- ["<c-t>"] = require("telescope.actions").select_tab,
				["<c-p>"] = require("telescope.actions.layout").toggle_preview,
				["<c-o>"] = require("telescope.actions.layout").toggle_mirror,
				["<c-h>"] = require("telescope.actions").which_key,
			},
		},
		prompt_prefix = "> ",
		selection_caret = " ",
		entry_prefix = "  ",
		multi_icon = "<>",
		initial_mode = "insert",
		scroll_strategy = "cycle",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "center",
		layout_config = {
			width = 0.95,
			height = 0.85,
			-- preview_cutoff = 120,
			prompt_position = "top",
			horizontal = {
				preview_width = function(_, cols, _)
					if cols > 200 then
						return math.floor(cols * 0.4)
					else
						return math.floor(cols * 0.6)
					end
				end,
			},
			vertical = { width = 0.9, height = 0.95, preview_height = 0.5 },
			flex = { horizontal = { preview_width = 0.9 } },
		},
		winblend = 0,
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		use_less = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
	},
}
-- Enable telescope file_browser, if installed
pcall(require('telescope').load_extension, 'file_browser')

-- the powersearch key
u.nmap("<C-f>", "<cmd>Telescope<cr>")

u.map('n', '<leader>sr', require('telescope.builtin').oldfiles, { desc = 'Find recently opened files' })
u.map('n', '<leader>bb', require('telescope.builtin').buffers, { desc = 'Find existing buffers' })
u.map('n', '<leader>fs', function()
	require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_ivy {
		previewer = false,
	})
end, { desc = 'Fuzzily search in current buffer' })
u.map('n', '<leader>ff', require('telescope.builtin').git_files, { desc = 'Search Files' })
u.map('n', '<leader>sf', function() require('telescope.builtin').find_files({ hidden = true }) end,
	{ desc = 'Search Files' })
u.map('n', '<leader>sb', require('telescope.builtin').buffers, { desc = 'Find existing buffers' })
u.map('n', '<leader>sc', require('telescope.builtin').resume, { desc = 'Resume last search' })
u.map('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = 'Search Help' })
u.map('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = 'Search current Word' })
u.map('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = 'Search by Grep' })
u.map('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = 'Search Diagnostics' })

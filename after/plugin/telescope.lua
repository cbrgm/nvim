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
		fzf = {
			fuzzy = true,                -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case",    -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		}
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
		git_status = {
			theme = "ivy",
		},
		git_branches = {
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
			"--hidden",
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
-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- the powersearch key

local search = function()
	local opt = require('telescope.themes').get_dropdown({ height = 10, previewer = false })
	require('telescope.builtin').current_buffer_fuzzy_find(opt)
end

u.map('n', "<leader><leader>", "<cmd>Telescope buffers show_all_buffers=true<cr>", { desc = "Switch Buffer" })
u.map('n', '<space>/', search, { desc = 'Fuzzily search in current buffer' })
u.map('n', '<leader>ff', "<cmd>Telescope git_files<cr>", { desc = 'Search Files (Git)' })
u.map('n', '<leader>fF', "<cmd>Telescope find_files<cr>", { desc = 'Search Files (All)' })
u.map('n', "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent" })
u.map('n', "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "status" })
u.map('n', "<leader>ha", "<cmd>Telescope autocommands<cr>", { desc = "Auto Commands" })
u.map('n', "<leader>hc", "<cmd>Telescope commands<cr>", { desc = "Commands" })
u.map('n', "<leader>hf", "<cmd>Telescope filetypes<cr>", { desc = "File Types" })
u.map('n', "<leader>hh", "<cmd>Telescope help_tags<cr>", { desc = "Help Pages" })
u.map('n', "<leader>hk", "<cmd>Telescope keymaps<cr>", { desc = "Key Maps" })
u.map('n', "<leader>hm", "<cmd>Telescope man_pages<cr>", { desc = "Man Pages" })
u.map('n', "<leader>ho", "<cmd>Telescope vim_options<cr>", { desc = "Options" })
u.map('n', "<leader>hs", "<cmd>Telescope highlights<cr>", { desc = "Search Highlight Groups" })
u.map('n', "<leader>ht", "<cmd>Telescope builtin<cr>", { desc = "Telescope" })
u.map('n', "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Search Symbols" })
u.map('n', "<leader>sr", "<cmd>Telescope resume<cr>", { desc = "Resume Search" })
u.map('n', "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Buffer" })
u.map('n', "<leader>sc", "<cmd>Telescope command_history<cr>", { desc = "Command History" })
u.map('n', "<leader>sg", "<cmd>Telescope live_grep<cr>", { desc = "Grep" })
u.map('n', "<leader>sm", "<cmd>Telescope marks<cr>", { desc = "Jump to Mark" })
u.map('n', "<leader>:", "<cmd>Telescope command_history<cr>", { desc = "Command History" })

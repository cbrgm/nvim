-- ==============================================================================================
-- PLUGIN: TREESITTER
-- ==============================================================================================
local u = require('utils')
local ok, ts = pcall(require, "nvim-treesitter.configs")
if not ok then
	u.warn("failed to configure plugin: indent_blankline")
	return
end

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
-- Supported languages, add more here...
local languages = { 'bash', 'c', 'cpp', 'go', 'gomod', 'lua', 'python', 'rust', 'typescript', 'tsx', 'json', 'yaml',
	'markdown', 'markdown_inline', 'html', 'javascript', 'css', 'toml', 'help' }

ts.setup {
	-- Add languages to be installed here that you want installed for treesitter
	ensure_installed = languages,
	autotag = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	highlight = {
		enable = true,
		use_languagetree = true,
	},
	indent = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = '<c-space>',
			node_incremental = '<c-space>',
			scope_incremental = '<c-s>',
			node_decremental = '<c-backspace>',
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = false, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				['aa'] = '@parameter.outer',
				['ia'] = '@parameter.inner',
				['af'] = '@function.outer',
				['if'] = '@function.inner',
				["ac"] = "@conditional.outer",
				["ic"] = "@conditional.inner",
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
				["ab"] = "@block.outer",
				["ib"] = "@block.inner",
			},
			-- You can choose the select mode (default is charwise 'v')
			selection_modes = {

				["@parameter.outer"] = "v", -- charwise
				["@function.outer"] = "V", -- linewise
				["@class.outer"] = "<c-v>", -- blockwise
			},
			-- If you set this to `true` (default is `false`) then any textobject is
			-- extended to include preceding xor succeeding whitespace. Succeeding
			-- whitespace has priority in order to act similarly to eg the built-in

			-- `ap`.
			include_surrounding_whitespace = false,
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				[']m'] = '@function.outer',
				[']]'] = '@class.outer',
			},
			goto_next_end = {
				[']M'] = '@function.outer',
				[']['] = '@class.outer',
			},
			goto_previous_start = {
				['[m'] = '@function.outer',
				['[['] = '@class.outer',
			},
			goto_previous_end = {
				['[M'] = '@function.outer',
				['[]'] = '@class.outer',
			},
		},
		swap = {
			enable = true,
			swap_next = {
				['<leader>a'] = '@parameter.inner',
			},
			swap_previous = {
				['<leader>A'] = '@parameter.inner',
			},
		},
	},
}

parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

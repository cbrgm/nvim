-- ==============================================================================================
-- AUTOCOMPLETION
-- ==============================================================================================
local u = require('utils')
local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then return end

local luasnip_ok, luasnip = pcall(require, "luasnip")
if not luasnip_ok then
	u.warn("failed to configure plugin: cmp")
	return
end

-- require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.fn.expand("~/.config/nvim/vsnip") })
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup {
	preselect = cmp.PreselectMode.None,
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	completion = {
		completeopt = 'menu,menuone,noinsert',
	},
	mapping = cmp.mapping.preset.insert {
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete {},
		['<CR>'] = cmp.mapping.confirm {
			select = true,
		},
		['<Tab>'] = cmp.mapping(function(fallback)
			if luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
	}, window = {
	documentation = cmp.config.window.bordered(),
},
	sources = {
		{ name = "nvim_lsp", priority = 99 },
		{ name = 'luasnip' },
		{ name = "path" },
	},
}

cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- ==============================================================================================
-- LSP SETTINGS
-- ==============================================================================================
local u = require('utils')
local lsp = vim.lsp

-- Enable the following language servers
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'sumneko_lua', 'gopls', 'terraformls', 'dockerls',
	"bashls", "yamlls" }

local telescope_ok, _ = pcall(require, "telescope")
if not telescope_ok then return end

local mason_ok, mason = pcall(require, "mason")
if not mason_ok then return end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then return end

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then return end

-- lsp formatting
local lsp_formatting = function(bufnr)
	local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
	lsp.buf.format({
		bufnr = bufnr,
		filter = function(client)
			if client.name == 'eslint' then
				return true
			end

			if client.name == 'null-ls' then
				return not u.table.some(clients, function(_, other_client)
					return other_client.name == 'eslint'
				end)
			end
		end,
	})
end

local function diagnostic_goto(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end

local on_attach = function(client, bufnr)
	vim.notify("connecting '" .. client.name .. "' to buffer " .. bufnr, vim.log.levels.DEBUG)

	-- capabilities
	local capabilities = client.server_capabilities

	-- lsp format
	if capabilities.documentFormattingProvider then
		u.buf_command(bufnr, 'LspFormatting', function()
			lsp_formatting(bufnr)
		end)

		local augroup = 'auto_format_' .. bufnr
		vim.api.nvim_create_augroup(augroup, { clear = true })
		vim.api.nvim_create_autocmd('BufWritePre', {
			group = augroup,
			buffer = bufnr,
			command = 'LspFormatting',
		})

		-- format on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function()
				vim.lsp.buf.format({})
			end,
			buffer = bufnr,
		})
	end

	-- show definition of current symbol
	if capabilities.definitionProvider then
		u.buf_command(bufnr, 'LspDef', function()
			vim.lsp.buf.definition()
		end)
		u.buf_map(bufnr, 'n', "gd", "<cmd>Telescope lsp_definitions<cr>", { desc = "Goto Definition" })
		u.buf_map(bufnr, 'n', "gt", "<cmd>Telescope lsp_type_definitions<cr>", { desc = "Goto Type Definition" })
	end

	-- show declaration of current symbol
	if capabilities.declarationProvider then
		u.buf_command(bufnr, 'LspDec', function()
			vim.lsp.buf.declaration()
		end)
		u.buf_map(bufnr, 'n', "gD", "<cmd>Telescope lsp_declarations<cr>", { desc = "Goto Declaration" })
	end

	-- show implementation fo current symbol
	if capabilities.implementationProvider then
		u.buf_command(bufnr, 'LspImplementations', function()
			vim.lsp.buf.implementation()
		end)
		u.buf_map(bufnr, 'n', "gI", "<cmd>Telescope lsp_implementations<cr>", { desc = "Goto Implementation" })
	end

	-- rename current symbol
	if capabilities.renameProvider then
		u.buf_command(bufnr, 'LspRename', function()
			vim.lsp.buf.rename()
		end)
		u.buf_map(bufnr, 'n', '<leader>cr', ':LspRename<CR>', { desc = "Rename" })
	end

	-- show code actions available
	if capabilities.codeActionProvider then
		u.buf_command(bufnr, 'LspAct', function()
			vim.lsp.buf.code_action()
		end)
		u.buf_map(bufnr, { 'n', 'v' }, '<leader>ca', '<cmd>LspAct<CR>', { desc = "Code Action" })
	end

	-- References of current symbol
	if capabilities.referencesProvider then
		u.buf_command(bufnr, 'LspRefs', function()
			vim.lsp.buf.references()
		end)

		u.buf_map(bufnr, 'n', "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
	end

	-- show signature help
	if capabilities.signatureHelpProvider then
		u.buf_command(bufnr, 'LspSignatureHelp', function()
			vim.lsp.buf.signature_help()
		end)
		u.buf_map(bufnr, 'n', 'gK', vim.lsp.buf.signature_help, { desc = 'Signature Documentation' })
	end

	-- diagnostics
	u.buf_map(bufnr, 'n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
	u.buf_map(bufnr, 'n', '[d', diagnostic_goto(false), { desc = 'Previous Diagnostic' })
	u.buf_map(bufnr, 'n', ']e', diagnostic_goto(true, "ERROR"), { desc = 'Next Error' })
	u.buf_map(bufnr, 'n', '[e', diagnostic_goto(false, "ERROR"), { desc = 'Previous Error' })
	u.buf_map(bufnr, 'n', ']w', diagnostic_goto(true, "WARNING"), { desc = 'Next Warning' })
	u.buf_map(bufnr, 'n', '[w', diagnostic_goto(false, "WARNING"), { desc = 'Previous Warning' })
	u.buf_map(bufnr, 'n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
	u.buf_map(bufnr, 'n', "<leader>cl", "<cmd>LspInfo<cr>", { desc = "Lsp Info" })
end

-- Setup mason so it can manage external tooling
mason.setup({
	ui = {
		border = "rounded",
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

-- Ensure the servers above are installed
mason_lspconfig.setup {
	ensure_installed = servers,
}

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

for _, server in ipairs(servers) do
	lspconfig[server].setup {
		on_attach = on_attach,
		capabilities = capabilities,
	}
end

-- configuration for lua
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.sumneko_lua.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
				path = runtime_path,
			},
			diagnostics = {
				globals = { 'vim' },
			},
			workspace = { library = vim.api.nvim_get_runtime_file('', true) },
			telemetry = { enable = false },
		},
	},
}

lspconfig.gopls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		gopls = {
			usePlaceholders = true,
			gofumpt = true,
			analyses = {
				shadow = true,
				unusedparams = true,
				unusedwrite = true,
				nilness = true,
			},
			staticcheck = true,
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	},
})

lspconfig.yamlls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		yaml = {
			schemaStore = {
				enable = true,
				url = "https://www.schemastore.org/api/json/catalog.json",
			},
			formate = { enabled = true },
			schemas = {
				["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
				["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
				["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
				["https://json.schemastore.org/dependabot-2.0"] = ".github/dependabot.{yml,yaml}",
				["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
				["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.2-standalone-strict/all.json"] = "**/*.k8s.{yml,yaml}",
			},
			customTags = {
				"!And scalar",
				"!And mapping",
				"!And sequence",
				"!If scalar",
				"!If mapping",
				"!If sequence",
				"!Not scalar",
				"!Not mapping",
				"!Not sequence",
				"!Equals scalar",
				"!Equals mapping",
				"!Equals sequence",
				"!Or scalar",
				"!Or mapping",
				"!Or sequence",
				"!FindInMap scalar",
				"!FindInMap mappping",
				"!FindInMap sequence",
				"!Base64 scalar",
				"!Base64 mapping",
				"!Base64 sequence",
				"!Cidr scalar",
				"!Cidr mapping",
				"!Cidr sequence",
				"!Ref scalar",
				"!Ref mapping",
				"!Ref sequence",
				"!Sub scalar",
				"!Sub mapping",
				"!Sub sequence",
				"!GetAtt scalar",
				"!GetAtt mapping",
				"!GetAtt sequence",
				"!GetAZs scalar",
				"!GetAZs mapping",
				"!GetAZs sequence",
				"!ImportValue scalar",
				"!ImportValue mapping",
				"!ImportValue sequence",
				"!Select scalar",
				"!Select mapping",
				"!Select sequence",
				"!Split scalar",
				"!Split mapping",
				"!Split sequence",
				"!Join scalar",
				"!Join mapping",
				"!Join sequence",
			},
			completion = true,
			hover = true,
			validate = true,
		},
	},
})

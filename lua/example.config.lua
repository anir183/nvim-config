return {
	minimal_mode = false,

	netrw_winsize = 17,

	cmd_pre = "CMD",

	plugins = {
		{
			"nvim-flutter/flutter-tools.nvim",
			name = "flutter-tools",
			dependencies = { "plenary", "lspconfig", "dap" },
			config = function()
				require("flutter-tools").setup({
					debugger = {
						enabled = true,
					},
				})
			end,
		},
		{
			"pmizio/typescript-tools.nvim",
			name = "typescript-tools",
			dependencies = { "plenary", "lspconfig" },
			config = function()
				require("typescript-tools").setup({})
			end,
		},
	},

	test_plugins = false,

	after = function() end,

	lsps = {
		html = {},
		cssls = {},
		emmet_language_server = {},
		lua_ls = {
			settings = {
				Lua = {
					callSnippet = "Replace",
				},
			},
		},
		clangd = {},
	},

	formatters = {
		mason = {
			"stylua",
		},
		lua = { "stylua", lsp_format = "never" },
	},

	custom_formatters = {},

	linters = {
		mason = {},
	},

	custom_linters = {},

	daps = {},

	custom_daps = {},

	additional_filetypes = {
		extension = {
			env = "dotenv",
		},
		filename = {
			[".env"] = "dotenv",
		},
		pattern = {
			["%.env%.[%w_.-]+"] = "dotenv",
		},
	},

	treesitter_parsers = {
		dotenv = {
			install_info = {
				url = "https://github.com/pnx/tree-sitter-dotenv",
				branch = "main",
				files = { "src/parser.c", "src/scanner.c" },
			},
			filetype = "dotenv",
		},
	},

	cloak_patterns = {
		{
			file_pattern = { ".env", ".env.*" },
			cloak_pattern = { "=.+" },
			replace = nil,
		},
		{
			file_pattern = { "*secret.json", "secret*.json" },
			cloak_pattern = { ":.+" },
			replace = nil,
		},
	},
}

return {
	-- start neovim using minimal configuration
	minimal_mode = false,

	-- size of netrw sidebar
	netrw_winsize = 17,

	-- prefix for custom commands
	cmd_pre = "CMD",

	-- extra plugins to be installed
	-- uses generic lazy syntax
	plugins = {
		-- {
		--     "plugin/link",
		--     name = "",
		--     config = function() end,
		--     ...
		-- }
	},

	-- disable all other plugins to create a plugin testing environment
	-- false or nil to use normal plugins
	test_plugins = false,

	-- to be executed on the VimEnter event, after config is loaded
	after = function()
		-- vim.opt.bla = bla;
	end,

	-- lsps and their setup
	-- lsp names to be taken from mason
	lsps = {
		-- lsp_name = { lspopts }, -- alternatively false to only install and not setup
	},

	-- formatters and their setup
	-- formatter names to be taken from conform (https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters)
	formatters = {
		-- filetype = { "formatter1", "formatter2", stop_after_first = false }
	},

	-- setup custom formatters not available on mason or conform
	-- follow https://github.com/stevearc/conform.nvim?tab=readme-ov-file#customizing-formatters
	custom_formatters = {
		-- formatter_name = {
		--     command = "whatever",
		--     env = ...,
		--     ...
		-- }
	},

	-- linters and their setup
	-- linter names to be taken from nvim-lint (https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters)
	linters = {
		-- filetype = { "linter1", "linter2" }
	},

	-- setup custom formatters not available on mason or nvim-lint
	-- follow https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#custom-linters
	custom_linters = {
		-- linter_name = {
		--     cmd = "whatever",
		--     stdin = true,
		--     args = {},
		--     ...
		-- }
	},

	-- daps and their setup
	-- dap names to be taken from mason
	-- setup examples in https://github.com/jay-babu/mason-nvim-dap.nvim?tab=readme-ov-file#advanced-customization
	daps = {
		-- dap1_name = function(config) <handler code> end,
		-- dap2_name = nil,
	},

	-- setup custom daps not available on mason
	-- follow https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
	custom_daps = {
		-- {
		--     adapter_name = {
		--         type = "",
		--         command = "",
		--         args = {},
		--         ...
		--     },
		--     configuration_name = {
		--         type = "",
		--         name = "",
		--         ...
		--     }
		-- },
	},

	-- add new filetypes according to extension, filename or regex patterns
	additional_filetypes = {
		extension = {
			-- ext = "filetype",
		},
		filename = {
			-- ["name.ext"] = "filetype",
		},
		pattern = {
			-- ["regex_pattern"] = "filetype",
		},
	},

	-- setup custom treesitter not included with treesitter
	treesitter_parsers = {
		-- parser_name = {
		--     install_info = {
		--         url = "",
		--         branch = "",
		--         files = { "", "" },
		--     },
		-- filetype = "",
		-- },
	},

	-- patterns and file types to obscure for safety
	cloak_patterns = {
		-- {
		--     file_pattern = { "", "" },
		--     cloak_pattern = { "", "" },
		--     replace = nil
		-- },
	},
}

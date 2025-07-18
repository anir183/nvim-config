--[[ plugin for linting ]]

return {
	-- linting engine
	{
		"mfussenegger/nvim-lint",
		name = "lint",
		dependencies = "mason",
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = CONFIG.linters
			lint.linters = CONFIG.custom_linters

			vim.api.nvim_create_autocmd({
				"BufEnter",
				"BufWritePre",
				"InsertLeave",
			}, {
				group = AUGRP,
				callback = function()
					lint.try_lint()
				end,
			})

			NMAP(
				"<leader>ln",
				lint.try_lint,
				{ desc = "[plugin/nvim-lint]: perform linting on current file" }
			)
		end,
	},

	-- bridge between nvim-lint nad mason
	{
		"rshkarin/mason-nvim-lint",
		name = "mason-lint",
		dependencies = "lint",
		config = function()
			require("mason-conform").setup()
		end,
	},
}

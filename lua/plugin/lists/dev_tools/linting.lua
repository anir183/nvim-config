--[[ plugin for linting ]]

return {
	"mfussenegger/nvim-lint",
	name = "lint",
	dependencies = "mason-tool-installer",
	config = function()
		local lint = require("lint")

		CONFIG.linters.mason = nil
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
}

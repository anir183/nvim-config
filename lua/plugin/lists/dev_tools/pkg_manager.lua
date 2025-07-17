--[[ plugin for managing different dev tools ]]

return {
	-- package manager
	{
		"williamboman/mason.nvim",
		name = "mason",
		config = function()
			require("mason").setup()

			NMAP(
				"<leader>mn",
				vim.cmd.Mason,
				{ desc = "[plugin/mason]: open mason window" }
			)
		end,
	},

	-- tool installing wrapper for package manager
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		name = "mason-tool-installer",
		dependencies = "mason",
		config = function()
			local ensure_installed = {}

			if CONFIG.formatters.mason then
				for _, formatter_name in pairs(CONFIG.formatters.mason) do
					table.insert(ensure_installed, formatter_name)
				end
			end

			if CONFIG.linters.mason then
				for _, linter_name in pairs(CONFIG.linters.mason) do
					table.insert(ensure_installed, linter_name)
				end
			end

			require("mason-tool-installer").setup({
				ensure_installed = ensure_installed,
				integrations = {
					["mason-lspconfig"] = false,
					["mason-null-ls"] = false,
					["mason-nvim-dap"] = false,
				},
			})
		end,
	},
}

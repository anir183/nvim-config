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
}

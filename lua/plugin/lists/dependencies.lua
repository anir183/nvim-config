--[[ dependencies for other plugins ]]

return {
	-- utility neovim functions
	{
		"nvim-lua/plenary.nvim",
		name = "plenary",
		priority = 1000, -- highest priority
	},

	-- icons for other plugins
	{
		"nvim-tree/nvim-web-devicons",
		name = "devicons",
		priority = 500, -- second highest priority
		config = function()
			require("nvim-web-devicons").setup()
		end,
	},

	-- async io
	{
		"nvim-neotest/nvim-nio",
		name = "nio",
		priority = 500,
	},
}

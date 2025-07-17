--[[ improve aesthetics of the editor ]]

return {
	--theme
	{
		"navarasu/onedark.nvim",
		name = "onedark",
		priority = 500, -- second highest priority
		config = function()
			local onedark = require("onedark")

			onedark.setup({
				style = "darker",
				transparent = true,
				ending_tildes = true,
				highlights = {
					Winbar = {
						bg = "none",
						bold = true,
					},
					WinbarNC = {
						bg = "none",
					},
					StatusLine = {
						bg = "none",
					},
					StatusLineNC = {
						bg = "none",
					},
					StatusLineTerm = {
						bg = "none",
					},
					StatusLineTermNC = {
						bg = "none",
					},
					Comment = {
						fg = "#737985",
					},
					["@comment"] = {
						fg = "#737985",
					},
				},
			})
			onedark.load()
		end,
	},

	-- icons for netrw
	{
		"prichrd/netrw.nvim",
		name = "netrw-plus",
		dependencies = "devicons",
		config = function()
			require("netrw").setup({ use_devicons = true })
		end,
	},

	-- lsp progress visualizer and vim.notify handler
	{
		"j-hui/fidget.nvim",
		name = "fidget",
		config = function()
			require("fidget").setup({
				notification = {
					override_vim_notify = true,
					window = {
						normal_hl = "Normal",
						winblend = 0,
						y_padding = 2,
					},
				},
			})

			NMAP(
				"<leader>nh",
				"<CMD>Fidget history<CR>",
				{ desc = "[plugin/fidget]: open notification history" }
			)
		end,
	},
}

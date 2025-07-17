--[[ plugins related to the language server protocol ]]

return {
	-- bridge between lspconfig and mason
	{
		"williamboman/mason-lspconfig.nvim",
		name = "mason-lspconfig",
		dependencies = "mason",
		config = function()
			local ensure_installed = {}

			for lsp_name, _ in pairs(CONFIG.lsps) do
				table.insert(ensure_installed, lsp_name)
			end

			require("mason-lspconfig").setup({
				ensure_installed = ensure_installed,
				automatic_installation = true,
			})
		end,
	},

	-- premade configurations for different lsps
	{
		"neovim/nvim-lspconfig",
		name = "lspconfig",
		dependencies = { "mason-lspconfig", "blink" },
		config = function()
			local lspconfig = require("lspconfig")

			for lsp_name, opts in pairs(CONFIG.lsps) do
				if not opts then
					goto continue
				end

				local capabilities = vim.tbl_deep_extend(
					"force",
					vim.lsp.protocol.make_client_capabilities(),
					opts.capabilities or {}
				)

				local glc = require("blink.cmp").get_lsp_capabilities
				opts.capabilities = glc(capabilities)
				lspconfig[lsp_name].setup(opts)

				::continue::
			end
		end,
	},

	-- neovim config oriented setup for luals
	{
		"folke/lazydev.nvim",
		name = "lazydev",
		dependencies = "lspconfig",
		config = function()
			require("lazydev").setup({
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
				integrations = {
					blink = true,
				},
			})
		end,
	},
}

--[[ plugins related to auto completion ]]

return {
	-- completion engine
	{
		"saghen/blink.cmp",
		name = "blink",
		version = "1.*",
		dependencies = "lazydev",
		config = function()
			local blink = require("blink.cmp")

			blink.setup({
				keymap = {
					preset = "none",
				},
				completion = {
					list = {
						selection = {
							preselect = false,
							auto_insert = true,
						},
					},
				},
				sources = {
					default = {
						"lazydev",
						"lsp",
						"path",
						"snippets",
						"buffer",
					},
					providers = {
						lazydev = {
							name = "LazyDev",
							module = "lazydev.integrations.blink",
							score_offset = 100, -- make lazydev top priority
						},
					},
				},
			})

			local feedkeys = function(keys)
				vim.api.nvim_feedkeys(
					vim.api.nvim_replace_termcodes(
						vim.keycode(keys),
						true,
						true,
						true
					),
					"ni",
					false
				)
			end

			-- hide or cancel completion menu
			MAP({ "i", "s" }, "<C-c>", function()
				if blink.is_visible() then
					blink.hide()
				else
					feedkeys("<C-c>")
				end
			end, { desc = "[plugin/blink]: hide completion menu" })
			MAP({ "i", "s" }, "<C-x>", function()
				if blink.is_visible() then
					blink.cancel()
				else
					feedkeys("<C-x>")
				end
			end, { desc = "[plugin/blink]: cancel completion and hide" })

			-- navigate completion menu
			MAP({ "i", "s" }, "<TAB>", function()
				if blink.is_visible() then
					blink.select_next()
					return
				end

				if not blink.snippet_forward() then
					feedkeys("<TAB>")
				end
			end, { desc = "[plugin/blink]: next item in completion menu" })
			MAP({ "i", "s" }, "<S-TAB>", function()
				if blink.is_visible() then
					blink.select_prev()
					return
				end

				if not blink.snippet_backward() then
					feedkeys("<S-TAB>")
				end
			end, { desc = "[plugin/blink]: prev item in completion menu" })

			-- accept completion
			MAP({ "i", "s" }, "<CR>", function()
				if not blink.accept() then
					feedkeys("<CR>")
				end
			end, { desc = "[plugin/blink]: accept completion suggestion" })

			-- documentation window
			MAP({ "i", "s" }, "<C-k>", function()
				if blink.is_documentation_visible() then
					blink.hide_documentation()
				elseif blink.is_visible() then
					blink.show_documentation()
				else
					feedkeys("<C-k>")
				end
			end, { desc = "[plugin/blink]: toggle documentation window" })
			MAP({ "i", "s" }, "<C-d>", function()
				if not blink.scroll_documentation_down(1) then
					feedkeys("<C-d>")
				end
			end, { desc = "[plugin/blink]: scroll down docs window" })
			MAP({ "i", "s" }, "<C-u>", function()
				if not blink.scroll_documentation_up(1) then
					feedkeys("<C-u>")
				end
			end, { desc = "[plugin/blink]: scroll up docs window" })
		end,
	},

	-- lsp signatures
	{
		"ray-x/lsp_signature.nvim",
		name = "lsp-signature",
		config = function()
			local lsp_sign = require("lsp_signature")
			lsp_sign.setup({
				floating_window = false,
				floating_window_off_x = 2,
				floating_window_off_y = 1,
				doc_lines = 0,
				hint_prefix = {
					above = "🡯 ",
					current = "🡨 ",
					below = "🡬 ",
				},
				handler_opts = {
					border = "none",
				},
			})

			MAP(
				{ "i", "s", "n" },
				"<C-h>",
				lsp_sign.toggle_float_win,
				{ desc = "[plugins/lsp-signature]: toggle signature window" }
			)
		end,
	},
}

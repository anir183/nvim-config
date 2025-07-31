--[[ quality of life plugins but not really necessary ]]

return {
	-- auto guess indentation
	{
		"nmac427/guess-indent.nvim",
		name = "guess-indent",
		config = function()
			require("guess-indent").setup({
				auto_cmd = false,
			})

			vim.api.nvim_create_user_command(
				CONFIG.cmd_pre .. "AutoIndent",
				function()
					local ft = vim.bo.filetype
					local ftstates = {
						help = false,
						netrw = false,
						oil = false,
						tutor = false,
						nofile = false,
						terminal = false,
						prompt = false,
						snacks_picker_input = false,
						snacks_terminal = false,
					}

					if ft == "" or ftstates[ft] == false then
						return
					end

					vim.cmd.GuessIndent()
					vim.opt.listchars:remove("leadmultispace")
					vim.opt.listchars:append({
						leadmultispace = "▎"
							.. ("∙"):rep(vim.opt.tabstop._value - 1),
					})
				end,
				{ desc = "[plugin/guess-indent]: set indentation" }
			)

			vim.api.nvim_create_autocmd({
				"BufReadPost",
				"BufNewFile",
				"BufFilePost",
			}, {
				group = AUGRP,
				command = CONFIG.cmd_pre .. "AutoIndent",
			})

			NMAP(
				"<leader>ai",
				"<CMD>" .. CONFIG.cmd_pre .. "AutoIndent<CR>",
				{ desc = "[plugin/guess-indent]: set indentation" }
			)
		end,
	},

	-- editable file explorer
	{
		"stevearc/oil.nvim",
		name = "oil",
		dependencies = "devicons",
		config = function()
			require("oil").setup({
				default_file_explorer = false,
				skip_confirm_for_simple_edits = true,
				view_options = {
					show_hidden = true,
				},
			})

			NMAP(
				"<leader>E",
				vim.cmd.Oil,
				{ desc = "[plugin/oil]: open the oil file explorer" }
			)
		end,
	},

	-- breadcrumbs and dropbar
	{
		"Bekaboo/dropbar.nvim",
		name = "dropbar",
		dependencies = "devicons",
		config = function()
			local dropbar_api = require("dropbar.api")

			NMAP(
				"<leader>;",
				dropbar_api.pick,
				{ desc = "[plugin/dropbar]: pick symbols in winbar" }
			)
		end,
	},

	-- hide sensitive tokens
	{
		"laytan/cloak.nvim",
		name = "cloak",
		config = function()
			require("cloak").setup({
				cloak_character = "*",
				patterns = CONFIG.cloak_patterns,
			})

			NMAP(
				"<leader>ct",
				vim.cmd.CloakToggle,
				{ desc = "[plugin/cloak]: toggle cloak hiding" }
			)
			NMAP(
				"<leader>CT",
				vim.cmd.CloakPreviewLine,
				{ desc = "[plugin/cloak]: preview current line" }
			)
		end,
	},

	-- selection and quick commenting
	{
		"numToStr/Comment.nvim",
		name = "comment",
		config = function()
			require("Comment").setup({
				mappings = {
					basic = false,
					extra = false,
				},
			})

			NMAP(
				"<C-c>",
				"<PLUG>(comment_toggle_linewise)",
				{ desc = "[plugin/comment]: linewise commenting leader" }
			)
			NMAP(
				"<C-x>",
				"<PLUG>(comment_toggle_blockwise)",
				{ desc = "[plugin/comment]: blockwise commenting leader" }
			)

			NMAP("<C-c><C-c>", function()
				if vim.api.nvim_get_vvar("count") == 0 then
					return "<PLUG>(comment_toggle_linewise_current)"
				else
					return "<PLUG>(comment_toggle_linewise_count)"
				end
			end, {
				expr = true,
				desc = "[plugin/comment]: normal comment current line",
			})
			NMAP("<C-x><C-x>", function()
				if vim.api.nvim_get_vvar("count") == 0 then
					return "<PLUG>(comment_toggle_blockwise_current)"
				else
					return "<PLUG>(comment_toggle_blockwise_count)"
				end
			end, {
				expr = true,
				desc = "[plugin/comment]: block comment current line",
			})

			MAP(
				"x",
				"<C-c><C-c>",
				"<PLUG>(comment_toggle_linewise_visual)",
				{ desc = "[plugin/comment]: linewise visual commenting" }
			)
			MAP(
				"x",
				"<C-x><C-x>",
				"<PLUG>(comment_toggle_blockwise_visual)",
				{ desc = "[plugin/comment]: blockwise visual commenting" }
			)
		end,
	},

	-- highlighting for special comment tags
	{
		"folke/todo-comments.nvim",
		name = "todo-comments",
		dependencies = "plenary",
		config = function()
			local todo_comments = require("todo-comments")
			todo_comments.setup()

			NMAP(
				"<leader>tq",
				vim.cmd.TodoQuickFix,
				{ desc = "[plugin/todo-comments]: show comments in qf list" }
			)
			NMAP(
				"]t",
				todo_comments.jump_next,
				{ desc = "[plugin/todo-comments]: jump to next comment" }
			)
			NMAP(
				"[t",
				todo_comments.jump_prev,
				{ desc = "[plugin/todo-comments]: jump to previous comment" }
			)
		end,
	},

	-- navigable undo history tree
	{
		"mbbill/undotree",
		name = "undotree",
		init = function()
			vim.g.undotree_DiffCommand = "FC"
			vim.g.undotree_WindowLayout = 2
			vim.g.undotree_SplitWidth = 40
			vim.g.undotree_SetFocusWhenToggle = 1
		end,
		config = function()
			NMAP(
				"<leader>u",
				vim.cmd.UndotreeToggle,
				{ desc = "[plugin/undotree]: toggle undo history tree" }
			)
		end,
	},

	-- color picker
	{
		"uga-rosa/ccc.nvim",
		name = "color-picker",
		config = function()
			require("ccc").setup()

			NMAP(
				"<leader>cp",
				vim.cmd.CccPick,
				{ desc = "[plugin/color-picker]: pick a color" }
			)
			NMAP(
				"<leader>ch",
				vim.cmd.CccHighlighterToggle,
				{ desc = "[plugin/color-picker]: toggle color highlighting" }
			)
			NMAP(
				"<leader>cc",
				vim.cmd.CccConvert,
				{ desc = "[plugin/color-picker]: convert color" }
			)
		end,
	},
}

--[[ essential and efficient tools ]]

return {
	-- buffer switcher
	{
		"ThePrimeagen/harpoon",
		name = "harpoon",
		branch = "harpoon2",
		dependencies = "plenary",
		config = function()
			local harpoon = require("harpoon")

			harpoon:setup({
				settings = {
					save_on_toggle = true,
					sync_on_ui_close = true,
				},
			})

			-- general harpoon functions
			NMAP("<leader>H", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "[plugin/harpoon]: open harpoon list" })
			NMAP("<leader>h", function()
				harpoon:list():add()
			end, { desc = "[plugin/harpoon]: add file to harpoon list" })

			-- harpoon files navigation
			NMAP("<leader>1", function()
				harpoon:list():select(1)
			end, { desc = "[plugin/harpoon]: open file number 1" })
			NMAP("<leader>2", function()
				harpoon:list():select(2)
			end, { desc = "[plugin/harpoon]: open file number 2" })
			NMAP("<leader>3", function()
				harpoon:list():select(3)
			end, { desc = "[plugin/harpoon]: open file number 3" })
			NMAP("<leader>4", function()
				harpoon:list():select(4)
			end, { desc = "[plugin/harpoon]: open file number 4" })
			NMAP("<leader>5", function()
				harpoon:list():select(5)
			end, { desc = "[plugin/harpoon]: open file number 5" })
			NMAP("]h", function()
				harpoon:list():next()
			end, { desc = "[plugin/harpoon]: go to next file in list" })
			NMAP("[h", function()
				harpoon:list():prev()
			end, { desc = "[plugin/harpoon]: go to previous file in list" })

			-- list and select harpoon actions
			AMAP("<leader>ha", {
				["menu"] = function()
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				["add"] = function()
					harpoon:list():add()
				end,
				["select"] = function()
					vim.ui.input({
						prompt = "selection number: ",
					}, function(sn)
						if sn and sn:match("^%-?%d+$") then
							harpoon:list():select(tonumber(sn))
						end
					end)
				end,
				["next"] = function()
					-- parameters not needed
					---@diagnostic disable-next-line: missing-parameter
					harpoon:list().next()
				end,
				["prev"] = function()
					-- parameters not needed
					---@diagnostic disable-next-line: missing-parameter
					harpoon:list().prev()
				end,
			}, { desc = "[plugin/harpoon]: choose from harpoon actions" })
		end,
	},

	-- fuzzy finder, picker and some other cool utilities
	{
		"folke/snacks.nvim",
		name = "snacks",
		priority = 500, -- second highest priority
		init = function()
			vim.g.snacks_animate = false
		end,
		config = function()
			-- set up snacks and enable recquired features
			local snacks = require("snacks")
			snacks.setup({
				bigfile = { enabled = true },
				dashboard = { enabled = false },
				explorer = { enabled = false },
				image = { enabled = false },
				indent = { enabled = false },
				input = { enabled = true },
				notifier = { enabled = false },
				picker = {
					enabled = true,
					win = {
						input = {
							keys = {
								["<C-p>"] = {
									"toggle_preview",
									mode = { "i", "n" },
								},
							},
						},
						list = {
							keys = {
								["<C-p>"] = "toggle_preview",
							},
						},
					},
				},
				quickfile = { enabled = true },
				scope = { enabled = false },
				scroll = { enabled = false },
				statuscolumn = { enabled = false },
				words = {
					enabled = false,
					debounce = 0,
				},
				terminal = {
					start_insert = false,
					auto_insert = false,
					auto_close = true,
				},
			})

			-- invoke lsp action on file rename via oil.nvim
			vim.api.nvim_create_autocmd("User", {
				group = AUGRP,
				pattern = "OilActionsPost",
				callback = function(event)
					if event.data.actions.type == "move" then
						snacks.rename.on_rename_file(
							event.data.actions.src_url,
							event.data.actions.dest_url
						)
					end
				end,
			})

			-- search, find and picker keymaps
			NMAP(
				"<leader>/",
				snacks.picker.lines,
				{ desc = "[plugin/snacks]: search in buffer" }
			)
			NMAP(
				"<leader>?",
				snacks.picker.search_history,
				{ desc = "[plugin/snacks]: search history" }
			)
			MAP(
				{ "n", "x" },
				"<leader>*",
				snacks.picker.grep_word,
				{ desc = "[plugin/snacks]: grep word under cursor" }
			)
			NMAP(
				"q:",
				snacks.picker.command_history,
				{ desc = "[plugin/snacks]: command history" }
			)
			NMAP(
				"<leader>ff",
				snacks.picker.files,
				{ desc = "[plugin/snacks]: find files" }
			)
			NMAP("<leader>FF", function()
				snacks.picker.files({
					hidden = true,
					ignored = true,
				})
			end, {
				desc = "[plugin/snacks]: find files hidden/ignored inclusive",
			})
			NMAP("<leader>FI", function()
				snacks.picker.files({
					ignored = true,
				})
			end, { desc = "[plugin/snacks]: find files ignored inclusive" })
			NMAP("<leader>FH", function()
				snacks.picker.files({
					hidden = true,
				})
			end, { desc = "[plugin/snacks]: find files hidden inclusive" })
			NMAP("<leader>fc", function()
				snacks.picker.files({
					cwd = vim.fn.stdpath("config"),
				})
			end, { desc = "[plugin/snacks]: find config files" })
			NMAP(
				"<leader>fr",
				snacks.picker.recent,
				{ desc = "[plugin/snacks]: find recent files" }
			)
			NMAP(
				"<leader>fk",
				snacks.picker.keymaps,
				{ desc = "[plugin/snacks]: find keymaps" }
			)
			NMAP(
				"<leader>gg",
				snacks.picker.grep,
				{ desc = "[plugin/snacks]: global grep" }
			)
			NMAP(
				"<leader>fh",
				snacks.picker.help,
				{ desc = "[plugin/snacks]: search or find in help pages" }
			)
			NMAP(
				"<leader>fq",
				snacks.picker.qflist,
				{ desc = "[plugin/snacks]: search or find in quick fix list" }
			)
			NMAP(
				"<leader>fl",
				snacks.picker.loclist,
				{ desc = "[plugin/snacks]: search or find in loc list" }
			)

			-- choose snacks pickers
			AMAP("<leader>sp", {
				["explorer"] = snacks.explorer,
				["smart"] = snacks.picker.smart,
				["find-buffers"] = snacks.picker.buffers,
				["find-config"] = function()
					snacks.picker.files({ cwd = vim.fn.stdpath("config") })
				end,
				["find-projects"] = snacks.picker.projects,
				["grep-buffers"] = snacks.picker.grep_buffers,
				["git-files"] = snacks.picker.git_files,
				["git-branches"] = snacks.picker.git_branches,
				["git-log"] = snacks.picker.git_log,
				["git-logline"] = snacks.picker.git_log_line,
				["git-status"] = snacks.picker.git_status,
				["git-stash"] = snacks.picker.git_stash,
				["git-diff"] = snacks.picker.git_diff,
				["git-logfile"] = snacks.picker.git_log_file,
				["search-registers"] = snacks.picker.registers,
				["search-autocmds"] = snacks.picker.autocmds,
				["search-commands"] = snacks.picker.commands,
				["search-diagnostics"] = snacks.picker.diagnostics,
				["search-diag-buff"] = snacks.picker.diagnostics_buffer,
				["search-highlights"] = snacks.picker.highlights,
				["search-keymaps"] = snacks.picker.keymaps,
				["search-undo"] = snacks.picker.undo,
				["search-man"] = snacks.picker.man,
				["search-lazy"] = snacks.picker.lazy,
			}, { desc = "[plugin/snacks]: choose snacks picker" })

			-- words keymaps
			NMAP(
				"<leader>wo",
				snacks.words.enable,
				{ desc = "[plugin/snacks]: enable words" }
			)
			NMAP(
				"<leader>WO",
				snacks.words.disable,
				{ desc = "[plugin/snacks]: disable words" }
			)
			NMAP("<C-l>", function()
				vim.cmd("mode")
				vim.cmd("redraw!")
				vim.cmd("nohlsearch")
				snacks.words.clear()
			end, { desc = "[plugin/snacks]: clear words" })
			NMAP("]w", function()
				snacks.words.jump(vim.v.count1, true)
			end, { desc = "[plugin/snacks]: jump to next reference" })
			NMAP("[w", function()
				snacks.words.jump(-vim.v.count1, true)
			end, { desc = "[plugin/snacks]: jump to previous reference" })

			-- terminal keymaps
			NMAP(
				"<leader>tt",
				snacks.terminal.toggle,
				{ desc = "[plugin/snacks]: toggle terminal window" }
			)
			NMAP(
				"<leader>to",
				snacks.terminal.open,
				{ desc = "[plugin/snacks]: open a terminal window" }
			)

			-- zen mode keymaps
			NMAP(
				"<leader>zt",
				snacks.zen.zen,
				{ desc = "[plugin/snacks]: toggle zen mode" }
			)
			NMAP(
				"<leader>zz",
				snacks.zen.zoom,
				{ desc = "[plugin/snacks]: toggle zen in zoom mode" }
			)

			-- snacks actions as list
			AMAP("<leader>sa", {
				["dim-enable"] = snacks.dim.enable,
				["dim-disable"] = snacks.dim.disable,
				["git-blame"] = snacks.git.blame_line,
				["git-browse"] = snacks.gitbrowse.open,
				["lazy-git"] = snacks.lazygit.open,
				["rename-file"] = snacks.rename.rename_file,
				["scratch-toggle"] = snacks.scratch,
				["scratch-select"] = snacks.scratch.select,
				["word-enable"] = snacks.words.enable,
				["word-disable"] = snacks.words.disable,
				["word-clear"] = snacks.words.clear,
				["word-jump"] = snacks.words.jump,
				["zen"] = snacks.zen,
				["zen-zoom"] = snacks.zen.zoom,
			}, { desc = "[plugin/snack]: choose from snacks actions" })
		end,
	},

	-- treesitter syntax highlighting for neovim
	{
		"nvim-treesitter/nvim-treesitter",
		name = "treesitter",
		build = ":TSUpdate",
		init = function(plugin)
			-- add to rtp and make it accessible
			require("lazy.core.loader").add_to_rtp(plugin)

			-- avoid issues by pre loading predicates
			require("nvim-treesitter.query_predicates")

			-- prefer parser installations via git
			require("nvim-treesitter.install").prefer_git = true
		end,
		config = function()
			-- the "missing-fields" are not necessary
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"vimdoc",
					"comment",
					"markdown",
					"markdown_inline",
				},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			})

			local cfgs = require("nvim-treesitter.parsers").get_parser_configs()
			for parser_name, parser_body in pairs(CONFIG.treesitter_parsers) do
				cfgs[parser_name] = parser_body
			end
		end,
	},
}

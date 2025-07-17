--[[ plugins related to the debug adapter protocol ]]

return {
	{
		"jay-babu/mason-nvim-dap.nvim",
		name = "mason-dap",
		dependencies = "dap",
		config = function()
			local mason_dap = require("mason-nvim-dap")
			local ensure_installed = {}
			local handlers = {
				function(config)
					mason_dap.default_setup(config)
				end,
			}

			for dap_name, handler in pairs(CONFIG.daps) do
				table.insert(ensure_installed, dap_name)

				if handler then
					handlers[dap_name] = handler
				end
			end

			mason_dap.setup({
				ensure_installed = ensure_installed,
				automatic_installation = true,
				handlers = handlers,
			})

			local function setup_dap()
				local dap = require("dap")

				for _, dap_setup in ipairs(CONFIG.custom_daps) do
					local index = 1
					for name, opts in pairs(dap_setup) do
						if index == 1 then
							dap.adapters[name] = opts
						elseif index == 2 then
							dap.configurations[name] = opts
						end

						index = index + 1
					end
				end
			end

			-- defer setting up dap to give mason-nvim-dap time to finalize
			vim.defer_fn(setup_dap, 10)
		end,
	},

	-- debug adapter
	{
		"mfussenegger/nvim-dap",
		name = "dap",
		dependencies = "mason",
		config = function()
			local dap = require("dap")

			NMAP(
				"<F1>",
				dap.toggle_breakpoint,
				{ desc = "[plugin/dap]: toggle breakpoint" }
			)
			NMAP("<F2>", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint Condition: "))
			end, { desc = "plugins/dap: set conditional breakpoint" })
			NMAP("<F3>", function()
				dap.set_breakpoint(
					nil,
					nil,
					vim.fn.input("Log Point Message: ")
				)
			end, { desc = "[plugin/dap]: set breakpoint with log message" })
			NMAP(
				"<F4>",
				dap.run_to_cursor,
				{ desc = "[plugin/dap]: run till line containing cursor" }
			)

			NMAP("<F5>", function()
				dap.ui.eval(nil, {
					enter = true,
				})
			end, { desc = "[plugin/dap]: evaluate variable under cursor" })

			NMAP("<leader>dr", dap.restart, { desc = "[plugin/dap]: restart" })
			NMAP("<F6>", dap.continue, { desc = "[plugin/dap]: continue" })
			NMAP("<F7>", dap.step_into, { desc = "[plugin/dap]: step into" })
			NMAP("<F8>", dap.step_over, { desc = "[plugin/dap]: step over" })
			NMAP("<F9>", dap.step_out, { desc = "[plugin/dap]: step out" })
			NMAP("<F10>", dap.step_back, { desc = "[plugin/dap]: step back" })
		end,
	},

	-- ui and components for dap
	{
		"theHamsta/nvim-dap-virtual-text",
		name = "dap-virtual-text",
	},
	{
		"LiadOz/nvim-dap-repl-highlights",
		name = "dap-repl-highlights",
		dependencies = "treesitter",
	},
	{
		"rcarriga/nvim-dap-ui",
		name = "dap_ui",
		dependencies = {
			"dap",
			"nio",
			"dap-virtual-text",
			"dap-repl-highlights",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()

			require("nvim-dap-virtual-text").setup({
				-- hides and sensitive tokens... just in case
				display_callback = function(variable)
					local name = string.lower(variable.name)
					local value = string.lower(variable.value)

					if
						name:match("secret")
						or name:match("api")
						or value:match("secret")
						or value:match("api")
					then
						return " ******"
					end

					if #variable.value > 15 then
						return " "
							.. string.sub(variable.value, 1, 15)
							.. "... "
					end

					return " " .. variable.value
				end,
			})

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.open()
			end

			NMAP(
				"<leader>dt",
				dapui.toggle,
				{ desc = "[plugin/dapui]: toggle the dap ui" }
			)
			NMAP("<leader>dr", function()
				dapui.open({ reset = true })
			end, { desc = "[plugin/dapui]: reset the dap ui" })
		end,
	},
}

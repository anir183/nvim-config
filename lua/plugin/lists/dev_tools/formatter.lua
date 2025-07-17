--[[ plugin for auto file formatting ]]

return {
	"stevearc/conform.nvim",
	name = "conform",
	dependencies = "mason-tool-installer",
	config = function()
		local conform = require("conform")

		-- on failure, try again 3 times before finally giving up
		local function format(from_keymap, count)
			if not count or count < 1 then
				count = 0
				if from_keymap then
					vim.notify("Starting Format!")
				end
			end

			conform.format({
				async = true,
				quiet = true,
			}, function(err, did_edit)
				-- formatting successful
				if not err then
					if did_edit then
						vim.notify("Formatted File!")
						vim.cmd("w")
					elseif from_keymap then
						vim.notify("No formatting required!")
					end

				-- formatting unsuccessful, retry unless exceeded limit
				else
					if count <= 3 then
						format(from_keymap, count + 1)
					else
						vim.notify("Could not format!\n" .. err)
					end
				end
			end)
		end

		conform.setup({
			formatters_by_ft = CONFIG.formatters,
			formatters = CONFIG.custom_formatters,
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			group = AUGRP,
			callback = function()
				format(false)
			end,
		})

		MAP({ "n", "v" }, "<leader>fm", function()
			format(true)
		end, { desc = "[plugin/conform]: format file or selection" })
	end,
}

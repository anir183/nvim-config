--[[ initialize plugins with lazy plugin manager ]]

local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- install lazy and add to runtime path
if not (vim.uv or vim.loop).fs_stat(lazy_path) then
	local git_output = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazy_path,
	})

	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone Lazy.nvim:\n", "ErrorMsg" },
			{ git_output, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt_global.rtp:prepend(lazy_path)

-- plugin actions keymap
AMAP = function(map, commands, ...)
	NMAP(map, function()
		local ch_funcs = commands

		local ch_list = {}
		for key, _ in pairs(ch_funcs) do
			table.insert(ch_list, key)
		end

		vim.ui.select(ch_list, {
			prompt = "choose action",
		}, function(ch)
			if not ch then
				return
			end

			local func = ch_funcs[ch]
			if not func then
				print("error: command does not have a function")
				return
			end

			func()
		end)
	end, ...)
end

-- setup lazy.nvim
require("lazy").setup(CONFIG.test_plugins or {
	spec = {
		{ import = "plugin.lists" },
		{ import = "plugin.lists.dev_tools" },
		CONFIG.plugins,
	},
	-- disable lua rocks support
	rocks = {
		enabled = false,
	},
	-- check for updates but dont notify
	checker = {
		enabled = true,
		notify = false,
	},
	-- check for changes but dont notify
	change_detection = {
		enabled = true,
		notify = false,
	},
})

NMAP("<leader>lz", vim.cmd.Lazy, { desc = "[plugin/lazy]: open lazy" })

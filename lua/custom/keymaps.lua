--[[ keymaps built with core functions but create new functionality ]]

-- toggle relative line number
NMAP("<leader>rl", function()
	vim.opt.relativenumber = not vim.opt.relativenumber._value
end, { desc = "[custom]: toggle relative line numbers" })

-- toggle fold column
NMAP("zt", function()
	local fc = vim.opt.foldcolumn._value
	vim.opt.foldcolumn = fc == "0" and "auto:9" or "0"
end, { desc = "[custom]: toggle fold column" })

-- edit options in a popup
NMAP(
	"<leader>op",
	"<CMD>" .. CONFIG.cmd_pre .. "EditOptions<CR>",
	{ desc = "[custom]: edit configurations" }
)

-- change color column
NMAP("<leader>cl", function()
	vim.ui.input({
		prompt = "color column pos: ",
	}, function(input)
		if not input then
			return
		end

		vim.opt.colorcolumn = input
	end)
end, { desc = "[custom]: change the color column position" })

-- change indentation style
NMAP(
	"<leader>in",
	"<CMD>" .. CONFIG.cmd_pre .. "ChangeIndent<CR>",
	{ desc = "[custom]: change indentation style without reindenting" }
)

-- toggle cursor movement
NMAP("<leader>lc", function()
	vim.opt.scrolloff = 999 - vim.opt.scrolloff._value
end, { desc = "[custom]: toggle between moving text or moving cursor" })

-- substitute standalone words or substrings
NMAP(
	"<leader>sb",
	"<CMD>" .. CONFIG.cmd_pre .. "SubstituteWord<CR>",
	{ desc = "[custom]: substitute a string (even non-standalone)" }
)

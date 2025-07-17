--[[ making netrw usable as a sidebar explorer ]]

vim.g.netrw_winsize = 17 -- netrw window size when not in fullscreen mode

-- netrw toggling
local is_netrw_sidebar_open = false
local toggle_netrw_sidebar = function()
	if vim.bo.filetype == "netrw" and not is_netrw_sidebar_open then
		return
	end

	if not is_netrw_sidebar_open then
		vim.g.netrw_banner = 0
		vim.cmd("Lexplore %:p:h")
	else
		vim.cmd("Lexplore")
		vim.g.netrw_banner = 1

		-- NOTE : using lexplore changes this value but does not reset it
		--        and so it needs to be manually reset
		vim.g.netrw_chgwin = -1
	end

	is_netrw_sidebar_open = not is_netrw_sidebar_open
end
local toggle_netrw_fullscreen = function()
	if is_netrw_sidebar_open then
		vim.cmd("Lexplore")
		vim.g.netrw_banner = 1
		vim.g.netrw_chgwin = -1
		is_netrw_sidebar_open = false
	end

	if vim.bo.filetype == "netrw" then
		vim.cmd("Rexplore")
	else
		vim.cmd("Explore")
	end
end

-- creating command
vim.api.nvim_create_user_command(
	"Sbex",
	toggle_netrw_sidebar,
	{ desc = "[custom]: toggle netrw sidebar" }
)
vim.api.nvim_create_user_command(
	"Ex",
	toggle_netrw_fullscreen,
	{ desc = "[custom]: toggle netrw fullscreen" }
)

-- creating keymaps
NMAP(
	"<leader>e",
	toggle_netrw_sidebar,
	{ desc = "[custom]: toggle netrw sidebar" }
)
NMAP(
	"<leader>E",
	toggle_netrw_fullscreen,
	{ desc = "[custom]: toggle netrw fullscreen" }
)

--[[ setting up some autocommands ]]

local aucmd = vim.api.nvim_create_autocmd

-- disable color column in netrw and help pages
aucmd("FileType", {
	group = AUGRP,
	pattern = { "netrw", "help" },
	callback = function()
		vim.opt_local.colorcolumn = "0"
		vim.opt_local.statuscolumn = "%s"
		vim.opt_local.statusline = nil
	end,
})

-- highlight yanked text
aucmd("TextYankPost", {
	group = AUGRP,
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 50,
		})
	end,
})

-- disable number column when in netrw
aucmd({
	"WinEnter",
	"FocusGained",
	"BufReadPre",
	"FileReadPre",
}, {
	group = AUGRP,
	pattern = { "netrw" },
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
	end,
})

-- set leadmultispace on file load or focus
aucmd("BufWinEnter", {
	group = AUGRP,
	callback = function()
		local repval = vim.opt_local.tabstop._value - 1
		vim.opt_local.listchars:append({
			leadmultispace = "▎" .. ("∙"):rep(repval),
		})
	end,
})

-- make and load views to retain folds
aucmd({
	"BufWritePre",
	"BufWinLeave",
	"BufLeave",
}, {
	group = AUGRP,
	command = "silent! mkview",
})
aucmd("BufWinEnter", {
	group = AUGRP,
	command = "silent! loadview",
})

-- execute when config is loaded
aucmd("VimEnter", {
	group = AUGRP,
	callback = CONFIG.after,
})

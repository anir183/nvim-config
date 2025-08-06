--[[ custom statusline formatting ]]

-- remove statusline background
local hl = vim.api.nvim_set_hl
hl(0, "StatusLine", { bg = "none" })
hl(0, "StatusLineNC", { bg = "none" })
hl(0, "StatusLineTerm", { bg = "none" })
hl(0, "StatusLineTermNC", { bg = "none" })

local mode_strs = {
	["n"] = " normal ",
	["niI"] = " insert [normal] ",
	["niR"] = " replace [normal] ",
	["nt"] = " terminal [normal] ",
	["i"] = " insert ",
	["R"] = " replace ",
	["v"] = " visual ",
	["V"] = " visual [line] ",
	[""] = " visual [block] ",
	["c"] = " command ",
	["!"] = " command [external] ",
	["t"] = " terminal ",
}

-- components used in the statusline
local fmt_str = "%%#%s#%s%%*" -- format string
STLN_CMPNTS = {
	filename = function()
		return fmt_str:format("Dictionary", " %t ")
	end,

	position = function()
		return fmt_str:format("CursorLine", " %l:$-c ~ %2p%% ")
	end,

	mode = function()
		local mode = mode_strs[vim.fn.mode()]
		return fmt_str:format("IncSearch", mode)
	end,

	indent = function()
		local type = vim.opt_local.expandtab._value and "spaces" or "tabs"
		local len = vim.opt_local.tabstop._value

		return fmt_str:format(
			"CursorLineNr",
			("[" .. type .. " : " .. len .. "] ")
		)
	end,

	warnings = function()
		local count = vim.diagnostic.count(0)[vim.diagnostic.severity.WARN]
		return fmt_str:format("DiagnosticWarn", " " .. (count or ""))
	end,

	errors = function()
		local count = vim.diagnostic.count(0)[vim.diagnostic.severity.ERROR]
		count = count and " " .. count or " "
		return fmt_str:format("DiagnosticError", count)
	end,
}

-- create statusline format
local cmpnt = function(cmp_name)
	return "%{%v:lua.STLN_CMPNTS." .. cmp_name .. "()%}"
end
vim.opt_global.statusline = table.concat({
	-- left
	cmpnt("mode"),
	cmpnt("warnings"),
	cmpnt("errors"),
	"%r",
	"%w",
	"%h",
	"%m",

	"%=",

	-- right
	cmpnt("filename"),
	cmpnt("indent"),
	cmpnt("position"),
}, "")

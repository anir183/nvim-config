--[[ keymaps or remaps to base neovim command or functions ]]

vim.g.mapleader = " "
vim.g.maplocalleader = "//"

NMAP("<leader>ms", vim.cmd.messages, { desc = "[base]: open messages window" })

-- moving text
-- WARNING : using "<cmd>" instead of ":" breaks these commands
NMAP(
	"<C-j>",
	"v:m '>+1<CR>gv=<ESC>",
	{ desc = "[base]: move the current line up" }
)
NMAP(
	"<C-k>",
	"v:m '<-2<CR>gv=<ESC>",
	{ desc = "[base]: move the current line down" }
)
MAP(
	"v",
	"<C-j>",
	":m '>+1<CR>gv=<ESC>gv",
	{ desc = "[base]: move current selection up" }
)
MAP(
	"v",
	"<C-k>",
	":m '<-2<CR>gv=<ESC>gv",
	{ desc = "[base]: move current selection down" }
)

-- stationary cursor
NMAP(
	"J",
	"mzJ`z",
	{ desc = "[base]: dont move the cursor when joining next line" }
)
NMAP(
	"<C-d>",
	"<C-d>zz",
	{ desc = "[base]: keep cursor centered when scrolling down" }
)
NMAP(
	"<C-u>",
	"<C-u>zz",
	{ desc = "[base]: keep cursor centered when scrolling up" }
)
NMAP(
	"n",
	"nzzzv",
	{ desc = "[base]: keep cursor centered when navigating search results" }
)
NMAP(
	"N",
	"Nzzzv",
	{ desc = "[base]: keep cursor centered when navigating search results" }
)

-- modification or extensions of existing keymaps
MAP({ "n", "v" }, "x", "\"_x", { desc = "[base]: remove without copying" })
MAP(
	"x",
	"<leader>p",
	"\"_dP",
	{ desc = "[base]: paste over selection without copying" }
)
MAP(
	{ "n", "v" },
	"<leader>y",
	"\"+y",
	{ desc = "[base]: yank to system clipboard" }
)
NMAP(
	"<leader>Y",
	"\"+Y",
	{ desc = "[base]: yank till end of line to system clipboard" }
)
MAP(
	{ "n", "v" },
	"<leader>d",
	"\"_d",
	{ desc = "[base]: delete without copying" }
)
NMAP(
	"<leader>D",
	"\"_D",
	{ desc = "[base]: delete till end of line without copying" }
)
MAP(
	{ "n", "v" },
	"<leader>c",
	"\"_c",
	{ desc = "delete and edit without copying" }
)
NMAP(
	"<leader>C",
	"\"_C",
	{ desc = "[base]: delete till eol and edit without copying" }
)

-- split resizing
NMAP("-", function()
	vim.cmd.wincmd("<")
end, { desc = "[base]: increase window width" })
NMAP("+", function()
	vim.cmd.wincmd(">")
end, { desc = "[base]: decrease window width" })
NMAP("<leader>-", function()
	vim.cmd.wincmd("-")
end, { desc = "[base]: increase window height" })
NMAP("<leader>+", function()
	vim.cmd.wincmd("+")
end, { desc = "[base]: decrease window height" })

-- quick fix list
NMAP("<leader>q", vim.cmd.copen, { desc = "[base]: open the quick fix list" })
NMAP("<leader>Q", vim.cmd.ccl, { desc = "[base]: close the quick fix list" })
NMAP("]q", vim.cmd.cnext, { desc = "[base]: walk forward in quick fix list" })
NMAP("[q", vim.cmd.cprev, { desc = "[base]: walk backward in quick fix list" })

-- location list
NMAP("<leader>l", vim.cmd.lopen, { desc = "[base]: open the location list" })
NMAP("<leader>L", vim.cmd.lcl, { desc = "[base]: close the location list" })
NMAP("]l", vim.cmd.lnext, { desc = "[base]: walk forward in location list" })
NMAP("[l", vim.cmd.lprev, { desc = "[base]: walk backward in location list" })

-- lsp keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	group = AUGRP,
	callback = function()
		NMAP(
			"<leader>rn",
			vim.lsp.buf.rename,
			{ desc = "[base/lsp]:  rename symbol" }
		)
		NMAP(
			"<leader>ic",
			vim.lsp.buf.incoming_calls,
			{ desc = "[base/lsp]: incoming calls" }
		)
		NMAP(
			"<leader>oc",
			vim.lsp.buf.outgoing_calls,
			{ desc = "[base/lsp]: outgoing calls" }
		)
		NMAP(
			"<leader>ds",
			vim.lsp.buf.document_symbol,
			{ desc = "[base/lsp]: document symbol" }
		)
		MAP(
			{ "n", "x" },
			"<leader>ca",
			vim.lsp.buf.code_action,
			{ desc = "[base/lsp]: open code actions" }
		)
		NMAP(
			"gD",
			vim.lsp.buf.declaration,
			{ desc = "[base/lsp]: goto declaration" }
		)
		NMAP(
			"gd",
			vim.lsp.buf.definition,
			{ desc = "[base/lsp]: goto definition" }
		)
		NMAP(
			"gr",
			vim.lsp.buf.references,
			{ desc = "[base/lsp]: get references" }
		)
		NMAP(
			"gi",
			vim.lsp.buf.implementation,
			{ desc = "[base/lsp]: get implementations" }
		)
	end,
})

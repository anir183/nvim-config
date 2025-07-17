--[[ only important keymaps ]]

vim.g.mapleader = " "
vim.g.maplocalleader = "//"

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

-- quick fix list
NMAP("<leader>q", vim.cmd.copen, { desc = "[base]: open the quick fix list" })
NMAP("<leader>Q", vim.cmd.ccl, { desc = "[base]: close the quick fix list" })
NMAP("]q", vim.cmd.cnext, { desc = "[base]: walk forward in quick fix list" })
NMAP("[q", vim.cmd.cprev, { desc = "[base]: walk backward in quick fix list" })

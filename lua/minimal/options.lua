--[[ setting neovim options ]]

local opt = vim.opt_global

-- status column
opt.number = true
opt.relativenumber = true
opt.signcolumn = "number" -- shows signs in number column

-- text wrapping
opt.wrap = false
opt.textwidth = 0
opt.colorcolumn = "81"

-- cursor movement
opt.whichwrap:append("h")
opt.whichwrap:append("l")

-- indentations
opt.expandtab = false -- use tabs instead of spaces
opt.tabstop = 4 -- spaces in a tab
opt.shiftwidth = 0 -- spaces in each level of indentation (0 = tabstop)
opt.softtabstop = -1 -- spaces in a tab in insert mode (-1 = shiftwidth)
opt.autoindent = true -- auto indent new lines based on current
opt.smartindent = true -- indent based on context

-- editor options
opt.updatetime = 250
opt.termguicolors = true
opt.splitright = true -- create vertical splits on right
opt.splitbelow = true -- create horizontal splits below
opt.showmode = false -- dont show mode in command line
opt.scrolloff = 8
opt.ruler = false

-- tools
opt.ignorecase = true -- ignore case while searching
opt.smartcase = true -- ignore case when search input is in lowercase
opt.completeopt = { "menu", "menuone", "noselect", "preview" }
opt.inccommand = "split" -- preview off screen matches in a popup
opt.wrapscan = true
opt.jumpoptions = "stack,view" -- makes jumping around consistent (https://www.reddit.com/r/neovim/comments/1cytkbq/comment/l7cqdmq)

-- backup and history
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile = true

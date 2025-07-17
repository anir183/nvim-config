--[[ things dealing with core neovim stuff without major changes ]]

require("base.options")
require("base.keymap")
require("base.autocmds")

vim.filetype.add(CONFIG.additional_filetypes)

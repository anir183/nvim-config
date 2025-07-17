-- load configurations
CONFIG = vim.tbl_deep_extend(
	"force",
	require("defaults"),
	pcall(require, "config") and require("config") or {}
)

-- augroup for custom autocommands
AUGRP = vim.api.nvim_create_augroup("183_augroup", { clear = true })

-- keymap functions
MAP = vim.keymap.set
NMAP = function(...)
	MAP("n", ...)
end

-- when opened in vscode via vscode-neovim extension
if vim.g.vscode then
	print("Launched in VSCode Mode")
	require("vscode")
	return
end

-- when opened in minimal mode
if vim.g.MINIMAL or CONFIG.minimal_mode then
	print("Launched in Minimal Mode")
	require("minimal")
	return
end

-- normal configurations
require("base")
require("custom")
require("plugin")

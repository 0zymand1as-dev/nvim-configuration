-- Map Leader:
vim.g.maplocalleader = " "
vim.g.mapleader = " "

-- Line relative numbers:
vim.opt.relativenumber = true

-- Enable 24-bit RGB colors in the terminal
vim.opt.termguicolors = true

-- Load theme from kitty config:
local theme = require("utils.load_color_theme")
local path = vim.fn.expand("~/.config/kitty/theme.conf")
local kitty_colors = theme.load_kitty_theme(path)
theme.apply_to_nvim(kitty_colors)

-- Indentation config:
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Inline errors:
vim.diagnostic.config({
	virtual_text = {
		prefix = "<>", -- Error icon
	},
	signs = true,
	underline = true,
})

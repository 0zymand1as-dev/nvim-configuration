-- Map Leader:
vim.g.maplocalleader = " "
vim.g.mapleader = " "

-- Disable Ctrl+Z in all modes to prevent accidental suspending of Neovim:
vim.keymap.set({ "n", "v", "i" }, "<C-z>", "<Nop>")

-- Line relative numbers:
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable 24-bit RGB colors in the terminal
vim.opt.termguicolors = true

-- Load theme from kitty config:
local theme = require("utils.load_color_theme")
theme.reload()

-- Global padding border:
vim.opt.fillchars = {
  vert = "│",
  horiz = "─",
  horizup = "┬",
  horizdown = "┴",
  vertleft = "├",
  vertright = "┤",
  verthoriz = "┼",
}

-- Indentation config:
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Inline errors:
vim.diagnostic.config({
  virtual_text = {
    wrap = true,
    spacing = 0,
    max_width = 80,
    prefix = " ", -- Error icon
  },
  float = {
    focusable = false,
    source = "always",
    wrap = true,
    max_width = 80,
    border = "rounded",
  },
  signs = true,
  underline = true,
})

vim.highlight.priorities.semantic_tokens = 95

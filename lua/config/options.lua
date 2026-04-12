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


-- Autosave options
local state = vim.fn.stdpath("state")
vim.fn.mkdir(state .. "/undo", "p")
vim.fn.mkdir(state .. "/swap", "p")
vim.fn.mkdir(state .. "/backup", "p")

vim.opt.undofile = true
vim.opt.undodir = state .. "/undo//"

vim.opt.swapfile = true
vim.opt.directory = state .. "/swap//"

vim.opt.backup = true
vim.opt.backupdir = state .. "/backup//"

vim.opt.autowrite = true
vim.opt.autowriteall = true
vim.opt.updatetime = 1000

vim.api.nvim_create_autocmd("FocusLost", {
  callback = function()
    vim.cmd("silent! wall")
  end,
})

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  callback = function()
    if vim.bo.modified then
      vim.cmd("silent! write")
    end
  end,
})


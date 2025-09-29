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
local path = vim.fn.expand("~/.config/kitty/theme.conf")

-- Safely load the theme from kitty config file
local file = io.open(path, "r")
if file then
	file:close() -- Close the file handle immediately after checking
	local ok, err = pcall(function()
		local kitty_colors = theme.load_kitty_theme(path)
		theme.apply_to_nvim(kitty_colors)
	end)
	if not ok then
		vim.g.color_theme_loaded = false
		vim.notify("Error loading kitty theme: " .. err, vim.log.levels.ERROR)
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#2c313a" })
	else
		vim.g.color_theme_loaded = true
	end
else
	vim.g.color_theme_loaded = false
	vim.notify("Kitty theme file not found at " .. path .. ". Using default colors.", vim.log.levels.WARN)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#2c313a" })
end

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
    prefix = "<>", -- Error icon
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

-- Auto-format on save for Rust files
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})


vim.highlight.priorities.semantic_tokens = 95

return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		config = function()
			local highlight

			if vim.g.color_theme_loaded == false then
				highlight = { "Comment" }
			else
				highlight = {
					"RainbowCyan",
					"RainbowYellow",
					"RainbowBlue",
					"RainbowOrange",
					"RainbowGreen",
					"RainbowViolet",
				}
			end

			require("ibl").setup({
				indent = {
					char = "┊",
					highlight = highlight,
				},
				whitespace = {
					highlight = highlight,
					remove_blankline_trail = false,
				},
				scope = {
					enabled = true,
				},
				exclude = {
					filetypes = {
						"help",
						"alpha",
						"dashboard",
						"neo-tree",
						"Trouble",
						"trouble",
						"lazy",
						"mason",
						"notify",
						"toggleterm",
						"lazyterm",
					},
				},
			})

			vim.opt.list = true
			vim.opt.listchars = {
				tab = "┊ ",
				trail = "·",
				extends = "→",
				precedes = "←",
				nbsp = "␣",
			}

			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "*",
				callback = function()
					-- Usar uno de tus colores existentes para las tabulaciones
					vim.api.nvim_set_hl(0, "Whitespace", { fg = vim.g.terminal_color_8 or "#5c6370" })
					vim.api.nvim_set_hl(0, "NonText", { fg = vim.g.terminal_color_8 or "#5c6370" })
				end,
			})
		end,
	},
}

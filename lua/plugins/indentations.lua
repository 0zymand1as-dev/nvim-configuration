return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		config = function()
			-- Definir los colores highlight usando los que ya tienes configurados
			local highlight = {
				"RainbowCyan",
				"RainbowYellow",
				"RainbowBlue",
				"RainbowOrange",
				"RainbowGreen",
				"RainbowViolet",
			}

			-- Configurar el plugin
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

			-- Configurar listchars para mostrar tabulaciones
			vim.opt.list = true
			vim.opt.listchars = {
				tab = "┊ ",
				trail = "·",
				extends = "→",
				precedes = "←",
				nbsp = "␣",
			}

			-- Highlight para las tabulaciones visibles
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

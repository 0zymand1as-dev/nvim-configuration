return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = {
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          -- Scroll documentation hacia abajo
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          -- Mostrar completions manualmente
          ["<C-Space>"] = cmp.mapping.complete(),
          -- Cancelar completion
          ["<C-e>"] = cmp.mapping.abort(),
          -- Confirmar selección
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        },
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- For luasnip users.
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
}

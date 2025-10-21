return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				-- Formatters
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier.with({ extra_args = { "--bracket-same-line", "false" } }),
				null_ls.builtins.formatting.rustfmt,
			},
		})
	end,
}

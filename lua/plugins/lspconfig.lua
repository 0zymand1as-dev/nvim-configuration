return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- Debuggers
					"codelldb", -- C/C++/Rust debugger
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					-- Rust is handled by rustaceanvim, so no rust_analyzer here
					"clangd",
					"jsonls",
					"lua_ls",
					"pyright",
					"ts_ls",
					"vimls",
					"bacon_ls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Rust is handled by rustaceanvim plugin, so we skip rust_analyzer here

			lspconfig.jsonls.setup({
				capabilities = capabilities,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.vimls.setup({
				capabilities = capabilities,
			})
			lspconfig.bacon_ls.setup({
				init_options = {
					updateOnSave = true,
					updateOnSaveWaitMillis = 1000,
				},
				capabilities = capabilities,
			})
		end,
	},
}

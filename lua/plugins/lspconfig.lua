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
			require("mason-tool-installer").setup({ ensure_installed = { "codelldb" } })
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("mason-lspconfig").setup({
				ensure_installed = { "jsonls", "lua_ls", "vimls", "rust_analyzer" },
				handlers = {
					function(server_name)
						local opts = {
							capabilities = capabilities,
							update_in_insert = true,
						}

						if server_name == "rust_analyzer" then
							opts.settings = {
								["rust-analyzer"] = {
									checkOnSave = {
										enable = false,
									},
									check = {
										command = "clippy",
									},
									diagnostics = {
										enable = true,
										experimental = {
											enable = true,
										},
									},
								},
							}
						end

						require("lspconfig")[server_name].setup(opts)
					end,
				},
			})
		end,
	},
}

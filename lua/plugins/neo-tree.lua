return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	lazy = false, -- neo-tree will lazily load itself
	opts = {
		-- fill any relevant options here
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				hijack_netrw_behavior = "disabled",
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
			},
			open_files_do_not_replace_types = { "terminal", "trouble", "qf"},
		})

	end,
}

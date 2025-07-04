return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
	config = function()
		require("render-markdown").setup({
			headings = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
			code = {
				sign = false,
				width = "block",
				right_pad = 1,
			},
		})
	end,
}

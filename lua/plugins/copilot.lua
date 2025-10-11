return {
	"github/copilot.vim",
	config = function()
		vim.g.copilot_enabled = 0 -- Disable copilot by default
		vim.g.copilot_no_tab_map = true -- Disable default tab mapping
	end,
}

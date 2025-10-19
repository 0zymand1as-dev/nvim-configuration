local M = {}
M.error_hover = function()
	local float_opts = {
		focusable = false,
		close_events = { "BufLeave" },
		border = "rounded",
		source = "always",
	}
	local bufnr, winnr = vim.diagnostic.open_float(nil, float_opts)

	if winnr then
		vim.wo[winnr].winhighlight = "Normal:CustomHover,FloatBorder:CustomHoverBorder"

		vim.keymap.set("n", "<Esc>", function()
			if vim.api.nvim_win_is_valid(winnr) then
				vim.api.nvim_win_close(winnr, true)
			end
		end, { buffer = 0, silent = true })
	end
end
return M

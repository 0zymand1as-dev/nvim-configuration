local M = {}

function M.hover_with_controls()
	vim.lsp.buf.hover()

	local attempts = 0
	local max_attempts = 20

	local function check_hover_window()
		attempts = attempts + 1

		local hover_win = nil
		local wins = vim.api.nvim_list_wins()

		for _, win in ipairs(wins) do
			if vim.api.nvim_win_is_valid(win) then
				local config = vim.api.nvim_win_get_config(win)
				if config.relative ~= "" and config.relative ~= nil then
					local buf = vim.api.nvim_win_get_buf(win)
					local filetype = vim.bo[buf].filetype

					if filetype == "markdown" or vim.bo[buf].buftype == "nofile" then
						hover_win = win
						break
					end
				end
			end
		end

		if hover_win then
			local buf = vim.api.nvim_win_get_buf(hover_win)

			pcall(function()
				vim.bo[buf].modifiable = false
				vim.bo[buf].readonly = true
			end)

			vim.api.nvim_set_current_win(hover_win)

			local opts = { buffer = buf, silent = true, nowait = true }

			vim.keymap.set("n", "<Esc>", function()
				if vim.api.nvim_win_is_valid(hover_win) then
					vim.api.nvim_win_close(hover_win, true)
				end
			end, opts)

			vim.keymap.set("n", "q", function()
				if vim.api.nvim_win_is_valid(hover_win) then
					vim.api.nvim_win_close(hover_win, true)
				end
			end, opts)

			vim.keymap.set("n", "<C-c>", function()
				if vim.api.nvim_win_is_valid(hover_win) then
					vim.api.nvim_win_close(hover_win, true)
				end
			end, opts)
		elseif attempts < max_attempts then
			vim.defer_fn(check_hover_window, 10)
		end
	end

	vim.defer_fn(check_hover_window, 10)
end

return M

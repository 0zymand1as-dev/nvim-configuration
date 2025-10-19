local M = {}

function M.hover_with_controls()
	local bufnr = vim.api.nvim_get_current_buf()
	local win = vim.api.nvim_get_current_win()
	local clients = vim.lsp.get_clients({ bufnr = bufnr })

	if #clients == 0 then
		vim.notify("No LSP client attached", vim.log.levels.WARN)
		return
	end

	local shown = false
	local method = "textDocument/hover"

	for _, client in ipairs(clients) do
		if client.supports_method(method) then
			local offset_encoding = client.offset_encoding or "utf-16"
			local params = vim.lsp.util.make_position_params(win, offset_encoding)

			client.request(method, params, function(err, result, ctx)
				if err then
					vim.notify("LSP hover error: " .. tostring(err), vim.log.levels.ERROR)
					return
				end

				if shown then
					return
				end

				if not result or not result.contents then
					return
				end

				local lines = {}
				local contents = result.contents

				if type(contents) == "string" then
					for line in contents:gmatch("[^\r\n]+") do
						table.insert(lines, line)
					end
				elseif type(contents) == "table" then
					if contents.kind and contents.value then
						for line in contents.value:gmatch("[^\r\n]+") do
							table.insert(lines, line)
						end
					elseif contents[1] then
						for _, item in ipairs(contents) do
							if type(item) == "string" then
								for line in item:gmatch("[^\r\n]+") do
									table.insert(lines, line)
								end
							elseif type(item) == "table" and item.value then
								for line in item.value:gmatch("[^\r\n]+") do
									table.insert(lines, line)
								end
							end
						end
					end
				end

				if #lines == 0 then
					return
				end

				local hover_bufnr = vim.api.nvim_create_buf(false, true)

				vim.api.nvim_buf_set_lines(hover_bufnr, 0, -1, false, lines)
				vim.bo[hover_bufnr].modifiable = false
				vim.bo[hover_bufnr].bufhidden = "wipe"
				vim.bo[hover_bufnr].buftype = "nofile"
				vim.bo[hover_bufnr].filetype = "markdown"

				local max_width = 80
				local width = 0
				for _, line in ipairs(lines) do
					width = math.max(width, #line)
				end
				width = math.min(width, max_width)

				local height = math.min(#lines, 20)

				local cursor_pos = vim.api.nvim_win_get_cursor(win)
				local cursor_row = cursor_pos[1] - 1
				local cursor_col = cursor_pos[2]

				local win_pos = vim.api.nvim_win_get_position(win)
				local win_height = vim.api.nvim_win_get_height(win)

				local space_above = cursor_row
				local space_below = win_height - cursor_row - 1

				local row
				if space_below >= height + 1 then
					row = cursor_row + 1
				elseif space_above >= height + 1 then
					row = cursor_row - height - 1
				else
					if space_below > space_above then
						row = cursor_row + 1
						height = math.min(height, space_below - 1)
					else
						row = cursor_row - height - 1
						height = math.min(height, space_above - 1)
					end
				end

				local win_width = vim.api.nvim_win_get_width(win)
				local col = cursor_col
				if col + width > win_width then
					col = win_width - width
				end
				if col < 0 then
					col = 0
				end

				local float_opts = {
					relative = "win",
					win = win,
					width = width,
					height = height,
					row = row,
					col = col,
					style = "minimal",
					border = {
						{ "╭", "FloatBorder" },
						{ "─", "FloatBorder" },
						{ "╮", "FloatBorder" },
						{ "│", "FloatBorder" },
						{ "╯", "FloatBorder" },
						{ "─", "FloatBorder" },
						{ "╰", "FloatBorder" },
						{ "│", "FloatBorder" },
					},
					focusable = true,
				}

				local hover_win = vim.api.nvim_open_win(hover_bufnr, true, float_opts)

				vim.wo[hover_win].winhighlight = "Normal:CustomHover,FloatBorder:CustomHoverBorder"
				vim.wo[hover_win].wrap = true
				vim.wo[hover_win].linebreak = true

				local close_fn = function()
					if vim.api.nvim_win_is_valid(hover_win) then
						vim.api.nvim_win_close(hover_win, true)
					end
				end

				local map_opts = { buffer = hover_bufnr, silent = true, nowait = true }
				vim.keymap.set("n", "<Esc>", close_fn, map_opts)
				vim.keymap.set("n", "q", close_fn, map_opts)
				vim.keymap.set("n", "<C-c>", close_fn, map_opts)

				vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
					buffer = hover_bufnr,
					once = true,
					callback = close_fn,
				})

				shown = true
			end)

			break
		end
	end
end

return M

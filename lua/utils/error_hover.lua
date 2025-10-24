local M = {}

M.error_hover = function()
  local float_opts = {
    focusable = false,
    close_events = { "BufLeave", "InsertEnter" },
    border = "rounded",
    source = "always",
  }

  local bufnr, winnr = vim.diagnostic.open_float(nil, float_opts)

  if winnr and bufnr then
    vim.wo[winnr].winhighlight = "Normal:None,FloatBorder:Border2"

    local current_line = vim.api.nvim_win_get_cursor(0)[1]
    local current_buf = vim.api.nvim_get_current_buf()
    local autocmd_id = nil

    local close = function()
      if vim.api.nvim_win_is_valid(winnr) then
        vim.api.nvim_win_close(winnr, true)
      end

      pcall(vim.keymap.del, "n", "<Esc>", { buffer = current_buf })

      if autocmd_id then
        pcall(vim.api.nvim_del_autocmd, autocmd_id)
      end
    end

    vim.keymap.set("n", "<Esc>", close, { buffer = current_buf, silent = true, nowait = true })

    vim.api.nvim_create_autocmd("CursorMoved", {
      buffer = current_buf,
      callback = function()
        local new_line = vim.api.nvim_win_get_cursor(0)[1]
        if new_line ~= current_line then
          close()
          return true
        end
      end
    })
  end
end

return M

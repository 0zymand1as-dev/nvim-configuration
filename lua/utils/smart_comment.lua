local M = {}

function M.toggle_smart_comment()
  local mode = vim.api.nvim_get_mode().mode
  
  local ok, comment_api = pcall(require, 'Comment.api')
  if not ok then
    vim.notify('Comment.nvim no está disponible', vim.log.levels.ERROR)
    return
  end
  
  if mode == 'n' then
    comment_api.toggle.linewise.current()
  else
    comment_api.toggle.linewise.current()
  end
end

function M.toggle_visual_comment()
  local ok, comment_api = pcall(require, 'Comment.api')
  if not ok then
    vim.notify('Comment.nvim no está disponible', vim.log.levels.ERROR)
    return
  end
  
  comment_api.toggle.linewise(vim.fn.visualmode())
end

return M

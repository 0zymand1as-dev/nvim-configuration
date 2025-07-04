return {
  "github/copilot.vim", 
  config = function()
    vim.g.copilot_filetypes = {
      ["*"] = false,  -- Disable for all file types by default
      ["javascript"] = true,  -- Enable for JavaScript
      ["typescript"] = true,  -- Enable for TypeScript
      ["python"] = true,  -- Enable for Python
      ["lua"] = true,  -- Enable for Lua
    }

    vim.g.copilot_no_tab_map = true  -- Disable default tab mapping
  end,
}

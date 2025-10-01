return {
  "github/copilot.vim", 
  config = function()
    vim.g.copilot_filetypes = {
      ["*"] = false,  -- Disable for all file types by default
      ["javascript"] = true,  -- Enable for JavaScript
      ["typescript"] = true,  -- Enable for TypeScript
      ["python"] = true,  -- Enable for Python
      ["lua"] = true,  -- Enable for Lua
      ["go"] = true,  -- Enable for Go
      ["rust"] = true,  -- Enable for Rust
      ["java"] = true,  -- Enable for Java
      ["c"] = true,  -- Enable for C
      ["cpp"] = true,  -- Enable for C++
      ["html"] = true,  -- Enable for HTML
      ["css"] = true,  -- Enable for CSS
      ["markdown"] = true,  -- Enable for Markdown
    }

    vim.g.copilot_no_tab_map = true  -- Disable default tab mapping
  end,
}

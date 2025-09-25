-- lua/plugins/toggleterm.lua
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    direction = "float",
    float_opts = {
      border = "rounded",
      width = function()
        return math.floor(vim.o.columns * 0.8)
      end,
      height = function()
        return math.floor(vim.o.lines * 0.8)
      end,
    },
    -- This command is executed when the terminal is opened
    on_open = function(_)
      vim.cmd("startinsert!")
    end,
  },
}
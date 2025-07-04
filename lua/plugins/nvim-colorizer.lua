return {
  "norcalli/nvim-colorizer.lua",
  event = "VeryLazy",
  config = function()
    require("colorizer").setup({
      "*", -- Highlight all files, but customize some others.
    })
  end,

}

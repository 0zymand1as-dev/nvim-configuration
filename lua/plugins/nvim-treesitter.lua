return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",

  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua",
        "vim",
        "javascript",
        "html",
        "css",
        "c",
        "cpp",
        "rust",
        "toml",
        "vim",
        "java",
      },
      highlight = { enable = true },
      indent = { enable = true },
      additional_vim_regex_highlighting = false,
    })
  end,
}

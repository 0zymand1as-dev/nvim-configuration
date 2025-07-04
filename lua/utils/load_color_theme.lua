-- utils/color_theme.lua
local M = {}

function M.load_kitty_theme(path)
  local colors = {}
  for line in io.lines(path) do
    local key, val = line:match("^(%S+)%s+(#%x+)")
    if key and val then
      colors[key] = val
    end
  end
  return colors
end

function M.apply_to_nvim(colors)
  -- Nvim interface
  vim.api.nvim_set_hl(0, "Normal", { fg = colors["foreground"], bg = colors["background"] })
  vim.api.nvim_set_hl(0, "Cursor", { fg = colors["cursor_text_color"], bg = colors["cursor"] })
  vim.api.nvim_set_hl(0, "Visual", { fg = colors["selection_foreground"], bg = colors["selection_background"] })

  -- Syntax highlighting
  vim.api.nvim_set_hl(0, "Comment", { fg = colors["color8"], italic = true })
  vim.api.nvim_set_hl(0, "Identifier", { fg = colors["color3"] })
  vim.api.nvim_set_hl(0, "Statement", { fg = colors["color13"], bold = true })
  vim.api.nvim_set_hl(0, "Type", { fg = colors["color11"] })
  vim.api.nvim_set_hl(0, "Function", { fg = colors["color4"] })
  vim.api.nvim_set_hl(0, "String", { fg = colors["color15"] })
  vim.api.nvim_set_hl(0, "Character", { fg = colors["color15"] })
  vim.api.nvim_set_hl(0, "Number", { fg = colors["color14"] })
  vim.api.nvim_set_hl(0, "Float", { fg = colors["color6"] })
  vim.api.nvim_set_hl(0, "Boolean", { fg = colors["color10"] })
  vim.api.nvim_set_hl(0, "Operator", { fg = colors["color12"] })

  -- Syntax highlighting groups (Tree-sitter and LSP)
  vim.api.nvim_set_hl(0, "@function.call", { link = "Function" })
  vim.api.nvim_set_hl(0, "@keyword", { link = "Statement" })
  vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })
  vim.api.nvim_set_hl(0, "@type", { link = "Type" })
  vim.api.nvim_set_hl(0, "@storageclass", { link = "Type" })
  vim.api.nvim_set_hl(0, "@keyword.type", { link = "Statement" })
  vim.api.nvim_set_hl(0, "@variable", { link = "Identifier" })
  vim.api.nvim_set_hl(0, "@type.builtin", { fg = colors["color12"], bold = true })
  vim.api.nvim_set_hl(0, "@function.method", { fg = colors["color5"] })
  vim.api.nvim_set_hl(0, "@constant", { fg = colors["color7"], italic = true })
  vim.api.nvim_set_hl(0, "@character.special", { fg = colors["color14"] })
  vim.api.nvim_set_hl(0, "@string.escape", { fg = colors["color6"] })

  vim.api.nvim_set_hl(0, "SpecialChar", { fg = colors["color14"] })
  vim.api.nvim_set_hl(0, "@character", { fg = colors["color13"] })

  -- Rainbow Delimiters
  vim.api.nvim_set_hl(0, "RainbowCyan", { fg = colors["color6"] })
  vim.api.nvim_set_hl(0, "RainbowYellow", { fg = colors["color10"] })
  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = colors["color4"] })
  vim.api.nvim_set_hl(0, "RainbowOrange", { fg = colors["color11"] })
  vim.api.nvim_set_hl(0, "RainbowGreen", { fg = colors["color2"] })
  vim.api.nvim_set_hl(0, "RainbowRed", { fg = colors["color3"] })

  vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = colors["color4"] }) -- `,`, `;`, `:`
  vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = colors["color5"] })  -- `()`, `{}`, `[]`
  vim.api.nvim_set_hl(0, "@punctuation.special", { fg = colors["color7"] })  -- `...`, `::`, `->`
  vim.api.nvim_set_hl(0, "RainbowViolet", { fg = colors["color5"] })

  -- NeoTree
  vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = colors["color11"] })
  vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = colors["color10"] })
  vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = colors["foreground"] })
  vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = colors["color15"] })
  vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = colors["color12"], bold = true })
  vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = colors["color8"] })
  vim.api.nvim_set_hl(0, "NeoTreeSymbolicLinkTarget", { fg = colors["color14"] })
  vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = colors["background"] })

  -- Alpha
  vim.api.nvim_set_hl(0, "Directory", { fg = colors["color11"], bold = true })
  vim.api.nvim_set_hl(0, "AlphaHeader", { fg = colors["color4"], bold = true })
  vim.api.nvim_set_hl(0, "AlphaFooter", { fg = colors["color8"], italic = true })
  vim.api.nvim_set_hl(0, "AlphaButtons", { fg = colors["color13"] })
end

return M

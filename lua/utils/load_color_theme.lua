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
	vim.api.nvim_set_hl(0, "Identifier", { fg = colors["color5"] })
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
	vim.api.nvim_set_hl(0, "@keyword", { fg = colors["color13"], bold = true }) -- General keywords
	vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })
	vim.api.nvim_set_hl(0, "@type", { fg = colors["color14"], bold = true }) -- Custom types
	vim.api.nvim_set_hl(0, "@storageclass", { fg = colors["color13"], bold = true }) -- class, interface, etc.
	vim.api.nvim_set_hl(0, "@keyword.type", { fg = colors["color13"], bold = true }) -- Type keywords
	vim.api.nvim_set_hl(0, "@variable", { fg = colors["color14"] }) -- Variables
	vim.api.nvim_set_hl(0, "@type.builtin", { fg = colors["color12"], bold = true })
	vim.api.nvim_set_hl(0, "@function.method", { fg = colors["color5"] })
	vim.api.nvim_set_hl(0, "@constant", { fg = colors["color7"], italic = true })
	vim.api.nvim_set_hl(0, "@character.special", { fg = colors["color14"] })
	vim.api.nvim_set_hl(0, "@string.escape", { fg = colors["color6"] })

	vim.api.nvim_set_hl(0, "SpecialChar", { fg = colors["color14"] })
	vim.api.nvim_set_hl(0, "@character", { fg = colors["color13"] })

	-- Import/Export keywords
	vim.api.nvim_set_hl(0, "@keyword.import", { fg = colors["color13"], bold = true }) -- import, from, export, default
	vim.api.nvim_set_hl(0, "@keyword.export", { fg = colors["color13"], bold = true })
	vim.api.nvim_set_hl(0, "@keyword.default", { fg = colors["color13"], bold = true })

	-- ========== MEJORAS ESPECÍFICAS PARA JAVASCRIPT ==========

	-- Declaración de variables JavaScript (const, let, var)
	vim.api.nvim_set_hl(0, "@keyword.storage.javascript", { fg = colors["color9"], bold = true }) -- const, let, var
	vim.api.nvim_set_hl(0, "@keyword.storage.typescript", { fg = colors["color9"], bold = true }) -- const, let, var en TS
	vim.api.nvim_set_hl(0, "@keyword.storage.javascriptreact", { fg = colors["color9"], bold = true }) -- const, let, var en JSX
	vim.api.nvim_set_hl(0, "@keyword.storage.typescriptreact", { fg = colors["color9"], bold = true }) -- const, let, var en TSX

	-- Operadores JavaScript específicos
	vim.api.nvim_set_hl(0, "@operator.javascript", { fg = colors["color1"], bold = true }) -- +, -, *, /, %, ==, ===, etc.
	vim.api.nvim_set_hl(0, "@operator.typescript", { fg = colors["color1"], bold = true })
	vim.api.nvim_set_hl(0, "@operator.javascriptreact", { fg = colors["color1"], bold = true })
	vim.api.nvim_set_hl(0, "@operator.typescriptreact", { fg = colors["color1"], bold = true })

	-- Identificadores JavaScript (nombres de variables, funciones)
	vim.api.nvim_set_hl(0, "@variable.javascript", { fg = colors["color6"] }) -- Variables normales
	vim.api.nvim_set_hl(0, "@variable.typescript", { fg = colors["color6"] })
	vim.api.nvim_set_hl(0, "@variable.javascriptreact", { fg = colors["color6"] })
	vim.api.nvim_set_hl(0, "@variable.typescriptreact", { fg = colors["color6"] })

	-- Nombres de función JavaScript
	vim.api.nvim_set_hl(0, "@function.javascript", { fg = colors["color2"], bold = true })
	vim.api.nvim_set_hl(0, "@function.typescript", { fg = colors["color2"], bold = true })
	vim.api.nvim_set_hl(0, "@function.javascriptreact", { fg = colors["color2"], bold = true })
	vim.api.nvim_set_hl(0, "@function.typescriptreact", { fg = colors["color2"], bold = true })

	-- Llamadas a función JavaScript
	vim.api.nvim_set_hl(0, "@function.call.javascript", { fg = colors["color4"], italic = true })
	vim.api.nvim_set_hl(0, "@function.call.typescript", { fg = colors["color4"], italic = true })
	vim.api.nvim_set_hl(0, "@function.call.javascriptreact", { fg = colors["color4"], italic = true })
	vim.api.nvim_set_hl(0, "@function.call.typescriptreact", { fg = colors["color4"], italic = true })

	-- Palabras clave específicas de JavaScript
	vim.api.nvim_set_hl(0, "@keyword.function.javascript", { fg = colors["color13"], bold = true }) -- function, async, await
	vim.api.nvim_set_hl(0, "@keyword.function.typescript", { fg = colors["color13"], bold = true })
	vim.api.nvim_set_hl(0, "@keyword.function.javascriptreact", { fg = colors["color13"], bold = true })
	vim.api.nvim_set_hl(0, "@keyword.function.typescriptreact", { fg = colors["color13"], bold = true })

	-- Palabras clave de control de flujo JavaScript
	vim.api.nvim_set_hl(0, "@keyword.control.javascript", { fg = colors["color11"], bold = true }) -- if, else, for, while, etc.
	vim.api.nvim_set_hl(0, "@keyword.control.typescript", { fg = colors["color11"], bold = true })
	vim.api.nvim_set_hl(0, "@keyword.control.javascriptreact", { fg = colors["color11"], bold = true })
	vim.api.nvim_set_hl(0, "@keyword.control.typescriptreact", { fg = colors["color11"], bold = true })

	-- Propiedades de objetos JavaScript
	vim.api.nvim_set_hl(0, "@property.javascript", { fg = colors["color14"] })
	vim.api.nvim_set_hl(0, "@property.typescript", { fg = colors["color14"] })
	vim.api.nvim_set_hl(0, "@property.javascriptreact", { fg = colors["color14"] })
	vim.api.nvim_set_hl(0, "@property.typescriptreact", { fg = colors["color14"] })

	-- Parámetros de función JavaScript
	vim.api.nvim_set_hl(0, "@parameter.javascript", { fg = colors["color7"], italic = true })
	vim.api.nvim_set_hl(0, "@parameter.typescript", { fg = colors["color7"], italic = true })
	vim.api.nvim_set_hl(0, "@parameter.javascriptreact", { fg = colors["color7"], italic = true })
	vim.api.nvim_set_hl(0, "@parameter.typescriptreact", { fg = colors["color7"], italic = true })

	-- Constantes JavaScript
	vim.api.nvim_set_hl(0, "@constant.javascript", { fg = colors["color5"], bold = true })
	vim.api.nvim_set_hl(0, "@constant.typescript", { fg = colors["color5"], bold = true })
	vim.api.nvim_set_hl(0, "@constant.javascriptreact", { fg = colors["color5"], bold = true })
	vim.api.nvim_set_hl(0, "@constant.typescriptreact", { fg = colors["color5"], bold = true })

	-- ========== FIN DE MEJORAS ESPECÍFICAS PARA JAVASCRIPT ==========

	-- TypeScript/JavaScript types and interfaces
	vim.api.nvim_set_hl(0, "@type.typescript", { fg = colors["color11"], bold = true }) -- Custom types like Monster
	vim.api.nvim_set_hl(0, "@type.definition", { fg = colors["color11"], bold = true }) -- Type definitions
	vim.api.nvim_set_hl(0, "@keyword.type", { fg = colors["color13"], bold = true }) -- interface, type keywords
	vim.api.nvim_set_hl(0, "@storageclass.typescript", { fg = colors["color13"], bold = true }) -- interface keyword

	-- Function parameters and properties
	vim.api.nvim_set_hl(0, "@parameter", { fg = colors["color3"], italic = true }) -- Function parameters
	vim.api.nvim_set_hl(0, "@property", { fg = colors["color6"] }) -- Object properties
	vim.api.nvim_set_hl(0, "@field", { fg = colors["color6"] }) -- Object fields

	-- Strings (ensuring they're not white)
	vim.api.nvim_set_hl(0, "@string", { fg = colors["color15"] }) -- Regular strings
	vim.api.nvim_set_hl(0, "@string.template", { fg = colors["color15"], italic = true }) -- Template literals
	vim.api.nvim_set_hl(0, "@string.regexp", { fg = colors["color14"] }) -- Regular expressions

	-- JSX/TSX specific highlighting
	vim.api.nvim_set_hl(0, "@tag", { fg = colors["color1"], bold = true }) -- HTML tags: <div>, <span>
	vim.api.nvim_set_hl(0, "@tag.attribute", { fg = colors["color11"], italic = true }) -- Attributes: className, id
	vim.api.nvim_set_hl(0, "@tag.delimiter", { fg = colors["color8"] }) -- < > / =
	vim.api.nvim_set_hl(0, "@tag.builtin", { fg = colors["color1"], bold = true }) -- HTML built-in tags
	vim.api.nvim_set_hl(0, "@constructor", { fg = colors["color5"], bold = true }) -- React components: <MyComponent>

	-- JSX expressions and embedded JavaScript
	vim.api.nvim_set_hl(0, "@punctuation.special", { fg = colors["color13"] }) -- { } in JSX and other special punct

	-- React Hooks and imported functions
	vim.api.nvim_set_hl(0, "@function.builtin", { fg = colors["color2"], bold = true }) -- React hooks like useState
	vim.api.nvim_set_hl(0, "@variable.builtin", { fg = colors["color2"] }) -- Built-in variables

	-- Module and import paths
	vim.api.nvim_set_hl(0, "@string.path", { fg = colors["color12"], italic = true }) -- Import paths
	vim.api.nvim_set_hl(0, "@namespace", { fg = colors["color5"] }) -- Namespace imports

	-- Rainbow Delimiters
	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = colors["color6"] })
	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = colors["color10"] })
	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = colors["color4"] })
	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = colors["color11"] })
	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = colors["color2"] })
	vim.api.nvim_set_hl(0, "RainbowRed", { fg = colors["color3"] })

	vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = colors["color4"] }) -- `,`, `;`, `:`
	vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = colors["color5"] }) -- `()`, `{}`, `[]`
	vim.api.nvim_set_hl(0, "@punctuation.special", { fg = colors["color7"] }) -- `...`, `::`, `->`
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

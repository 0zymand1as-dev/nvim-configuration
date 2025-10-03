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

	-- Base syntax highlighting
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

	-- General Tree-sitter highlights
	vim.api.nvim_set_hl(0, "@function.call", { link = "Function" })
	vim.api.nvim_set_hl(0, "@keyword", { fg = colors["color13"], bold = true })
	vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })
	vim.api.nvim_set_hl(0, "@type", { fg = colors["color14"], bold = true })
	vim.api.nvim_set_hl(0, "@storageclass", { fg = colors["color13"], bold = true })
	vim.api.nvim_set_hl(0, "@keyword.type", { fg = colors["color13"], bold = true })
	vim.api.nvim_set_hl(0, "@variable", { fg = colors["color14"] })
	vim.api.nvim_set_hl(0, "@type.builtin", { fg = colors["color12"], bold = true })
	vim.api.nvim_set_hl(0, "@function.method", { fg = colors["color5"] })
	vim.api.nvim_set_hl(0, "@constant", { fg = colors["color7"], italic = true })
	vim.api.nvim_set_hl(0, "@character.special", { fg = colors["color14"] })
	vim.api.nvim_set_hl(0, "@string.escape", { fg = colors["color6"] })
	vim.api.nvim_set_hl(0, "SpecialChar", { fg = colors["color14"] })
	vim.api.nvim_set_hl(0, "Special", { fg = colors["color13"] })
	vim.api.nvim_set_hl(0, "@character", { fg = colors["color13"] })

	-- Import/Export keywords
	vim.api.nvim_set_hl(0, "@keyword.import", { fg = colors["color13"], bold = true })
	vim.api.nvim_set_hl(0, "@keyword.export", { fg = colors["color13"], bold = true })
	vim.api.nvim_set_hl(0, "@keyword.default", { fg = colors["color13"], bold = true })

	-- JavaScript/TypeScript specific highlights
	local js_langs = { "javascript", "typescript", "javascriptreact", "typescriptreact" }

	for _, lang in ipairs(js_langs) do
		-- Variable declarations
		vim.api.nvim_set_hl(0, "@keyword.storage." .. lang, { fg = colors["color9"], bold = true })

		-- Operators
		vim.api.nvim_set_hl(0, "@operator." .. lang, { fg = colors["color1"], bold = true })

		-- Variables
		vim.api.nvim_set_hl(0, "@variable." .. lang, { fg = colors["color6"] })

		-- Functions
		vim.api.nvim_set_hl(0, "@function." .. lang, { fg = colors["color2"], bold = true })
		vim.api.nvim_set_hl(0, "@function.call." .. lang, { fg = colors["color4"], italic = true })

		-- Keywords
		vim.api.nvim_set_hl(0, "@keyword.function." .. lang, { fg = colors["color13"], bold = true })
		vim.api.nvim_set_hl(0, "@keyword.control." .. lang, { fg = colors["color11"], bold = true })

		-- Properties and parameters
		vim.api.nvim_set_hl(0, "@property." .. lang, { fg = colors["color14"] })
		vim.api.nvim_set_hl(0, "@parameter." .. lang, { fg = colors["color7"], italic = true })

		-- Constants
		vim.api.nvim_set_hl(0, "@constant." .. lang, { fg = colors["color5"], bold = true })
	end

	-- TypeScript specific
	vim.api.nvim_set_hl(0, "@type.typescript", { fg = colors["color11"], bold = true })
	vim.api.nvim_set_hl(0, "@type.definition", { fg = colors["color11"], bold = true })
	vim.api.nvim_set_hl(0, "@storageclass.typescript", { fg = colors["color13"], bold = true })

	-- Java specific highlights
	-- Java keywords and modifiers
	vim.api.nvim_set_hl(0, "@keyword.java", { fg = colors["color13"], bold = true }) -- public, private, protected, static, final, etc.
	vim.api.nvim_set_hl(0, "@keyword.modifier.java", { fg = colors["color9"], bold = true }) -- public, private, protected, static, final, abstract
	vim.api.nvim_set_hl(0, "@keyword.control.java", { fg = colors["color11"], bold = true }) -- if, else, for, while, switch, do
	vim.api.nvim_set_hl(0, "@keyword.control.flow.java", { fg = colors["color3"], bold = true }) -- return, break, continue
	vim.api.nvim_set_hl(0, "@keyword.control.exception.java", { fg = colors["color1"], bold = true }) -- try, catch, finally, throw, throws
	vim.api.nvim_set_hl(0, "@keyword.import.java", { fg = colors["color13"], bold = true }) -- import, package

	-- Java storage and access modifiers
	vim.api.nvim_set_hl(0, "@storageclass.java", { fg = colors["color9"], bold = true }) -- static, final, abstract, synchronized
	vim.api.nvim_set_hl(0, "@keyword.storage.java", { fg = colors["color9"], bold = true }) -- class, interface, enum, extends, implements

	-- Java types and classes
	vim.api.nvim_set_hl(0, "@type.java", { fg = colors["color11"], bold = true }) -- User-defined class names
	vim.api.nvim_set_hl(0, "@type.builtin.java", { fg = colors["color12"], bold = true }) -- int, String, boolean, char, etc.
	vim.api.nvim_set_hl(0, "@type.class.java", { fg = colors["color11"], bold = true }) -- Class declarations
	vim.api.nvim_set_hl(0, "@type.interface.java", { fg = colors["color14"], bold = true }) -- Interface names
	vim.api.nvim_set_hl(0, "@type.enum.java", { fg = colors["color10"], bold = true }) -- Enum names
	vim.api.nvim_set_hl(0, "@constructor.java", { fg = colors["color11"], bold = true }) -- Constructor methods

	-- Java variables and identifiers
	vim.api.nvim_set_hl(0, "@variable.java", { fg = colors["color6"] }) -- Local variables
	vim.api.nvim_set_hl(0, "@variable.member.java", { fg = colors["color7"], italic = true }) -- Instance variables
	vim.api.nvim_set_hl(0, "@variable.static.java", { fg = colors["color14"], italic = true }) -- Static variables
	vim.api.nvim_set_hl(0, "@field.java", { fg = colors["color7"], italic = true }) -- Class fields
	vim.api.nvim_set_hl(0, "@property.java", { fg = colors["color14"] }) -- Object properties

	-- Java functions and methods
	vim.api.nvim_set_hl(0, "@function.java", { fg = colors["color2"], bold = true }) -- Method definitions
	vim.api.nvim_set_hl(0, "@function.call.java", { fg = colors["color4"], italic = true }) -- Method calls
	vim.api.nvim_set_hl(0, "@function.method.java", { fg = colors["color5"], bold = true }) -- Instance methods
	vim.api.nvim_set_hl(0, "@function.static.java", { fg = colors["color2"], bold = true }) -- Static methods
	vim.api.nvim_set_hl(0, "@function.builtin.java", { fg = colors["color3"], bold = true }) -- Built-in methods like System.out.println

	-- Java parameters and arguments
	vim.api.nvim_set_hl(0, "@parameter.java", { fg = colors["color7"], italic = true }) -- Method parameters
	vim.api.nvim_set_hl(0, "@parameter.this.java", { fg = colors["color5"], italic = true }) -- 'this' keyword
	vim.api.nvim_set_hl(0, "@parameter.super.java", { fg = colors["color5"], italic = true }) -- 'super' keyword

	-- Java constants and literals
	vim.api.nvim_set_hl(0, "@constant.java", { fg = colors["color5"], bold = true }) -- Final static variables
	vim.api.nvim_set_hl(0, "@constant.builtin.java", { fg = colors["color10"], bold = true }) -- true, false, null
	vim.api.nvim_set_hl(0, "@number.java", { fg = colors["color14"] }) -- Numeric literals
	vim.api.nvim_set_hl(0, "@number.float.java", { fg = colors["color6"] }) -- Float and double literals
	vim.api.nvim_set_hl(0, "@boolean.java", { fg = colors["color10"], bold = true }) -- true, false

	-- Java strings and characters
	vim.api.nvim_set_hl(0, "@string.java", { fg = colors["color15"] }) -- String literals
	vim.api.nvim_set_hl(0, "@string.escape.java", { fg = colors["color6"], bold = true }) -- Escape sequences
	vim.api.nvim_set_hl(0, "@character.java", { fg = colors["color13"] }) -- Character literals

	-- Java operators
	vim.api.nvim_set_hl(0, "@operator.java", { fg = colors["color1"], bold = true }) -- Arithmetic and logical operators
	vim.api.nvim_set_hl(0, "@operator.assignment.java", { fg = colors["color12"], bold = true }) -- Assignment operators
	vim.api.nvim_set_hl(0, "@operator.comparison.java", { fg = colors["color3"], bold = true }) -- Comparison operators

	-- Java annotations
	vim.api.nvim_set_hl(0, "@annotation.java", { fg = colors["color3"], bold = true }) -- @Override, @Deprecated, etc.
	vim.api.nvim_set_hl(0, "@symbol.java", { fg = colors["color3"] }) -- @ symbol for annotations

	-- Java generics and wildcards
	vim.api.nvim_set_hl(0, "@type.parameter.java", { fg = colors["color12"], italic = true }) -- Generic type parameters (T, E, K, V)
	vim.api.nvim_set_hl(0, "@type.wildcard.java", { fg = colors["color6"], italic = true }) -- Wildcard types (? extends, ? super)

	-- Java packages and imports
	vim.api.nvim_set_hl(0, "@namespace.java", { fg = colors["color5"] }) -- Package names
	vim.api.nvim_set_hl(0, "@module.java", { fg = colors["color5"] }) -- Imported modules

	-- Java punctuation and delimiters
	vim.api.nvim_set_hl(0, "@punctuation.delimiter.java", { fg = colors["color4"] }) -- Semicolons, commas
	vim.api.nvim_set_hl(0, "@punctuation.bracket.java", { fg = colors["color5"] }) -- Brackets, parentheses, braces
	vim.api.nvim_set_hl(0, "@punctuation.special.java", { fg = colors["color7"] }) -- Special punctuation

	-- Java exception handling
	vim.api.nvim_set_hl(0, "@exception.java", { fg = colors["color1"], bold = true }) -- Exception class names
	vim.api.nvim_set_hl(0, "@type.exception.java", { fg = colors["color1"], bold = true }) -- Exception types

	-- Java lambda expressions (Java 8+)
	vim.api.nvim_set_hl(0, "@function.lambda.java", { fg = colors["color4"], italic = true }) -- Lambda expressions
	vim.api.nvim_set_hl(0, "@operator.lambda.java", { fg = colors["color3"], bold = true }) -- -> operator

	-- Java stream operations (Java 8+)
	vim.api.nvim_set_hl(0, "@function.stream.java", { fg = colors["color6"], italic = true }) -- Stream operations like map, filter, collect

	-- Java documentation comments
	vim.api.nvim_set_hl(0, "@comment.documentation.java", { fg = colors["color8"], italic = true }) -- Javadoc comments
	vim.api.nvim_set_hl(0, "@tag.java", { fg = colors["color3"], bold = true }) -- Javadoc tags like @param, @return

	-- Java static blocks and initializers
	vim.api.nvim_set_hl(0, "@keyword.static.java", { fg = colors["color9"], bold = true }) -- static blocks

	-- Java enum values
	vim.api.nvim_set_hl(0, "@constant.enum.java", { fg = colors["color10"], bold = true }) -- Enum constants

	-- Java method references (Java 8+)
	vim.api.nvim_set_hl(0, "@operator.method_reference.java", { fg = colors["color3"], bold = true }) -- :: operator

	-- Python specific highlights
	-- Python variable declarations and assignments
	vim.api.nvim_set_hl(0, "@variable.python", { fg = colors["color6"] })
	vim.api.nvim_set_hl(0, "@variable.builtin.python", { fg = colors["color2"], bold = true }) -- self, cls, __name__

	-- Python operators
	vim.api.nvim_set_hl(0, "@operator.python", { fg = colors["color1"], bold = true }) -- +, -, *, /, //, %, **

	-- Python keywords
	vim.api.nvim_set_hl(0, "@keyword.python", { fg = colors["color13"], bold = true }) -- def, class, import, etc.
	vim.api.nvim_set_hl(0, "@keyword.function.python", { fg = colors["color9"], bold = true }) -- def, lambda
	vim.api.nvim_set_hl(0, "@keyword.control.python", { fg = colors["color11"], bold = true }) -- if, for, while, try, etc.
	vim.api.nvim_set_hl(0, "@keyword.control.flow.python", { fg = colors["color3"], bold = true }) -- return, yield, break, continue
	vim.api.nvim_set_hl(0, "@keyword.control.exception.python", { fg = colors["color1"], bold = true }) -- raise, except, finally
	vim.api.nvim_set_hl(0, "@keyword.import.python", { fg = colors["color13"], bold = true }) -- import, from, as

	-- Python functions and methods
	vim.api.nvim_set_hl(0, "@function.python", { fg = colors["color2"], bold = true }) -- Function definitions
	vim.api.nvim_set_hl(0, "@function.call.python", { fg = colors["color4"], italic = true }) -- Function calls
	vim.api.nvim_set_hl(0, "@function.method.python", { fg = colors["color5"], bold = true }) -- Method calls
	vim.api.nvim_set_hl(0, "@function.builtin.python", { fg = colors["color2"], bold = true }) -- len, print, range, etc.

	-- Python classes and types
	vim.api.nvim_set_hl(0, "@type.python", { fg = colors["color11"], bold = true }) -- Class names
	vim.api.nvim_set_hl(0, "@type.builtin.python", { fg = colors["color12"], bold = true }) -- int, str, list, dict, etc.
	vim.api.nvim_set_hl(0, "@constructor.python", { fg = colors["color11"], bold = true }) -- __init__, class constructors

	-- Python parameters and arguments
	vim.api.nvim_set_hl(0, "@parameter.python", { fg = colors["color7"], italic = true }) -- Function parameters
	vim.api.nvim_set_hl(0, "@parameter.builtin.python", { fg = colors["color3"], italic = true }) -- self, cls, *args, **kwargs

	-- Python properties and attributes
	vim.api.nvim_set_hl(0, "@property.python", { fg = colors["color14"] }) -- Object attributes
	vim.api.nvim_set_hl(0, "@attribute.python", { fg = colors["color14"] }) -- Class attributes
	vim.api.nvim_set_hl(0, "@field.python", { fg = colors["color6"] }) -- Instance variables

	-- Python constants and literals
	vim.api.nvim_set_hl(0, "@constant.python", { fg = colors["color5"], bold = true }) -- Constants
	vim.api.nvim_set_hl(0, "@constant.builtin.python", { fg = colors["color10"], bold = true }) -- True, False, None
	vim.api.nvim_set_hl(0, "@number.python", { fg = colors["color14"] }) -- Numbers
	vim.api.nvim_set_hl(0, "@float.python", { fg = colors["color6"] }) -- Floats
	vim.api.nvim_set_hl(0, "@boolean.python", { fg = colors["color10"], bold = true }) -- True, False

	-- Python strings
	vim.api.nvim_set_hl(0, "@string.python", { fg = colors["color15"] }) -- Regular strings
	vim.api.nvim_set_hl(0, "@string.documentation.python", { fg = colors["color8"], italic = true }) -- Docstrings
	vim.api.nvim_set_hl(0, "@string.escape.python", { fg = colors["color6"], bold = true }) -- Escape sequences
	vim.api.nvim_set_hl(0, "@string.special.python", { fg = colors["color14"] }) -- f-strings, raw strings
	vim.api.nvim_set_hl(0, "@string.format.python", { fg = colors["color6"], italic = true }) -- String formatting

	-- Python decorators
	vim.api.nvim_set_hl(0, "@decorator.python", { fg = colors["color3"], bold = true }) -- @decorator
	vim.api.nvim_set_hl(0, "@symbol.python", { fg = colors["color3"] }) -- @ symbol

	-- Python modules and namespaces
	vim.api.nvim_set_hl(0, "@namespace.python", { fg = colors["color5"] }) -- Module names
	vim.api.nvim_set_hl(0, "@module.python", { fg = colors["color5"] }) -- Import modules

	-- Python punctuation
	vim.api.nvim_set_hl(0, "@punctuation.delimiter.python", { fg = colors["color4"] }) -- Commas, colons
	vim.api.nvim_set_hl(0, "@punctuation.bracket.python", { fg = colors["color5"] }) -- Brackets, parentheses
	vim.api.nvim_set_hl(0, "@punctuation.special.python", { fg = colors["color7"] }) -- Special punctuation

	-- Python exceptions and error handling
	vim.api.nvim_set_hl(0, "@exception.python", { fg = colors["color1"], bold = true }) -- Exception names

	-- Python comprehensions
	vim.api.nvim_set_hl(0, "@keyword.control.conditional.python", { fg = colors["color11"], bold = true }) -- if in comprehensions

	-- Python magic methods and dunder methods
	vim.api.nvim_set_hl(0, "@function.magic.python", { fg = colors["color3"], bold = true }) -- __init__, __str__, etc.

	-- Python type hints (if using typing module)
	vim.api.nvim_set_hl(0, "@type.annotation.python", { fg = colors["color12"], italic = true }) -- Type annotations

	-- JSX/TSX specific highlights
	-- Function parameters and properties
	vim.api.nvim_set_hl(0, "@parameter", { fg = colors["color3"], italic = true })
	vim.api.nvim_set_hl(0, "@property", { fg = colors["color6"] })
	vim.api.nvim_set_hl(0, "@field", { fg = colors["color6"] })

	-- Strings
	vim.api.nvim_set_hl(0, "@string", { fg = colors["color15"] })
	vim.api.nvim_set_hl(0, "@string.template", { fg = colors["color15"], italic = true })
	vim.api.nvim_set_hl(0, "@string.regexp", { fg = colors["color14"] })

	-- JSX/TSX specific
	vim.api.nvim_set_hl(0, "@tag", { fg = colors["color1"], bold = true })
	vim.api.nvim_set_hl(0, "@tag.attribute", { fg = colors["color11"], italic = true })
	vim.api.nvim_set_hl(0, "@tag.delimiter", { fg = colors["color8"] })
	vim.api.nvim_set_hl(0, "@tag.builtin", { fg = colors["color1"], bold = true })
	vim.api.nvim_set_hl(0, "@constructor", { fg = colors["color5"], bold = true })

	-- JSX expressions
	vim.api.nvim_set_hl(0, "@punctuation.special", { fg = colors["color13"] })

	-- React specific
	vim.api.nvim_set_hl(0, "@function.builtin", { fg = colors["color2"], bold = true })
	vim.api.nvim_set_hl(0, "@variable.builtin", { fg = colors["color2"] })

	-- Module paths
	vim.api.nvim_set_hl(0, "@string.path", { fg = colors["color12"], italic = true })
	vim.api.nvim_set_hl(0, "@namespace", { fg = colors["color5"] })

	-- UI highlights
	-- Rainbow Delimiters
	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = colors["color6"] })
	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = colors["color10"] })
	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = colors["color4"] })
	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = colors["color11"] })
	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = colors["color2"] })
	vim.api.nvim_set_hl(0, "RainbowRed", { fg = colors["color3"] })
	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = colors["color5"] })

	-- Punctuation
	vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = colors["color4"] })
	vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = colors["color5"] })
	vim.api.nvim_set_hl(0, "@punctuation.special", { fg = colors["color7"] })

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


function M.reload()
	local path = vim.fn.expand("~/.config/kitty/theme.conf")
	local file = io.open(path, "r")
	if file then
		file:close()
		local ok, err = pcall(function()
			local kitty_colors = M.load_kitty_theme(path)
			M.apply_to_nvim(kitty_colors)
			vim.notify("Kitty theme reloaded successfully.", vim.log.levels.INFO)
		end)
		if not ok then
			vim.notify("Error reloading kitty theme: " .. err, vim.log.levels.ERROR)
		end
	else
		vim.notify("Kitty theme file not found at " .. path, vim.log.levels.WARN)
	end
end

local timer = vim.loop.new_timer()
local function debounced_reload()
	timer:stop()
	timer:start(100, 0, function()
		vim.schedule(function()
			require('utils.load_color_theme').reload()
		end)
	end)
end

function M.watch_for_changes()
	local path = vim.fn.expand("~/.config/kitty/theme.conf")
	local watcher = vim.loop.new_fs_event()
	if not watcher then
		return
	end
	watcher:start(path, {}, debounced_reload)
end

return M

local map = vim.keymap.set

-- NVIM
-- Unable arrows keys globally
map("n", "<Up>", "<Nop>", { noremap = true, silent = true })
map("n", "<Down>", "<Nop>", { noremap = true, silent = true })
map("n", "<Left>", "<Nop>", { noremap = true, silent = true })
map("n", "<Right>", "<Nop>", { noremap = true, silent = true })
-- Move line down
map("n", "<M-J>", ":m .+1<CR>==", { noremap = true, silent = true, desc = "Move line down" })
-- Move line up
map("n", "<M-K>", ":m .-2<CR>==", { noremap = true, silent = true, desc = "Move line up" })
-- Go to the end of the line
map({ "n", "v" }, "L", "$", { noremap = true, silent = true, desc = "Go to end of line" })
-- Go to the beginning of the line
map({ "n", "v" }, "H", "^", { noremap = true, silent = true, desc = "Go to beginning of line" })
-- Down 10 lines
map("n", "J", "10j", { noremap = true, silent = true, desc = "Move down 10 lines" })
-- Up 10 lines
map("n", "K", "10k", { noremap = true, silent = true, desc = "Move up 10 lines" })
-- Put a semicolon at the end of the line
map("n", "<leader>;", "$beA;<Esc>", { noremap = true, silent = true, desc = "Add semicolon at end of line" })

-- NEOTREE
-- Open neotree in the right side
map("n", "<leader>a", ":Neotree float <cr>", {
	noremap = true,
	silent = true,
	desc = "Open Neotree",
})

-- TELESCOPE
-- Fuzzy find files
map("n", "<C-p>", require("telescope.builtin").find_files, { desc = "Find files (Telescope)" })
-- Fuzzy find text files
map("n", "<C-f>", require("telescope.builtin").live_grep, { desc = "Live grep (Telescope)" })
-- Fuzzy find buffers
map("n", "<C-b>", require("telescope.builtin").buffers, { desc = "Find buffers (Telescope)" })
-- Fuzzy find help tags
map("n", "<C-h>", require("telescope.builtin").help_tags, { desc = "Find help tags (Telescope)" })

-- LSP
-- Show hover documentation
map("n", "<C-k>", vim.lsp.buf.hover, { noremap = true, silent = true, desc = "LSP hover docs" })
-- Go to definition under cursor
map("n", "<leader>D", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to definition" })
-- Show code actions (normal + visual)
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "LSP code actions" })
-- Format current buffer
map("n", "<leader>ff", function()
	vim.lsp.buf.format({ async = true })
end, { noremap = true, silent = true, desc = "Format buffer" })

-- LSP DIAGNOSTICS
-- Show diagnostic popup manually
map("n", "<leader>e", vim.diagnostic.open_float, {
	noremap = true,
	silent = true,
	desc = "Show diagnostic error",
})

-- Go to next diagnostic
map("n", "]d", vim.diagnostic.goto_next, {
	noremap = true,
	silent = true,
	desc = "Go to next diagnostic",
})

-- Go to previous diagnostic
map("n", "[d", vim.diagnostic.goto_prev, {
	noremap = true,
	silent = true,
	desc = "Go to previous diagnostic",
})

-- COPILOT
-- Accept suggestion
map("i", "<C-j>", 'copilot#Accept("\\<CR>") . "\\<Esc>"', {
	expr = true,
	replace_keycodes = false,
	silent = true,
	desc = "Copilot: accept suggestion",
})
-- Accept next word from suggestion
map("i", "<C-l>", "<Plug>(copilot-accept-word)", { silent = true, desc = "Copilot: accept next word" })
-- Cancel current Copilot suggestion
map("i", "<C-e>", "<Plug>(copilot-dismiss)", { silent = true, desc = "Copilot: dismiss suggestion" })
-- Show next suggestion
map("i", "<M-]>", "<Plug>(copilot-next)", { silent = true, desc = "Copilot: next suggestion" })
-- Show previous suggestion
map("i", "<M-[>", "<Plug>(copilot-previous)", { silent = true, desc = "Copilot: previous suggestion" })
-- Manually trigger suggestion
map("i", "<M-s>", "<Plug>(copilot-suggest)", { silent = false, desc = "Copilot: trigger suggestion" })
-- Enable autocompletion
map("n", "<leader>ce", ":Copilot enable<CR>", { silent = false, desc = "Copilot: enable suggestion" })
-- Disable autocompletion
map("n", "<leader>cd", ":Copilot disable<CR>", { silent = false, desc = "Copilot: disable suggestion" })

-- EASYMOTION
-- Search for character under cursor
map({ "n", "v" }, "f", "<Plug>(easymotion-f)", {
	noremap = true,
	silent = true,
	desc = "Easymotion: search for character under cursor",
})
-- Search for character over cursor
map({ "n", "v" }, "F", "<Plug>(easymotion-F)", {
	noremap = true,
	silent = true,
	desc = "Easymotion: search for character over cursor",
})

-- RMARKDOWN
map("n", "<leader>md", ":RenderMarkdown toggle<CR>", {
	noremap = true,
	silent = true,
	desc = "Toggle RenderMarkdown",
})

-- WINDOWS, BUFFERS, TABS
-- Write only current buffer
map("n", "<M-s>", ":w<CR>", { noremap = true, silent = true, desc = "Save current buffer" })
-- Close only current buffer
map("n", "<M-w>", ":bd<CR>", { noremap = true, silent = true, desc = "Close current buffer" })
-- Open new tab
map("n", "<M-e>", ":tabnew<CR>", { noremap = true, silent = true, desc = "Open new tab" })
-- Vertical split
map("n", "<leader>sv", ":vsplit | wincmd l<CR>", { noremap = true, silent = true, desc = "Vertical split" })
-- Horizontal split
map("n", "<leader>sh", ":split | wincmd j<CR>", { noremap = true, silent = true, desc = "Horizontal split" })
-- Next buffer
map("n", "<M-l>", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
-- Previous buffer
map("n", "<M-h>", ":bprevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
-- Focus right window
map("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "Focus right window" })
-- Focus left window
map("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "Focus left window" })
-- Focus up window
map("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "Focus up window" })
-- Focus down window
map("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "Focus down window" })


-- COMMENT
-- Toggle smart comment with Ctrl + /
vim.keymap.set('n', '<leader>/', function()
  require('utils.smart_comment').toggle_smart_comment()
end, { desc = 'Toggle smart comment', noremap = true, silent = true })

vim.keymap.set('v', '<leader>/', function()
  require('utils.smart_comment').toggle_visual_comment()
end, { desc = 'Toggle visual comment', noremap = true, silent = true })

vim.keymap.set('n', '<C-/>', function()
  require('utils.smart_comment').toggle_smart_comment()
end, { desc = 'Toggle smart comment', noremap = true, silent = true })

vim.keymap.set('v', '<C-/>', function()
  require('utils.smart_comment').toggle_visual_comment()
end, { desc = 'Toggle visual comment', noremap = true, silent = true })

-- lua/plugins/gitsigns.lua
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "]c", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { expr = true, desc = "Gitsigns: Next Hunk" })

      map("n", "[c", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { expr = true, desc = "Gitsigns: Previous Hunk" })

      -- Actions
      map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "Gitsigns: Stage Hunk" })
      map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Gitsigns: Reset Hunk" })
      map("n", "<leader>gS", gs.stage_buffer, { desc = "Gitsigns: Stage Buffer" })
      map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Gitsigns: Undo Stage Hunk" })
      map("n", "<leader>gR", gs.reset_buffer, { desc = "Gitsigns: Reset Buffer" })
      map("n", "<leader>gp", gs.preview_hunk, { desc = "Gitsigns: Preview Hunk" })
      map("n", "<leader>gb", function()
        gs.blame_line({ full = true })
      end, { desc = "Gitsigns: Blame Line" })
    end,
  },
}
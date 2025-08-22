local M = {}

-- Función para abrir hover con navegación y cerrar con ESC
function M.hover_with_controls()
  -- Abre el hover
  vim.lsp.buf.hover()

  -- Usamos un timer más robusto para detectar la ventana flotante
  local timer = vim.loop.new_timer()
  local attempts = 0
  local max_attempts = 20

  timer:start(
    10,
    10,
    vim.schedule_wrap(function()
      attempts = attempts + 1

      -- Busca ventanas flotantes LSP
      local hover_win = nil
      local wins = vim.api.nvim_list_wins()

      for _, win in ipairs(wins) do
        if vim.api.nvim_win_is_valid(win) then
          local config = vim.api.nvim_win_get_config(win)
          -- Detecta ventanas flotantes (relative no vacío)
          if config.relative ~= "" and config.relative ~= nil then
            local buf = vim.api.nvim_win_get_buf(win)
            local filetype = vim.bo[buf].filetype

            -- Verifica que sea una ventana de hover LSP
            if filetype == "markdown" or vim.bo[buf].buftype == "nofile" then
              hover_win = win
              break
            end
          end
        end
      end

      if hover_win then
        timer:stop()
        timer:close()

        local buf = vim.api.nvim_win_get_buf(hover_win)

        -- Configurar el buffer para navegación
        pcall(function()
          vim.bo[buf].modifiable = false
          vim.bo[buf].readonly = true
        end)

        -- Enfocar la ventana flotante para poder navegar
        vim.api.nvim_set_current_win(hover_win)

        -- Configurar keymaps locales al buffer
        local opts = { buffer = buf, silent = true, nowait = true }

        -- ESC para cerrar
        vim.keymap.set("n", "<Esc>", function()
          if vim.api.nvim_win_is_valid(hover_win) then
            vim.api.nvim_win_close(hover_win, true)
          end
        end, opts)

        -- q para cerrar también (estilo vim help)
        vim.keymap.set("n", "q", function()
          if vim.api.nvim_win_is_valid(hover_win) then
            vim.api.nvim_win_close(hover_win, true)
          end
        end, opts)

        -- Opcional: Ctrl+c para cerrar también
        vim.keymap.set("n", "<C-c>", function()
          if vim.api.nvim_win_is_valid(hover_win) then
            vim.api.nvim_win_close(hover_win, true)
          end
        end, opts)
      elseif attempts >= max_attempts then
        -- Si no encuentra la ventana después de varios intentos, para el timer
        timer:stop()
        timer:close()
      end
    end)
  )
end

-- Función alternativa más simple que usa autocmds
function M.hover_with_controls_alt()
  local group = vim.api.nvim_create_augroup("HoverControls", { clear = true })

  -- Crear autocmd que se ejecuta cuando se abre una ventana flotante
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "markdown",
    callback = function(args)
      local buf = args.buf
      local wins = vim.api.nvim_list_wins()

      -- Verificar si este buffer está en una ventana flotante
      for _, win in ipairs(wins) do
        if vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == buf then
          local config = vim.api.nvim_win_get_config(win)
          if config.relative ~= "" then
            -- Es una ventana flotante
            vim.bo[buf].modifiable = false
            vim.bo[buf].readonly = true

            -- Enfocar la ventana para navegación
            vim.api.nvim_set_current_win(win)

            local opts = { buffer = buf, silent = true, nowait = true }

            vim.keymap.set("n", "<Esc>", function()
              if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_close(win, true)
              end
            end, opts)

            vim.keymap.set("n", "q", function()
              if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_close(win, true)
              end
            end, opts)

            -- Limpiar el autocmd después de usar
            vim.api.nvim_clear_autocmds({ group = group })
            break
          end
        end
      end
    end,
  })

  -- Abrir hover
  vim.lsp.buf.hover()
end

return M

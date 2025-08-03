local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "goimports", "gofmt" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
  --
  format_on_save = function(bufnr)
    local ft = vim.bo[bufnr].filetype
    -- enable format on save only for Go
    return ft == "go" and {
      timeout_ms = 500,
      lsp_fallback = true,
    }
  end,
}

return options

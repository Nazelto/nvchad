local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    nix = { "nixfmt" },
    python = { "ruff" },
    rust = { "rustfmt" },
    -- python = function(bufnr)
    --   if require("conform").get_formatter_info("ruff_format", bufnr).available then
    --     return { "ruff_format" }
    --   end
    --   return { "isort", "black" }
    -- end,
    -- -- css = { "prettier" },
    -- html = { "prettier" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options

return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile", "BufWritePre" },
    opts = require "configs.conform",
  },
}

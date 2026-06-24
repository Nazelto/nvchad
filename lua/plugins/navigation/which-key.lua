return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.triggers = opts.triggers or { { "<auto>", mode = "nxso" } }
      table.insert(opts.triggers, { "[", mode = "nxo" })
      table.insert(opts.triggers, { "]", mode = "nxo" })
      return opts
    end,
  },
}

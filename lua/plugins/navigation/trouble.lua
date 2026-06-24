return {
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      {
        "<leader>cx",
        "<cmd>Trouble diagnostics toggle focus=false<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>cX",
        "<cmd>Trouble diagnostics toggle focus=false filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP References / defs (Trouble)",
      },
      {
        "<leader>cI",
        "<cmd>Trouble lsp_incoming_calls toggle focus=false<cr>",
        desc = "Incoming Calls (Trouble)",
      },
      {
        "<leader>cO",
        "<cmd>Trouble lsp_outgoing_calls toggle focus=false<cr>",
        desc = "Outgoing Calls (Trouble)",
      },
    },
    opts = {
      auto_open = false,
      auto_close = false,
      auto_preview = true,
      focus = false,
      follow = true,
      pinned = false,
      warn_no_results = true,
      win = {
        type = "split",
        position = "bottom",
      },
      preview = {
        type = "main",
        scratch = true,
      },
    },
  },
}

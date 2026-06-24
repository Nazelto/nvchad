return {
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      local opts = require "nvchad.configs.gitsigns"
      opts.current_line_blame = true
      opts.current_line_blame_opts = {
        delay = 500,
        ignore_whitespace = false,
      }
      return opts
    end,
  },
}

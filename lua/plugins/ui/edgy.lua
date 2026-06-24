return {
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = {
      left = {
        {
          title = "Outline",
          ft = "Outline",
          open = "Outline",
          size = { width = 38 },
          filter = function(buf)
            return vim.api.nvim_get_option_value("filetype", { buf = buf }):lower() == "outline"
          end,
        },
      },
      right = {
        {
          title = "Aerial",
          ft = "aerial",
          open = "AerialOpen",
          size = { width = 38 },
          filter = function(buf)
            return vim.api.nvim_get_option_value("filetype", { buf = buf }):lower() == "aerial"
          end,
        },
      },
      bottom = {
        {
          title = "Trouble",
          ft = "trouble",
          open = "Trouble diagnostics toggle focus=false",
          size = { height = 12 },
          filter = function(buf)
            return vim.api.nvim_get_option_value("filetype", { buf = buf }):lower() == "trouble"
          end,
        },
      },
      options = {
        left = { size = 38 },
        right = { size = 38 },
        bottom = { size = 12 },
        top = { size = 10 },
      },
    },
  },
}

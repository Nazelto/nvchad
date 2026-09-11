return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline_popup",
      },
      messages = {
        enabled = true,
        view = "notify",
        view_error = "notify",
        view_warn = "notify",
      },
      notify = {
        enabled = true,
        view = "notify",
      },
      lsp = {
        -- Let Neovim create hover floats so their focus behavior is controlled
        -- by the buffer-local mapping below.
        hover = {
          enabled = false,
        },
      },
      presets = {
        command_palette = true,
      },
    },
  },
}

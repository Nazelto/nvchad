return {
  {
    "hedyhli/outline.nvim",
    cmd = {
      "Outline",
      "OutlineOpen",
      "OutlineClose",
      "OutlineToggle",
      "OutlineFocus",
      "OutlineFollow",
      "OutlineRefresh",
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
    config = function(_, opts)
      require("outline").setup(opts)
    end,
  },
}

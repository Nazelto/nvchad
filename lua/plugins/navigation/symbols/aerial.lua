return {
  {
    "stevearc/aerial.nvim",
    cmd = {
      "AerialToggle",
      "AerialOpen",
      "AerialOpenAll",
      "AerialClose",
      "AerialCloseAll",
      "AerialNavToggle",
      "AerialNavOpen",
      "AerialNavClose",
      "AerialNext",
      "AerialPrev",
      "AerialGo",
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
      layout = {
        min_width = 35,
      },
      show_guides = true,
    },
    config = function(_, opts)
      require("aerial").setup(opts)

      pcall(require("telescope").load_extension, "aerial")
    end,
  },
}

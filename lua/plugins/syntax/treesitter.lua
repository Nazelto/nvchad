return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    opts = function()
      return {
        "vim",
        "lua",
        "vimdoc",
        "regex",
        "bash",
        "markdown",
        "markdown_inline",
        "html",
        "css",
        "c",
        "cpp",
        "haskell",
        "nix",
        "rust",
        "python",
        "v",
      }
    end,
    config = function(_, parsers)
      require("nvim-treesitter").install(parsers)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = parsers,
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
}

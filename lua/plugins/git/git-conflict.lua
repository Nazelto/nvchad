return {
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      default_mappings = {
        ours = "gco",
        theirs = "gct",
        both = "gcb",
        none = "gc0",
        next = "g[x",
        prev = "g]x",
      },
    },
  },
}

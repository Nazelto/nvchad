return {
  {
    "Bekaboo/dropbar.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    keys = {
      { "<leader>;", function() require("dropbar.api").pick() end, desc = "选择顶部符号" },
      { "[;", function() require("dropbar.api").goto_context_start() end, desc = "跳到当前作用域开头" },
      { "];", function() require("dropbar.api").select_next_context() end, desc = "选择下一个作用域" },
    },
  },
}

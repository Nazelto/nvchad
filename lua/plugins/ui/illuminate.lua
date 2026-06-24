return {
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
      require("illuminate").configure({
        disable_keymaps = true,
      })
    end,
  },
}

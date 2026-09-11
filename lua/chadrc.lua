-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}
M.base46 = {
  theme = "tokyonight",
  transparency = true,
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    Function = { italic = true },
  },
}

M.nvdash = { load_on_startup = true }
-- Temporarily disable NvChad's automatic LSP signature window while testing
-- the Insert-mode exit issue. This config currently uses nvim-cmp, not blink.
M.lsp = {
  signature = false,
}
M.ui = {
  tabufline = {
    lazyload = false,
  },
  telescope = {
    style = "bordered",
  },
}

return M

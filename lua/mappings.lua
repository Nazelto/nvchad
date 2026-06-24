require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

local function code_symbols()
  local ok_telescope, telescope = pcall(require, "telescope")
  if ok_telescope and telescope.extensions and telescope.extensions.aerial then
    telescope.extensions.aerial.aerial()
    return
  end

  local ok_builtin, builtin = pcall(require, "telescope.builtin")
  if ok_builtin then
    builtin.lsp_document_symbols()
    return
  end

  if vim.fn.exists(":AerialOpen") == 2 then
    vim.cmd.AerialOpen()
    return
  end

  if vim.fn.exists(":Outline") == 2 then
    vim.cmd.Outline()
  end
end

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>cs", code_symbols, { desc = "code symbols" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

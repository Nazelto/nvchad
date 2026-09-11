require "nvchad.autocmds"

-- Completion and LSP documentation are display-only popups. Some plugin/window
-- combinations can still enter them and leave subsequent input in the popup.
local last_edit_window = {}

local function is_documentation_float(win)
  local config = vim.api.nvim_win_get_config(win)
  if config.relative == "" then
    return false
  end

  local buf = vim.api.nvim_win_get_buf(win)
  local filetype = vim.bo[buf].filetype
  return filetype == "cmp_docs" or filetype == "noice" or vim.bo[buf].syntax == "markdown"
end

local focus_group = vim.api.nvim_create_augroup("KeepDocumentationUnfocused", { clear = true })

vim.api.nvim_create_autocmd("WinLeave", {
  group = focus_group,
  callback = function()
    local win = vim.api.nvim_get_current_win()
    if not is_documentation_float(win) then
      last_edit_window[vim.api.nvim_get_current_tabpage()] = win
    end
  end,
})

vim.api.nvim_create_autocmd("WinEnter", {
  group = focus_group,
  callback = function()
    local documentation_win = vim.api.nvim_get_current_win()
    if not is_documentation_float(documentation_win) then
      return
    end

    local tabpage = vim.api.nvim_get_current_tabpage()
    local edit_win = last_edit_window[tabpage]
    local mode = vim.api.nvim_get_mode().mode
    vim.schedule(function()
      if
        vim.api.nvim_get_current_win() == documentation_win
        and edit_win
        and vim.api.nvim_win_is_valid(edit_win)
      then
        vim.api.nvim_set_current_win(edit_win)
        if mode:sub(1, 1) == "i" then
          vim.cmd "startinsert"
        end
      end
    end)
  end,
})

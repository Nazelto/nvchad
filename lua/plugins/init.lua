return {
  {
    "windwp/nvim-autopairs",
    -- LSP CompletionItem.data is allowed to be any value. Some servers use a
    -- string here, while nvim-autopairs' Python handler expects a table.
    opts = function(_, opts)
      local handlers = require "nvim-autopairs.completion.handlers"
      local python_handler = handlers.python

      handlers.python = function(char, item, ...)
        if type(item.data) ~= "table" then
          item = vim.tbl_extend("force", {}, item)
          item.data = nil
        end
        return python_handler(char, item, ...)
      end

      return opts
    end,
  },
  { import = "plugins.format" },
  { import = "plugins.git" },
  { import = "plugins.navigation" },
  { import = "plugins.dropbar" },
  { import = "plugins.lsp" },
  { import = "plugins.syntax" },
  { import = "plugins.ui" },
}

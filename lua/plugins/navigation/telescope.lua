local function lsp_reference_entry_maker(opts)
  local entry_display = require "telescope.pickers.entry_display"
  local make_entry = require "telescope.make_entry"
  local utils = require "telescope.utils"
  local displayer = entry_display.create {
    separator = " ",
    items = {
      { width = 2 },
      { width = 24 },
      { width = 42 },
      { width = 10, right_justify = true },
    },
  }
  local quickfix_entry = make_entry.gen_from_quickfix(opts)

  return function(item)
    local entry = quickfix_entry(item)
    if not entry then return end

    entry.display = function(reference)
      local filename = reference.filename or ""
      local relative = vim.fn.fnamemodify(filename, ":p:.")
      local basename = vim.fn.fnamemodify(relative, ":t")
      local directory = vim.fn.fnamemodify(relative, ":h")
      if directory == "." then directory = "" end
      local icon, icon_hl = utils.get_devicons(filename, false)

      return displayer {
        { icon, icon_hl or "Directory" },
        { basename, "TelescopeResultsIdentifier" },
        { directory, "TelescopeResultsComment" },
        { string.format("%d:%d", reference.lnum or 0, reference.col or 0), "TelescopeResultsNumber" },
      }
    end
    return entry
  end
end

local reference_entry_maker = lsp_reference_entry_maker {}

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-ui-select.nvim",
    },
    opts = function(_, opts)
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
          },
        },
      })
      opts.pickers = vim.tbl_deep_extend("force", opts.pickers or {}, {
        lsp_references = {
          show_line = false,
          path_display = { "smart" },
          entry_maker = reference_entry_maker,
          layout_strategy = "horizontal",
          layout_config = {
            width = 0.96,
            height = 0.92,
            preview_width = 0.45,
            prompt_position = "top",
          },
        },
      })
      opts.extensions = opts.extensions or {}
      opts.extensions["ui-select"] = require("telescope.themes").get_dropdown {}
      return opts
    end,
    keys = {
      {
        "<leader>ss",
        function()
          require("telescope.builtin").lsp_document_symbols()
        end,
        desc = "Goto Symbol",
      },
      {
        "<leader>sS",
        function()
          require("telescope.builtin").lsp_dynamic_workspace_symbols()
        end,
        desc = "Goto Symbol (Workspace)",
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      pcall(require("telescope").load_extension, "ui-select")
    end,
  },
}

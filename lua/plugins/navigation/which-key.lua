return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.preset = "helix"
      opts.win = vim.tbl_deep_extend("force", opts.win or {}, {
        col = -1,
        row = -1,
        border = "rounded",
        title = true,
        title_pos = "left",
      })
      opts.triggers = opts.triggers or { { "<auto>", mode = "nxso" } }
      table.insert(opts.triggers, { "[", mode = "nxo" })
      table.insert(opts.triggers, { "]", mode = "nxo" })
      return opts
    end,
    config = function(_, opts)
      local which_key = require "which-key"
      which_key.setup(opts)

      local function add_section_descriptions()
        which_key.add {
          { "[[", desc = "Previous top-level block", mode = "n" },
          { "]]", desc = "Next top-level block", mode = "n" },
        }
      end

      if vim.v.vim_did_enter == 1 then
        vim.schedule(add_section_descriptions)
      else
        vim.api.nvim_create_autocmd("VimEnter", {
          once = true,
          callback = function()
            vim.schedule(add_section_descriptions)
          end,
        })
      end
    end,
  },
}

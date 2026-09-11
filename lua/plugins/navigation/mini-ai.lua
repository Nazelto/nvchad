return {
  {
    "nvim-mini/mini.ai",
    event = "VeryLazy",
    dependencies = {
      {
        "folke/which-key.nvim",
      },
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        event = "VeryLazy",
      },
    },
    opts = function()
      local ai = require("mini.ai")

      local function buffer(ai_type)
        local first, last = 1, vim.fn.line("$")
        if ai_type == "i" then
          first = vim.fn.nextnonblank(first)
          last = vim.fn.prevnonblank(last)
          if first == 0 or last == 0 then
            return { from = { line = 1, col = 1 } }
          end
        end

        return {
          from = { line = first, col = 1 },
          to = { line = last, col = math.max(vim.fn.getline(last):len(), 1) },
        }
      end

      return {
        n_lines = 500,
        custom_textobjects = {
          -- o: code block, conditional, or loop
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          -- f: entire function definition
          f = ai.gen_spec.treesitter({
            a = "@function.outer",
            i = "@function.inner",
          }),
          -- c: entire class definition
          c = ai.gen_spec.treesitter({
            a = "@class.outer",
            i = "@class.inner",
          }),
          -- The remaining objects follow LazyVim's defaults.
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
          d = { "%f[%d]%d+" },
          e = {
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          g = buffer,
          u = ai.gen_spec.function_call(),
          U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }),
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)

      -- Show mini.ai's operator-pending and visual textobjects in which-key.
      require("which-key").add({
        { "a", group = "around", mode = { "o", "x" } },
        { "i", group = "inside", mode = { "o", "x" } },
        { "af", desc = "function", mode = { "o", "x" } },
        { "if", desc = "function", mode = { "o", "x" } },
        { "ac", desc = "class", mode = { "o", "x" } },
        { "ic", desc = "class", mode = { "o", "x" } },
        { "ao", desc = "block / conditional / loop", mode = { "o", "x" } },
        { "io", desc = "block / conditional / loop", mode = { "o", "x" } },
        { "ag", desc = "entire file", mode = { "o", "x" } },
        { "ig", desc = "file contents", mode = { "o", "x" } },
        { "au", desc = "function call", mode = { "o", "x" } },
        { "aU", desc = "function call without dot", mode = { "o", "x" } },
      }, { notify = false })
    end,
  },
}

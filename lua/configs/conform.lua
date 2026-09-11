local options = {
  formatters = {
    clang_format = {
      prepend_args = {
        "--style={BasedOnStyle: LLVM, IndentWidth: 4, ColumnLimit: 100, BreakTemplateDeclarations: Yes, BinPackParameters: false, AllowAllParametersOfDeclarationOnNextLine: false, AllowShortFunctionsOnASingleLine: Empty, AllowShortLambdasOnASingleLine: Inline}",
      },
    },
  },

  formatters_by_ft = {
    lua = { "stylua" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    objc = { "clang_format" },
    objcpp = { "clang_format" },
    nix = { "nixfmt" },
    python = { "ruff_format" },
    rust = { "rustfmt" },
    cabal = { "cabal_fmt" },
    v = { "v" },
    vsh = { "v" },
    vv = { "v" },
    -- python = function(bufnr)
    --   if require("conform").get_formatter_info("ruff_format", bufnr).available then
    --     return { "ruff_format" }
    --   end
    --   return { "isort", "black" }
    -- end,
    -- -- css = { "prettier" },
    -- html = { "prettier" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
}

return options

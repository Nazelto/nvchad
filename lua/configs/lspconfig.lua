require("nvchad.configs.lspconfig").defaults()

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local builtin = require "telescope.builtin"
    local opts = function(desc)
      return { buffer = args.buf, desc = "LSP " .. desc }
    end

    vim.keymap.set("n", "gd", builtin.lsp_definitions, opts "Go to definition")
    vim.keymap.set("n", "gr", builtin.lsp_references, opts "Go to references")
    vim.keymap.set("n", "gI", builtin.lsp_implementations, opts "Go to implementation")
    vim.keymap.set("n", "gy", builtin.lsp_type_definitions, opts "Go to type definition")
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  end,
})

vim.lsp.config("basedpyright", {
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        typeCheckingMode = "standard",
        useLibraryCodeForTypes = true,
      },
    },
  },
})

vim.lsp.config("ruff", {
  init_options = {
    settings = {},
  },
})

vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      checkOnSave = true,
      check = {
        command = "clippy",
        extraArgs = { "--all-targets" },
      },

      procMacro = {
        enable = true,
      },

      diagnostics = {
        enable = true,
      },
    },
  },
})

local servers = { "html", "cssls", "nixd", "lua_ls", "basedpyright", "ruff", "rust_analyzer" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers

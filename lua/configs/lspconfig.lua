require("nvchad.configs.lspconfig").defaults()

vim.diagnostic.config {
  virtual_text = {
    severity = {
      min = vim.diagnostic.severity.HINT,
    },
    source = "if_many",
    spacing = 2,
  },
  signs = true,
  underline = true,
  float = {
    source = "if_many",
  },
}

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
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover {
        focusable = false,
      }
    end, opts "Hover documentation")

    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, args.buf) then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})

vim.lsp.config("pyrefly", {
  init_options = {
    pyrefly = {
      typeCheckingMode = "default",
      disableTypeErrors = false,
      analysis = {
        diagnosticMode = "workspace",
        inlayHints = {
          callArgumentNames = "all",
          functionReturnTypes = true,
          pytestParameters = false,
          variableTypes = true,
        },
      },
      disabledLanguageServices = {
        inlayHint = false,
      },
    },
  },
})

vim.lsp.config("ruff", {
  init_options = {
    settings = {},
  },
})

vim.lsp.config("tombi", {})

vim.lsp.config("v_analyzer", {})

vim.lsp.config("zls", {
  settings = {
    zls = {
      inlay_hints_exclude_single_argument = false,
      inlay_hints_show_builtin = true,
      inlay_hints_show_parameter_name = true,
      inlay_hints_show_struct_literal_field_type = true,
      inlay_hints_show_variable_type_hints = true,
    },
  },
})

vim.lsp.config("clangd", {
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
  },
})

vim.lsp.config("hls", {
  filetypes = { "haskell", "lhaskell", "cabal" },
  settings = {
    haskell = {
      cabalFormattingProvider = "cabal-fmt",
      plugin = {
        cabal = {
          globalOn = true,
        },
        inlayHints = {
          globalOn = true,
        },
      },
    },
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
        allTargets = true,
      },

      procMacro = {
        enable = true,
      },

      diagnostics = {
        enable = true,
      },
      inlayHints = {
        typeHints = {
          enable = true,
        },
        parameterHints = {
          enable = true,
        },
        chainingHints = {
          enable = true,
        },
        closingBraceHints = {
          enable = true,
        },
      },
    },
  },
})
vim.lsp.config("nixd", {
  settings = {
    nixd = {
      nixpkgs = {
        expr = [[import (builtins.getFlake (toString ./.)).inputs.nixpkgs {system = "x86_64-linux";}]],
      },
    },
  },
})

local servers = {
  "html",
  "cssls",
  "clangd",
  "nixd",
  "lua_ls",
  "pyrefly",
  "ruff",
  "rust_analyzer",
  "tombi",
  "hls",
  "v_analyzer",
  "zls",
}
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers

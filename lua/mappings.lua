require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

local function diagnostic_jump(count, severity)
  return function()
    vim.diagnostic.jump {
      count = count,
      severity = severity,
    }
  end
end

local function treesitter_jump(direction, query)
  return function()
    require("nvim-treesitter-textobjects.move")[direction](query, "textobjects")
  end
end

local function describe_buffer_mapping(buf, lhs, desc)
  local mapping
  vim.api.nvim_buf_call(buf, function()
    mapping = vim.fn.maparg(lhs, "n", false, true)
  end)
  if vim.tbl_isempty(mapping) or mapping.buffer ~= 1 then
    return
  end

  local rhs = mapping.callback or mapping.rhs
  if type(rhs) == "string" and mapping.sid and mapping.sid > 0 then
    rhs = rhs:gsub("<SID>", "<SNR>" .. mapping.sid .. "_")
  end

  map("n", lhs, rhs, {
    buffer = buf,
    desc = desc,
    expr = mapping.expr == 1,
    nowait = mapping.nowait == 1,
    remap = mapping.noremap == 0,
    silent = mapping.silent == 1,
  })
end

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

  if vim.fn.exists ":AerialOpen" == 2 then
    vim.cmd.AerialOpen()
    return
  end

  if vim.fn.exists ":Outline" == 2 then
    vim.cmd.Outline()
  end
end

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- Guard against a stale/plugin-provided insert-mode mapping that makes `n`
-- leave Insert mode.  This must be non-recursive and global.
map("i", "n", "n", { noremap = true, silent = true })
map("n", "<leader>cs", code_symbols, { desc = "code symbols" })

-- Neovim provides many default bracket mappings. Keep the useful quickfix
-- pair and remove low-frequency mappings which duplicate existing navigation.
for _, lhs in ipairs {
  "[<C-L>",
  "]<C-L>",
  "[<C-Q>",
  "]<C-Q>",
  "[<C-T>",
  "]<C-T>",
  "[A",
  "]A",
  "[B",
  "]B",
  "[D",
  "]D",
  "[L",
  "]L",
  "[Q",
  "]Q",
  "[T",
  "]T",
  "[a",
  "]a",
  "[b",
  "]b",
  "[d",
  "]d",
  "[l",
  "]l",
  "[t",
  "]t",
} do
  pcall(vim.keymap.del, "n", lhs)
end

map("n", "[q", "<cmd>cprevious<cr>", { desc = "Previous quickfix item" })
map("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix item" })
map("n", "[f", treesitter_jump("goto_previous_start", "@function.outer"), { desc = "Previous function" })
map("n", "]f", treesitter_jump("goto_next_start", "@function.outer"), { desc = "Next function" })
map("n", "[c", treesitter_jump("goto_previous_start", "@class.outer"), { desc = "Previous class" })
map("n", "]c", treesitter_jump("goto_next_start", "@class.outer"), { desc = "Next class" })

local section_mapping_group = vim.api.nvim_create_augroup("DescribeSectionMappings", { clear = true })
local function describe_section_mappings(buf)
  describe_buffer_mapping(buf, "[[", "Previous top-level block")
  describe_buffer_mapping(buf, "]]", "Next top-level block")
end

vim.api.nvim_create_autocmd("FileType", {
  group = section_mapping_group,
  callback = function(args)
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(args.buf) then
        describe_section_mappings(args.buf)
      end
    end)
  end,
})

describe_section_mappings(vim.api.nvim_get_current_buf())

-- Function navigation now lives on [f / ]f.
map("n", "[m", "<Nop>", { desc = "which_key_ignore" })
map("n", "]m", "<Nop>", { desc = "which_key_ignore" })

local method_mapping_group = vim.api.nvim_create_augroup("DisableLegacyMethodMappings", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = method_mapping_group,
  callback = function(args)
    map("n", "[m", "<Nop>", { buffer = args.buf, desc = "which_key_ignore" })
    map("n", "]m", "<Nop>", { buffer = args.buf, desc = "which_key_ignore" })
  end,
})

map("n", "[e", diagnostic_jump(-1, vim.diagnostic.severity.ERROR), { desc = "previous error" })
map("n", "]e", diagnostic_jump(1, vim.diagnostic.severity.ERROR), { desc = "next error" })
map("n", "[w", diagnostic_jump(-1, vim.diagnostic.severity.WARN), { desc = "previous warning" })
map("n", "]w", diagnostic_jump(1, vim.diagnostic.severity.WARN), { desc = "next warning" })
map("n", "[h", diagnostic_jump(-1, vim.diagnostic.severity.HINT), { desc = "previous hint" })
map("n", "]h", diagnostic_jump(1, vim.diagnostic.severity.HINT), { desc = "next hint" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

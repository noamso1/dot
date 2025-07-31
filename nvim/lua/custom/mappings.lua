---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["c"] = { "\"_c", opts = { nowait = true } },
    ["C"] = { "\"_C", opts = { nowait = true } },
    ["<C-c>"] = { "<ESC>", "DISABLE Copy whole file" },
  },
  v = {
    -- [">"] = { ">gv", "indent"},
    ["c"] = { "\"_c", opts = { nowait = true } },
    ["C"] = { "\"_C", opts = { nowait = true } },
  },
}

M.nvimtree = {
  n = {
    ["<C-q>"] = { "<cmd> :qa<CR>" },
  },
}

-- more keybinds!

return M

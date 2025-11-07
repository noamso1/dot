-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  Comment = {
    italic = false,
    fg = '#666666',
  },
  ['@comment'] = {
        italic = false,
        fg = '#666666',
    },
  -- IndentBlanklineContextStart = {
  --   bg = 'none',
  --   underline = false,
  -- },
  Search = {
    bg = 'black',
    fg = 'white',
    bold = true
  },
  -- Visual = {
  --   bg = '#444444',
  -- },
  -- NvimTreeCursorLine = {
  --   bg = '#444444',
  -- },
  -- TbLineBufOn = {
  --   bg = '#444444'
  -- },
}

---@type HLTable
M.add = {
  NvimTreeOpenedFolderName = { fg = "green", bold = true },
}

return M

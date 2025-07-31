---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "catppuccin",
  theme_toggle = { "catppuccin", "catppuccin" },

  hl_override = highlights.override,
  hl_add = highlights.add,

  statusline = {
    overriden_modules = function(modules)
      modules[2] = (function()
        local fn = vim.fn
        local config = require("core.utils").load_config().ui.statusline
        local sep_style = config.separator_style
        local default_sep_icons = {
          default = { left = "", right = " " },
          round = { left = "", right = "" },
          block = { left = "█", right = "█" },
          arrow = { left = "", right = "" },
        }
        local separators = (type(sep_style) == "table" and sep_style) or default_sep_icons[sep_style]
        local sep_r = separators["right"]
        local icon = " 󰈚 "
        local filename = (fn.expand "%" == "" and "Empty ") or fn.expand "%:p" --change here
        if filename ~= "Empty " then
          local devicons_present, devicons = pcall(require, "nvim-web-devicons")
          if devicons_present then
            local ft_icon = devicons.get_icon(filename)
            icon = (ft_icon ~= nil and " " .. ft_icon) or ""
          end
          filename = " " .. filename .. " "
        end
        return "%#St_file_info#" .. icon .. filename .. "  line %l / %L  col %c   " .. "%#St_file_sep#"
      end)()
    end,
  },

}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M

require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"

-- Talk to TMUX clipboard
vim.opt.clipboard:append('unnamedplus')
local function yank_to_tmux_clipboard()
  local yank = vim.fn.getreg('"')
  local handle = io.popen('tmux load-buffer -', 'w')
  if handle then
    handle:write(yank)
    handle:close()
  end
end
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    if vim.v.event.operator == 'y' then
      yank_to_tmux_clipboard()
    end
  end
})

vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#a6e22e' })
vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#2266ff' })
vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#f92672' })
vim.api.nvim_set_hl(0, 'GitSignsTopDelete', { fg = '#f92672' })
vim.api.nvim_set_hl(0, 'GitSignsChangeDelete', { fg = '#fd971f' })
vim.api.nvim_set_hl(0, 'GitSignsUntracked', { fg = '#cfcfcf' })

vim.opt.swapfile = false


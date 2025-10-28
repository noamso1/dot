
vim.opt.wrap = false
vim.opt.undofile = false
vim.opt.incsearch = false
vim.opt.hlsearch = true
vim.opt.wrapscan = false
vim.opt.scrolloff = 8
vim.opt.mouse = ""
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.confirm = true
vim.opt.number = false

vim.keymap.set("n", " s", ":luafile ~/.config/nvim/lua/custom/init.lua<CR>:echo 'CUSTOM init.lua sourced'<CR>") -- source init.lua
-- vim.keymap.set("n", " s", ":luafile ~/.config/nvim/init.lua<CR>:echo 'init.lua sourced'<CR>") -- source init.lua
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", " j", ":%!node ~/dot/json5parser.js<CR>") -- parse json
vim.keymap.set("v", " j", ":!node ~/dot/json5parser.js<CR>") -- parse json
vim.keymap.set("n", " d", "V:!node ~/dot/dstdin.js<CR>") -- convert UTC timestamp to milli
vim.keymap.set("v", " d", "y<Esc>`>a<CR><Esc>`<i<CR><Esc>!!node ~/dot/dstdin.js<CR>kgJgJ") -- convert UTC timestamp to milli
vim.keymap.set("n", " t", ":%s/\\s\\+$//e<CR>") -- trim trailing spaces
vim.keymap.set("n", " a", "ggVG") -- select all

vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<ESC>:w<CR>")
vim.keymap.set("v", "<C-s>", "<ESC>:w<CR>")
vim.keymap.set("n", "<C-q>", ":qa<CR>")
vim.keymap.set("i", "<C-q>", "<ESC>:qa<CR>")
vim.keymap.set("v", "<C-q>", "<ESC>:qa<CR>")

vim.keymap.set("n", "x", "\"_x") -- delete without cut
vim.keymap.set("v", "x", "\"_x") -- delete without cut
vim.keymap.set("n", "X", "V\"_x") -- delete line without cut
-- vim.keymap.set("v", "p", "pgvy") -- paste without cutting the replaced text ( no need - default in nvchad )
-- vim.keymap.set("v", "P", "Pgvy") -- paste without cutting the replaced text ( no need - default in nvchad )
-- vim.keymap.set("v", "p", "_dp") -- paste without cutting the replaced text ( no need - default in nvchad )
-- vim.keymap.set("v", "P", "_dP") -- paste without cutting the replaced text ( no need - default in nvchad )

-- vim.keymap.set("n", "j", "j") --disable some stupid nvchad mappings ( no need - done in mappings.lua )
-- vim.keymap.set("n", "k", "k") --disable some stupid nvchad mappings ( no need - done in mappings.lua )
-- vim.keymap.set("v", "j", "j") --disable some stupid nvchad mappings ( no need - done in mappings.lua )
-- vim.keymap.set("v", "k", "k") --disable some stupid nvchad mappings ( no need - done in mappings.lua )
-- vim.keymap.set("x", "j", "j") --disable some stupid nvchad mappings ( no need - done in mappings.lua )
-- vim.keymap.set("x", "k", "k") --disable some stupid nvchad mappings ( no need - done in mappings.lua )

-- prettier
vim.keymap.set("n", "<leader>F", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file with Prettier" })

vim.cmd("autocmd BufEnter * set formatoptions-=cro") -- disable auto comment next line
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro") -- disable auto comment next line
-- vim.cmd("autocmd VimEnter * NvimTreeToggle") -- disable auto comment next line
-- vim.schedule(function() require("nvim-tree.api").tree.open() end)

--- jump to last position
local group = vim.api.nvim_create_augroup("jump_last_position", { clear = true })
vim.api.nvim_create_autocmd(
  "BufReadPost",
  {callback = function()
    local row, col = unpack(vim.api.nvim_buf_get_mark(0, "\""))
      if {row, col} ~= {0, 0} then
        vim.api.nvim_win_set_cursor(0, {row, 0})
      end
    end,
  group = group
  }
)

vim.cmd('highlight ExtraWhitespace ctermbg=red guibg=red')
vim.cmd('match ExtraWhitespace /\\s\\+$/')


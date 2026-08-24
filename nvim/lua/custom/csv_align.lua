-- Align/unalign CSV columns with padding spaces, quote-aware.
local M = {}

-- Split one CSV line into raw cells, respecting double quotes.
-- Commas inside quotes are kept as part of the cell; "" escapes work too.
local function split_line(line)
  local cells = {}
  local buf = {}
  local in_quotes = false
  for i = 1, #line do
    local c = line:sub(i, i)
    if c == '"' then
      in_quotes = not in_quotes
      buf[#buf + 1] = c
    elseif c == "," and not in_quotes then
      cells[#cells + 1] = table.concat(buf)
      buf = {}
    else
      buf[#buf + 1] = c
    end
  end
  cells[#cells + 1] = table.concat(buf)
  return cells
end

-- Padding lives outside the quotes (before the value / after the closing
-- quote), so stripping a raw cell's surrounding spaces never touches data.
local function strip(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

local function parse_buffer()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local rows = {}
  for _, line in ipairs(lines) do
    local cells = split_line(line)
    for j, cell in ipairs(cells) do
      cells[j] = strip(cell)
    end
    rows[#rows + 1] = cells
  end
  return rows
end

function M.align()
  local rows = parse_buffer()
  local widths = {}
  for _, cells in ipairs(rows) do
    for j, cell in ipairs(cells) do
      local w = vim.fn.strdisplaywidth(cell)
      if not widths[j] or w > widths[j] then
        widths[j] = w
      end
    end
  end
  local out = {}
  for _, cells in ipairs(rows) do
    local parts = {}
    for j, cell in ipairs(cells) do
      if j < #cells then
        -- comma sticks to the value; +1 keeps at least one space after it
        parts[j] = cell .. "," .. string.rep(" ", widths[j] - vim.fn.strdisplaywidth(cell) + 1)
      else
        parts[j] = cell -- last cell: no padding, no trailing whitespace
      end
    end
    out[#out + 1] = table.concat(parts)
  end
  vim.api.nvim_buf_set_lines(0, 0, -1, false, out)
end

function M.unalign()
  local rows = parse_buffer()
  local out = {}
  for _, cells in ipairs(rows) do
    out[#out + 1] = table.concat(cells, ",")
  end
  vim.api.nvim_buf_set_lines(0, 0, -1, false, out)
end

return M

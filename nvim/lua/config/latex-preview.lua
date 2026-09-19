local M = {}

function M.setup()
  local View = require("render-markdown.request.view")
  if View._compact_math then return end
  View._compact_math = true
  local new = View.new
  View.new = function(buf)
    local view = new(buf)
    -- Concealing long source blocks moves more text into the viewport AFTER
    -- the plugin has selected its parse range. Render short math notes fully
    -- so newly exposed formulas do not remain as raw LaTeX until scrolling.
    local count = vim.api.nvim_buf_line_count(buf)
    if count <= 2000 then
      for _, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
        if line:match("^%s*%$%$%s*$") then
          view.ranges = { { 0, count } }
          break
        end
      end
    end
    return view
  end
end

-- Keep the renderer's formula output, but hide standalone $$ source blocks
-- in reading modes. The renderer clears these marks when entering Insert mode.
function M.parse(ctx)
  local marks = require("render-markdown.handler.latex").parse(ctx)
  local lines = vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)
  local hidden = {}
  for _, mark in ipairs(marks) do
    local row = mark.start_row
    if mark.opts.virt_lines and (lines[row + 1] or ""):match("^%s*%$%$%s*$") then
      local valid = false
      for _, line in ipairs(mark.opts.virt_lines) do
        for _, chunk in ipairs(line) do
          if chunk[1]:match("%S") and vim.trim(chunk[1]) ~= "error" then
            valid = true
          end
        end
      end
      if valid then
        for last = row + 2, #lines do
          if lines[last]:match("^%s*%$%$%s*$") then
            -- Put the first rendered line ON the source anchor. An empty $$
            -- anchor below virtual lines used to add a blank row to every block.
            local output = mark.opts.virt_lines
            local first = table.remove(output, 1)
            mark.opts.virt_lines_above = false
            if #output == 0 then
              mark.opts.virt_lines = nil
            end
            hidden[#hidden + 1] = {
              conceal = "latex",
              start_row = row,
              start_col = 0,
              opts = {
                end_row = row, end_col = #lines[row + 1], conceal = "",
                virt_text = first, virt_text_pos = "overlay",
              },
            }
            hidden[#hidden + 1] = {
              conceal = "latex",
              start_row = row + 1,
              start_col = 0,
              opts = { end_row = last - 1, end_col = #lines[last], conceal_lines = "" },
            }
            break
          end
        end
      end
    end
  end
  vim.list_extend(marks, hidden)
  return marks
end

return M

local M = {}

local get_map_options = function(custom_options)
  local options = { noremap = true, silent = true }
  if custom_options then
    options = vim.tbl_extend('force', options, custom_options)
  end
  return options
end

M.map = function(mode, target, source, opts)
  vim.keymap.set(mode, target, source, get_map_options(opts))
end

for _, mode in ipairs({ 'n', 'o', 'i', 'x', 't' }) do
  M[mode .. 'map'] = function(...)
    M.map(mode, ...)
  end
end

M.buf_map = function(bufnr, mode, target, source, opts)
  opts = opts or {}
  opts.buffer = bufnr

  M.map(mode, target, source, get_map_options(opts))
end

M.for_each = function(tbl, cb)
  for _, v in ipairs(tbl) do
    cb(v)
  end
end

M.command = function(name, fn, opts)
  vim.api.nvim_create_user_command(name, fn, opts or {})
end

M.buf_command = function(bufnr, name, fn, opts)
  vim.api.nvim_buf_create_user_command(bufnr, name, fn, opts or {})
end

M.warn = function(msg)
  vim.api.nvim_echo({ { msg, 'WarningMsg' } }, true, {})
end

-- avoid hjkl spamming
function M.cowboy()
  ---@type table?
  local id
  for _, key in ipairs({ "h", "j", "k", "l" }) do
    local count = 0
    vim.keymap.set("n", key, function()
      if count >= 10 then
        id = vim.notify("Hold it Cowboy!", vim.log.levels.WARN, {
          icon = "🤠",
          replace = id,
          keep = function()
            return count >= 10
          end,
        })
      else
        count = count + 1
        vim.defer_fn(function()
          count = count - 1
        end, 5000)
        return key
      end
    end, { expr = true, silent = true })
  end
end

---@param silent boolean?
---@param values? {[1]:any, [2]:any}
function M.toggle(option, silent, values)
  if values then
    if vim.opt_local[option]:get() == values[1] then
      vim.opt_local[option] = values[2]
    else
      vim.opt_local[option] = values[1]
    end
    return vim.notify(
      "Set " .. option .. " to " .. vim.opt_local[option]:get(),
      vim.log.levels.INFO,
      { title = "Option" }
    )
  end
  vim.opt_local[option] = not vim.opt_local[option]:get()
  if not silent then
    vim.notify(
      (vim.opt_local[option]:get() and "Enabled" or "Disabled") .. " " .. option,
      vim.log.levels.INFO,
      { title = "Option" }
    )
  end
end

local enabled = true
function M.toggle_diagnostics()
  enabled = not enabled
  if enabled then
    vim.diagnostic.enable()
    vim.notify("Enabled diagnostics", vim.log.levels.INFO, { title = "Diagnostics" })
  else
    vim.diagnostic.disable()
    vim.notify("Disabled diagnostics", vim.log.levels.INFO, { title = "Diagnostics" })
  end
end

function M.closeEmptyNvim()
  if vim.fn.bufname() == '' and vim.fn.line('$') == 1 and vim.fn.getline(1) == '' then
    vim.cmd('quit!')
  else
    vim.cmd('bd!')
  end
end

return M

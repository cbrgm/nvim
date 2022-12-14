-- ==============================================================================================
-- AUTO COMMANDS
-- ==============================================================================================
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = augroup('Packer', { clear = true })
autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

-- highlight on yank
local highlight_group = augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- don't auto comment new line
autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

--- Remove all trailing whitespace on save
local trim_whitespace_group = augroup("TrimWhiteSpaceGrp", { clear = true })
autocmd("BufWritePre", {
  command = [[:%s/\s\+$//e]],
  group = trim_whitespace_group,
})

-- Toggle relative line numbers in normal mode
local numbertoggle_group = augroup("numbertoggle", { clear = true })
autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
  pattern = "*",
  group = numbertoggle_group,
  callback = function()
    if vim.o.number and vim.api.nvim_get_mode().mode ~= "i" then
      vim.opt.relativenumber = true
    end
  end,
})

-- toggle absolute line numbers in insert mode
autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
  pattern = "*",
  group = numbertoggle_group,
  callback = function()
    if vim.o.number then
      vim.opt.relativenumber = false
      vim.cmd "redraw"
    end
  end,
})

-- reload buffer automatically when file on disk changed
local autoreload_group = augroup("update_file", { clear = true })
autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  callback = function()
    local regex = vim.regex([[\(c\|r.?\|!\|t\)]])
    local mode = vim.api.nvim_get_mode()["mode"]
    if (not regex:match_str(mode)) and vim.fn.getcmdwintype() == "" then
      vim.cmd 'checktime'
    end
  end,
  desc = "If the file is changed outside of neovim, reload it automatically.",
  group = autoreload_group,
  pattern = "*",
})

autocmd("FileChangedShellPost", {
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded!", vim.log.levels.WARN)
  end,
  desc = "If the file is changed outside of neovim, reload it automatically.",
  group = autoreload_group,
  pattern = "*",
})

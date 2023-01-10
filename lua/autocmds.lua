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

-- Highlight on yank
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- don't auto comment new line
autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

--- Remove all trailing whitespace on save
local trim_whitespace_group = augroup("TrimWhiteSpaceGrp", { clear = true })
autocmd("BufWritePre", {
  command = [[:%s/\s\+$//e]],
  group = trim_whitespace_group,
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

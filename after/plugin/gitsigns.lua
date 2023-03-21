-- ==============================================================================================
-- PLUGIN: GITSIGNS
-- ==============================================================================================
local u = require('utils')
local gitsigns_ok, gitsigns = pcall(require, "gitsigns")
if not gitsigns_ok then return end

local telescope_ok, _ = pcall(require, "telescope")
if not telescope_ok then return end

gitsigns.setup {
  keymaps = {
    -- Default keymap options
    noremap = false
  },
  signs = {
    add = {
      hl = "GitSignsAdd",
      text = "│",
      numhl = "GitSignsAddNr",
      linehl = "GitSignsAddLn"
    },
    change = {
      hl = "GitSignsChange",
      text = "│",
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn"
    },
    delete = {
      hl = "GitSignsDelete",
      text = "_",
      numhl = "GitSignsDeleteNr",
      linehl = "GitSignsDeleteLn"
    },
    topdelete = {
      hl = "GitSignsDelete",
      text = "‾",
      numhl = "GitSignsDeleteNr",
      linehl = "GitSignsDeleteLn"
    },
    changedelete = {
      hl = "GitSignsChange",
      text = "~",
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn"
    }
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = { interval = 1000, follow_files = true },
  attach_to_untracked = true,
  -- git-blame provides also the time in contrast to gitsigns
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_formatter_opts = { relative_time = false },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1
  },
  diff_opts = { internal = true },
  yadm = { enable = false }
}

-- Move to hunks
u.map("n", "]h", gitsigns.next_hunk, { desc = "Next Hunk", noremap = true, silent = true })
u.map("n", "[h", gitsigns.prev_hunk, { desc = "Previous Hunk", noremap = true, silent = true })

-- Hunk options
u.map("n", "<leader>ghs", gitsigns.stage_hunk, { desc = "Stage hunk", noremap = true, silent = true })
u.map("n", "<leader>ghS", gitsigns.stage_buffer, { desc = "Stage Buffer", noremap = true, silent = true })
u.map("n", "<leader>ghr", gitsigns.reset_hunk, { desc = "Reset hunk", noremap = true, silent = true })
u.map("n", "<leader>ghR", gitsigns.reset_buffer, { desc = "Reset Buffer", noremap = true, silent = true })
u.map("n", "<leader>ghu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk", noremap = true, silent = true })
u.map("n", "<leader>ghp", gitsigns.preview_hunk, { desc = "Preview Hunk", noremap = true, silent = true })
u.map("n", "<leader>ghb", function() gitsigns.blame_line({ full = true }) end,
  { desc = "Blame line", noremap = true, silent = true })
u.map("n", "<leader>ght", gitsigns.toggle_current_line_blame,
  { desc = "Toggle current line blame", noremap = true, silent = true })
u.map("n", "<leader>ghd", gitsigns.diffthis, { desc = "Diff this", noremap = true, silent = true })
u.map("n", "<leader>ghD", function()
  gitsigns.diffthis("~")
end, { desc = "Diff this against the last commit", noremap = true, silent = true })

-- git mappings
u.map("n", "<leader>GG", ":Git<cr>", { desc = "Git Status", noremap = true, silent = true })
u.map("n", "<leader>GS", ":Git<cr>", { desc = "Git Status", noremap = true, silent = true })
u.map("n", "<leader>GA", ":Git add --all<cr>", { desc = "Git Add", noremap = true, silent = true })
u.map("n", "<leader>GC", ":Git commit --verbose --all<cr>", { desc = "Git Commit", noremap = true, silent = true })
u.map("n", "<leader>GF", ":Git fetch -p<cr>", { desc = "Git Fetch", noremap = true, silent = true })
u.map("n", "<leader>GL", ":Git log<cr>", { desc = "Git Log", noremap = true, silent = true })
u.map("n", "<leader>GPL", ":Git pull<cr>", { desc = "Git Pull", noremap = true, silent = true })
u.map("n", "<leader>GPP", ":Git push<cr>", { desc = "Git Push", noremap = true, silent = true })
u.map("n", "<leader>GB", require("telescope.builtin").git_branches,
  { desc = "Git Branches", noremap = true, silent = true })

-- git: add
u.map("n", "<leader>gA", ":Git add --all<cr>", { desc = "Git Add (all)", noremap = true, silent = true })
u.map("n", "<leader>gaa", ":Git add --all<cr>", { desc = "Git Add (all)", noremap = true, silent = true })
u.map("n", "<leader>gaf", ":Git add :%<cr>", { desc = "Git Add File", noremap = true, silent = true })

-- git: commit
u.map("n", "<leader>gC", ":Git commit --verbose --all<cr>", { desc = "Git Commit All", noremap = true, silent = true })
u.map("n", "<leader>gcc", ":Git commit --verbose<cr>", { desc = "Git Commit", noremap = true, silent = true })
u.map("n", "<leader>gcA", ":Git commit --verbose --amend<cr>",
  { desc = "Git Commit (amend)", noremap = true, silent = true })
u.map("n", "<leader>gca", ":Git commit --verbose --all<cr>", { desc = "Git Commit (all)", noremap = true, silent = true })
u.map("n", "<leader>gl", ":Gclog!<cr>", { desc = "Git Log", noremap = true, silent = true })

-- git: push pull
u.map("n", "<leader>gpa", ":Git push --all<cr>", { desc = "Git Push (all)", noremap = true, silent = true })
u.map("n", "<leader>gpp", ":Git push<cr>", { desc = "Git Push", noremap = true, silent = true })
u.map("n", "<leader>gpl", ":Git pull<cr>", { desc = "Git Pull", noremap = true, silent = true })

-- git: branches
local create_new_branch = function()
  local input = vim.fn.input('Enter branch name: ')
  input = input:gsub("%s+", "-")
  input = string.gsub(input, "%s+", "-")
  vim.cmd(":Git checkout -b " .. input)
end
u.map("n", "<leader>gB", require("telescope.builtin").git_branches,
  { desc = "Git Branches", noremap = true, silent = true })
u.map("n", "<leader>gbb", require("telescope.builtin").git_branches,
  { desc = "Git Branches", noremap = true, silent = true })
u.map("n", "<leader>gbn", create_new_branch,
  { desc = "Git new Branch", noremap = true, silent = true })

-- Github in browser
u.map("n", "<leader>go", ":GBrowse<cr>",
  { desc = "open in browser", noremap = true, silent = true })
u.map("n", "<leader>gpr", ":!gh pr create --fill<cr>",
  { desc = "open pull request", noremap = true, silent = true })

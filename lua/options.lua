-- ==============================================================================================
-- SETTINGS
-- ==============================================================================================

-- Set colorscheme
vim.o.termguicolors = true
-- Set highlight on search
vim.o.hlsearch = false
-- Make line numbers default
vim.wo.number = true
-- Minimal number of screen lines to keep above and below the cursor
vim.o.scrolloff = 3
-- The minimal number of columns to scroll horizontally
vim.o.sidescrolloff = 5
-- Enable mouse mode
vim.o.mouse = 'a'
-- Enable break indent
vim.o.breakindent = true
-- Save undo history
vim.o.undofile = true
-- Use the 'history' option to set the number of lines from command mode that are remembered.
vim.o.history = 500
-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
-- Decrease update time
vim.o.updatetime = 250
-- time to wait for a mapped sequence to complete (in milliseconds)
vim.o.timeoutlen = 1000
vim.wo.signcolumn = 'yes'
-- allows neovim to access the system clipboard
vim.o.clipboard = "unnamedplus"
-- allow hidden buffers
vim.o.hidden = true
-- Show signs in number column (e.g. errors and warnings)
vim.o.signcolumn = "yes"
-- Show tabs, spaces and line ends
vim.o.list = false
-- new window below on horizontal split
vim.o.splitbelow = true
-- new window to the right on vertical split
vim.o.splitright = true
-- set the completion methods
vim.o.completeopt = "menuone,noselect"
-- set on what to fold
vim.o.foldmethod = "expr"
-- do not fold on buffer opening
vim.o.foldenable = false
-- setting session options
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
-- Time in milliseconds to wait for a key code sequence to complete
vim.o.ttimeoutlen = 0
-- the encoding written to a file
vim.o.fileencoding = "utf-8"
-- When set case is ignored when completing file names and directories
vim.o.wildignorecase = true
vim.o.wildignore = [[
.git,.hg,.svn
*.aux,*.out,*.toc
*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
*.mp3,*.oga,*.ogg,*.wav,*.flac
*.eot,*.otf,*.ttf,*.woff
*.doc,*.pdf,*.cbr,*.cbz
*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
*.swp,.lock,.DS_Store,._*
*/tmp/*,*.so,*.swp,*.zip,**/node_modules/**,**/target/**,**.terraform/**"
]]

-- set default auto-indent width
vim.o.shiftwidth = 2
-- expand tabs to spaces per default
vim.o.expandtab = true
-- set default tabstop width
vim.o.tabstop = 2
-- set default virtual tabstop width
vim.o.softtabstop = 2

-- set english language
vim.api.nvim_exec("language en_US", true)

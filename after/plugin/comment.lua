-- ==============================================================================================
-- PLUGIN: COMMENT
-- ==============================================================================================
local u = require('utils')
local ok, comment = pcall(require, "Comment")
if not ok then
	u.warn("failed to configure plugin: comment")
	return
end

comment.setup({})

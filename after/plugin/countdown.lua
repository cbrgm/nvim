-- ==============================================================================================
-- PLUGIN: COUNTDOWN
-- ==============================================================================================
local u = require('utils')

local ok, countdown = pcall(require, "countdown")
if not ok then return end

require("countdown").setup({
	default_minutes = 25, -- The default minutes to use
})

u.map('n', '<leader>ttn', function()
	countdown.start_countdown(25)
end, { desc = "Start Pomodoro session" })

u.map('n', '<leader>ttb', function()
	countdown.start_countdown(5)
end, { desc = "Start Pomodoro break" })

u.map('n', '<leader>tts', function()
	countdown.stop_countdown()
end, { desc = "Stop Countdown" })

u.map('n', '<leader>ttr', function()
	countdown.resume_countdown()
end, { desc = "Resume Countdown" })

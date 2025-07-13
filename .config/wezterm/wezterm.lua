local wezterm = require 'wezterm'
local config = {}

config.keys = {}

-- Add Alt+1 through Alt+9 for tab jumping
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'ALT',
    action = wezterm.action.ActivateTab(i - 1),
  })
end

return config

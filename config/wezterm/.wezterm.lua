local wezterm = require 'wezterm'
local act = wezterm.action

return {
  hide_tab_bar_if_only_one_tab = true,
  font = wezterm.font 'Azeret Mono',
  font_size = 15,
  initial_cols = 100,
  initial_rows = 40,
  line_height = 1.2,
  check_for_updates = false,
  show_update_window = false,
  color_scheme = "Argonaut",
  keys = {
    { key = 'n', mods = 'SHIFT|CTRL', action = wezterm.action.SpawnWindow },
    -- This will create a new split and run your default program inside it
    {
      key = 'RightArrow',
      mods = 'CMD|SHIFT',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'UpArrow',
      mods = 'CMD|SHIFT',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'LeftArrow',
      mods = 'CMD',
      action = act.ActivatePaneDirection 'Left',
    },
    {
      key = 'RightArrow',
      mods = 'CMD',
      action = act.ActivatePaneDirection 'Right',
    },
    {
      key = 'UpArrow',
      mods = 'CMD',
      action = act.ActivatePaneDirection 'Up',
    },
    {
      key = 'DownArrow',
      mods = 'CMD',
      action = act.ActivatePaneDirection 'Down',
    },
  },
}

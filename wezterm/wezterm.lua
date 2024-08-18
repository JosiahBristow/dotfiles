local wezterm = require 'wezterm'
local c = {}
if wezterm.config_builder then
  c = wezterm.config_builder()
end

-- c.use_fancy_tab_bar = false

c.initial_cols = 70
c.initial_rows = 20

c.adjust_window_size_when_changing_font_size = false

c.window_close_confirmation = 'NeverPrompt'

c.font = wezterm.font("DejaVuSansM Nerd Font Mono", { weight = "Regular" })
c.font_size = 18
c.text_background_opacity = 0.9

local materia = wezterm.color.get_builtin_schemes()['Catppuccin Mocha']
materia.scrollbar_thumb = '#cccccc'
c.colors = materia

c.macos_window_background_blur  = 70
c.window_background_opacity = 0.9
-- c.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
c.window_padding = { left = 0, right = 15, top = 0, bottom = 0 }
c.enable_scroll_bar = true

c.disable_default_key_bindings = true
local act = wezterm.action
c.keys = {
  { key = 'Tab', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(1) },
  { key = 'F11', mods = 'NONE', action = act.ToggleFullScreen },
  { key = '+', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
  { key = '_', mods = 'SHIFT|CTRL', action = act.DecreaseFontSize },
  { key = 'C', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
  { key = 'N', mods = 'SHIFT|CTRL', action = act.SpawnWindow },
  { key = 'T', mods = 'SHIFT|CTRL', action = act.ShowLauncher },
  { key = 'Enter', mods = 'SHIFT|CTRL', action = act.ShowLauncherArgs { flags = 'FUZZY|TABS|LAUNCH_MENU_ITEMS' } },
  { key = 'V', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
  { key = 'W', mods = 'SHIFT|CTRL', action = act.CloseCurrentTab{ confirm = false } },
  { key = 'PageUp', mods = 'SHIFT|CTRL', action = act.ScrollByPage(-1) },
  { key = 'PageDown', mods = 'SHIFT|CTRL', action = act.ScrollByPage(1) },
  { key = 'UpArrow', mods = 'SHIFT|CTRL', action = act.ScrollByLine(-1) },
  { key = 'DownArrow', mods = 'SHIFT|CTRL', action = act.ScrollByLine(1) },
}

return c

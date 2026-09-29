local M = {}
local colorschemes = require("config.core.colorschemes")
local koda = require("config.core.koda")

local appearance_file = vim.fn.stdpath("config") .. "/lua/config/core/appearance.lua"
local transparency_groups = {
  "Normal",
  "NormalNC",
  "SignColumn",
  "EndOfBuffer",
  "FoldColumn",
  "LineNr",
  "CursorLineNr",
  "CursorLineFold",
  "CursorLineSign",
  "NormalFloat",
  "FloatBorder",
  "FloatTitle",
  "WinSeparator",
  "VertSplit",
  "StatusLine",
  "StatusLineNC",
  "TabLine",
  "TabLineFill",
  "TabLineSel",
  "Pmenu",
  "PmenuSbar",
  "PmenuThumb",
  "NvimTreeNormal",
  "NvimTreeNormalNC",
  "NeoTreeNormal",
  "NeoTreeNormalNC",
  "TelescopeNormal",
  "TelescopeBorder",
  "WhichKeyFloat",
  "LazyNormal",
  "MasonNormal",
  "BufferLineFill",
  "BufferLineBackground",
  "BufferLineBufferVisible",
  "BufferLineBufferSelected",
  "BufferLineDuplicate",
  "BufferLineDuplicateVisible",
  "BufferLineDuplicateSelected",
  "BufferLineModified",
  "BufferLineModifiedVisible",
  "BufferLineModifiedSelected",
  "BufferLineSeparator",
  "BufferLineSeparatorVisible",
  "BufferLineSeparatorSelected",
  "BufferLineIndicatorSelected",
}

local config = {
  themes = colorschemes.names(),
  default = "koda",
  state_file = vim.fn.stdpath("state") .. "/theme.txt",
}

local function index_of(name)
  for i, theme in ipairs(config.themes) do
    if theme == name then
      return i
    end
  end

  return nil
end

local function persist(name)
  local dir = vim.fn.fnamemodify(config.state_file, ":h")
  vim.fn.mkdir(dir, "p")
  vim.fn.writefile({ name }, config.state_file)
end

local function read_persisted()
  if vim.fn.filereadable(config.state_file) == 0 then
    return nil
  end

  local lines = vim.fn.readfile(config.state_file)
  return lines[1]
end

local function load_appearance()
  local ok, appearance = pcall(dofile, appearance_file)
  if not ok then
    vim.notify(("Failed to load appearance config: %s"):format(appearance), vim.log.levels.WARN)
    return { transparent = false }
  end

  if type(appearance) ~= "table" then
    return { transparent = false }
  end

  return vim.tbl_deep_extend("force", {
    transparent = false,
  }, appearance)
end

local function set_highlight_bg(name, bg)
  local ok, value = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
  if not ok then
    return
  end

  value = value or {}
  value.bg = bg
  vim.api.nvim_set_hl(0, name, value)
end

local function apply_appearance()
  local appearance = load_appearance()
  if not appearance.transparent then
    return
  end

  for _, group in ipairs(transparency_groups) do
    set_highlight_bg(group, "NONE")
  end
end

local function apply(name, opts)
  opts = opts or {}

  if not index_of(name) then
    vim.notify(("Unknown theme: %s"):format(name), vim.log.levels.ERROR)
    return false
  end

  koda.setup(name)

  local ok, err = pcall(vim.cmd.colorscheme, name)
  if not ok then
    vim.notify(("Failed to load theme %s: %s"):format(name, err), vim.log.levels.ERROR)
    return false
  end

  vim.schedule(apply_appearance)

  if opts.persist ~= false then
    persist(name)
  end

  if opts.notify then
    vim.notify(("Theme: %s"):format(name), vim.log.levels.INFO)
  end

  return true
end

function M.names()
  return vim.deepcopy(config.themes)
end

function M.current()
  return vim.g.colors_name
end

function M.set(name, opts)
  return apply(name, opts)
end

function M.reload(opts)
  opts = opts or {}
  return apply(M.current() or config.default, {
    persist = false,
    notify = opts.notify,
  })
end

function M.cycle(step)
  step = step or 1

  local current = M.current()
  local current_index = index_of(current) or index_of(config.default) or 1
  local next_index = ((current_index - 1 + step) % #config.themes) + 1

  return apply(config.themes[next_index], { notify = true })
end

function M.select()
  vim.ui.select(config.themes, {
    prompt = "Select theme",
    format_item = function(item)
      if item == M.current() then
        return item .. " (current)"
      end

      return item
    end,
  }, function(choice)
    if choice then
      apply(choice, { notify = true })
    end
  end)
end

function M.load()
  local name = read_persisted() or config.default

  if apply(name, { persist = false }) then
    return
  end

  if name ~= config.default then
    apply(config.default)
  end
end

function M.setup(opts)
  config = vim.tbl_deep_extend("force", config, opts or {})

  vim.api.nvim_create_user_command("Theme", function(command_opts)
    if command_opts.args == "" then
      M.select()
      return
    end

    M.set(command_opts.args, { notify = true })
  end, {
    nargs = "?",
    complete = function(arg_lead)
      return vim.tbl_filter(function(theme)
        return theme:find(arg_lead, 1, true) == 1
      end, config.themes)
    end,
    desc = "Select or set the active theme",
  })

  vim.api.nvim_create_user_command("ThemeNext", function()
    M.cycle(1)
  end, { desc = "Cycle to the next theme" })

  vim.api.nvim_create_user_command("ThemePrev", function()
    M.cycle(-1)
  end, { desc = "Cycle to the previous theme" })

  vim.api.nvim_create_user_command("ThemeReload", function()
    M.reload({ notify = true })
  end, { desc = "Reload the active theme and appearance settings" })

  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("SalarThemeAppearance", { clear = true }),
    callback = function()
      vim.schedule(apply_appearance)
    end,
  })

  vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("SalarAppearanceReload", { clear = true }),
    pattern = appearance_file,
    callback = function()
      M.reload()
      vim.notify("Appearance reloaded", vim.log.levels.INFO)
    end,
  })

  M.load()
end

return M

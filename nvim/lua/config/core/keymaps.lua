vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "<C-d>", "<C-d>zz")

vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("Wq", "wq", {})

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase height" })
keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease height" })
keymap.set("n", "<C-Left>", ":vertical resize -4<CR>", { desc = "Narrower" })
keymap.set("n", "<C-Right>", ":vertical resize +4<CR>", { desc = "Wider" })

-- tab management (MOST IMPORTANT)
keymap.set("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close current buffer/tab" })
keymap.set("n", "<leader>X", "<cmd>bwipeout<CR>", { desc = "Close buffer (force, no swap)" })

-- buffer navigation
keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Go to next buffer" })
keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Go to previous buffer" })
keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseLeft<CR>", { desc = "Close all buffers to the left" })
keymap.set("n", "<leader>br", "<cmd>BufferLineCloseRight<CR>", { desc = "Close all buffers to the right" })
keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close all other buffers" })

-- buffer creation
keymap.set("n", "<leader>n", "<md>enew<CR>", { desc = "New buffer" })
keymap.set("n", "<leader>N", "<cmd>tabnew<CR>", { desc = "New tab" })
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- file explorer
local function close_oil()
  local alt_buf = vim.fn.bufnr("#")
  if alt_buf > 0 and vim.api.nvim_buf_is_valid(alt_buf) then
    vim.cmd("buffer #")
  else
    vim.cmd("enew")
  end
end

keymap.set("n", "<C-n>", function()
  if vim.bo.filetype == "oil" then
    close_oil()
    return
  end

  require("oil").open()
end, { desc = "Toggle file explorer" })

keymap.set("n", "<leader>e", function()
  require("oil").open()
end, { desc = "Open file explorer" })

vim.keymap.set("n", "<leader>ci", "<cmd>Telescope lsp_incoming_calls<CR>")
vim.keymap.set("n", "<leader>co", "<cmd>Telescope lsp_outgoing_calls<CR>")
vim.keymap.set("n", "<leader>ch", "<cmd>Telescope lsp_implementations<CR>")
vim.keymap.set("n", "<leader>cu", "<cmd>Telescope lsp_references<CR>")

keymap.set("n", "<leader>ts", "<cmd>Theme<CR>", { desc = "Select theme" })
keymap.set("n", "<leader>tn", "<cmd>ThemeNext<CR>", { desc = "Next theme" })
keymap.set("n", "<leader>tp", "<cmd>ThemePrev<CR>", { desc = "Previous theme" })

-- terminal related
keymap.set("t", "<Esc>", [[<C-\><C-n>]])

vim.api.nvim_create_user_command("Ru", function()
  local lines = {
    "// =========== [rufus] ===========",
    "",
    "// ===============================",
  }
  vim.api.nvim_put(lines, "l", true, true)
end, {})

vim.api.nvim_create_user_command("Cb", function()
  local lines = {
    "```",
    "",
    "```",
  }
  vim.api.nvim_put(lines, "l", true, true)

  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  -- -2 to get in the top row
  local target_row = row - 2
  -- 3 to get to the end of first line
  vim.api.nvim_win_set_cursor(0, { target_row, 3 })
end, {})

vim.cmd("cabbrev ru Ru")
vim.cmd("cabbrev cb Cb")

-- ANSI Log Prefixes (Insert Mode Abbreviations)
vim.cmd([[
  iabbrev _info \033[34m[INFO]\033[0m
  iabbrev _warn \033[33m[WARNING]\033[0m
  iabbrev _err \033[1;31m[ERROR]\033[0m
  iabbrev _ok \033[1;32m[SUCCESS]\033[0m
  iabbrev _debug \033[90m[DEBUG]\033[0m
]])

return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_quickfix_open_on_warning = 0
    vim.g.vimtex_quickfix_mode = 2
    vim.g.vimtex_view_skim_reading_bar = 0

    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk = {
      build_dir = "build",
      executable = "/Library/TeX/texbin/latexmk",
      continuous = 1,
      options = {
        "-lualatex",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
      },
    }

    vim.g.vimtex_view_method = "skim"
    vim.g.vimtex_view_skim_sync = 1
    vim.g.vimtex_view_skim_activate = 0
  end,
  config = function()
    local keymap = vim.keymap
    keymap.set("n", "<leader>ll", "<cmd>VimtexCompile<CR>", { desc = "Toggle LaTeX Live Compile" })
    keymap.set("n", "<leader>lv", "<cmd>VimtexView<CR>", { desc = "View PDF in Skim" })
    keymap.set("n", "<leader>lc", "<cmd>VimtexClean<CR>", { desc = "Clean aux files" })
    keymap.set("n", "<leader>lk", "<cmd>VimtexStop<CR>", { desc = "Stop Compiler" })
  end,
}

return {
  -- Dein bestehendes copilot.lua
  {
    "zbirenbaum/copilot.lua",
    lazy = false,
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<leader>p",
          },
        },
      })
    end,
  },

  -- plugin for inline edits and prompts
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      window = {
        layout = "float",
        width = 0.5,
        height = 0.4,
        border = "rounded",
      },
    },
    keys = {
      -- opens prompt window for current buffer / selection
      {
        "<leader>ce",
        function()
          local input = vim.fn.input("Copilot Prompt: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        mode = { "n", "v" },
        desc = "Copilot Quick Prompt",
      },
      -- opens chat window
      {
        "<leader>cc",
        "<cmd>CopilotChatToggle<cr>",
        mode = { "n", "v" },
        desc = "Copilot Chat Toggle",
      },
    },
  },
}

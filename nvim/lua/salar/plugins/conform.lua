return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        -- C/C++
        c = { "clang-format" },
        cs = { "csharpier" },
        cpp = { "clang-format" },
        objc = { "clang-format" },
        objcpp = { "clang-format" },

        -- JavaScript/TypeScript
        javascript = { "prettier" },
        typescript = { "prettier" },
        jsx = { "prettier" },
        tsx = { "prettier" },

        -- CSS/HTML
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },

        -- JSON
        json = { "prettier" },

        -- Markdown
        markdown = { "prettier" },

        -- YAML
        yaml = { "prettier" },

        -- Lua
        lua = { "stylua" },

        -- Rust
        rust = { "rustfmt" },

        -- Java
        java = { "google-java-format" },

        -- Python
        python = { "black", "isort" },

        -- Go
        go = { "gofmt", "goimports" },

        -- Shell
        sh = { "shfmt" },
      },

      formatters = {
        clang_format = {
          prepend_args = { "--style=file" },
        },
        prettier = {
          prepend_args = { "--tab-width=2" },
        },
        stylua = {
          prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        },
        rustfmt = {
          prepend_args = { "--edition=2021" },
        },
        black = {
          prepend_args = { "--line-length=120" },
        },
        shfmt = {
          prepend_args = { "-i", "2" },
        },
      },

      -- Auto-format on save
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },

      -- Logging
      log_level = vim.log.levels.ERROR,
      notify_on_error = true,
    })

    -- Optional: Command for manual formatting
    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.count - 1, args.count, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.count, string.len(end_line) },
        }
      end
      require("conform").format({ async = true, lsp_fallback = true, range = range })
    end, { range = true })
  end,
}

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")

		local function hl(name)
			local ok, value = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
			return ok and value or {}
		end

		local function to_hex(color)
			if type(color) ~= "number" then
				return color
			end

			return string.format("#%06x", color)
		end

		local function make_theme()
			local statusline = hl("StatusLine")
			local normal = hl("Normal")
			local fg = to_hex(statusline.fg or normal.fg)

			local function section()
				return { fg = fg, bg = "NONE" }
			end

			return {
				normal = { a = section(), b = section(), c = section() },
				insert = { a = section(), b = section(), c = section() },
				visual = { a = section(), b = section(), c = section() },
				replace = { a = section(), b = section(), c = section() },
				command = { a = section(), b = section(), c = section() },
				inactive = { a = section(), b = section(), c = section() },
			}
		end

		local function format_bytes(bytes)
			local units = { "B", "KB", "MB", "GB" }
			local value = math.max(bytes, 0)
			local unit = 1

			while value >= 1024 and unit < #units do
				value = value / 1024
				unit = unit + 1
			end

			if unit == 1 then
				return string.format("%d%s", value, units[unit])
			end

			if value >= 10 then
				return string.format("%.0f%s", value, units[unit])
			end

			return string.format("%.1f%s", value, units[unit])
		end

		local function quoted_filename()
			local name = vim.fn.expand("%:t")
			if name == "" then
				name = "[No Name]"
			end

			return string.format('"%s"', name)
		end

		local function update_write_info(bufnr)
			if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].buftype ~= "" then
				return
			end

			local name = vim.api.nvim_buf_get_name(bufnr)
			local bytes = name ~= "" and vim.fn.getfsize(name) or 0
			local lines = vim.api.nvim_buf_line_count(bufnr)

			vim.b[bufnr].lualine_write_info = string.format("%dL, %s written", lines, format_bytes(bytes))
		end

		local function setup_lualine()
			lualine.setup({
				options = {
					theme = make_theme(),
					icons_enabled = false,
					component_separators = "",
					section_separators = "",
				},
				sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {
						{
							quoted_filename,
							padding = { left = 1, right = 1 },
						},
						{
							function()
								return vim.b.lualine_write_info or ""
							end,
							cond = function()
								return not vim.bo.modified and vim.b.lualine_write_info ~= nil
							end,
							padding = { left = 0, right = 1 },
						},
					},
					lualine_x = {},
					lualine_y = {
						{
							"filetype",
							padding = { left = 1, right = 1 },
						},
					},
					lualine_z = {
						{
							function()
								return string.format("%d, %d", vim.fn.line("."), vim.fn.col("."))
							end,
							padding = { left = 1, right = 1 },
						},
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {
						{
							quoted_filename,
							padding = { left = 1, right = 1 },
						},
					},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
			})
		end

		setup_lualine()

		local refresh_group = vim.api.nvim_create_augroup("SalarLualineMinimal", { clear = true })

		vim.api.nvim_create_autocmd("ColorScheme", {
			group = refresh_group,
			callback = function()
				setup_lualine()
				lualine.refresh()
			end,
		})

		vim.api.nvim_create_autocmd("BufWritePost", {
			group = refresh_group,
			callback = function(args)
				update_write_info(args.buf)
				lualine.refresh()
			end,
		})

		vim.api.nvim_create_autocmd("BufModifiedSet", {
			group = refresh_group,
			callback = function(args)
				if vim.bo[args.buf].modified then
					vim.b[args.buf].lualine_write_info = nil
					lualine.refresh()
				end
			end,
		})
	end,
}

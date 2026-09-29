local M = {}

M.items = {
	{
		repo = "oskarnurm/koda.nvim",
		schemes = { "koda", "koda-dark", "koda-light", "koda-glade", "koda-moss" },
	},
}

function M.names()
	local names = {}

	for _, item in ipairs(M.items) do
		vim.list_extend(names, item.schemes)
	end

	return names
end

return M

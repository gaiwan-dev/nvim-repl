local default_config = require("nvim-repl.config")

local M = {}

function M._open_repl_window(cmd)
	local position = M.config.window.position

	if position == "left" then
		vim.cmd("topleft vsplit")
	elseif position == "right" then
		vim.cmd("botright vsplit")
	elseif position == "top" then
		vim.cmd("topleft split")
	elseif position == "bottom" then
		vim.cmd("botright split")
	else
		vim.cmd("vsplit")
	end

	vim.cmd("enew")
	local buff = vim.api.nvim_get_current_buf()
	vim.fn.termopen({ cmd }, {
		on_exit = function(_, code)
			if code == 0 then
				vim.api.nvim_buf_delete(buff, { force = true })
			end
		end,
	})

	vim.cmd("startinsert")
end

---return the command to open the REPL for the language used on the LSP attached
---to the file currently opened.
function M._get_cmd_by_lsp(buff)
	local lsps = vim.lsp.get_clients({ bufnr = buff })
	local lsp_configured = M.config.lsp

	for _, lsp in ipairs(lsps) do
		local name = lsp.name
		local helper_cmd = lsp_configured[name]

		if helper_cmd then
			return helper_cmd
		end
	end
	print("Failed to find a REPL for the language you are using. Add it to the config.")
	return nil
end

---merge the default config with the user config and set it in M
---@param custom_config table
function M.setup(custom_config)
	M.config = vim.tbl_extend("force", default_config.config, custom_config or {})
end

function M.execute()
	local buff = vim.api.nvim_get_current_buf()
	local cmd = M._get_cmd_by_lsp(buff)
	if cmd ~= nil then
		M._open_repl_window(cmd)
		print(cmd)
	end
end

return M

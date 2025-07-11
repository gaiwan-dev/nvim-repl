local default_config = require("nvim-repl.config")

local M = {}

function M._open_repl_window(cmd)
	local buffnr = vim.api.nvim_create_buf(true, true)

	-- local win_id = vim.api.nvim_open_win(buffnr, true, {
	-- 	split = M.config.window.position,
	-- 	win = 0,
	-- 	style = "minimal",
	-- })
	-- if win_id == 0 then
	-- 	error("Failed to open REPL window")
	-- end

	vim.api.nvim_open_term(buffnr, {})
end

---return the command to open the REPL for the language used on the LSP attached
---@return string?
function M._get_cmd_by_lsp()
	local lsps = vim.lsp.get_clients()
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
	local cmd = M._get_cmd_by_lsp()
	if cmd ~= nil then
		M._open_repl_window(cmd)
	end
end

return M

local repl = require("nvim-repl")

vim.api.nvim_create_user_command("RunRepl", function()
	repl.execute()
end, {})

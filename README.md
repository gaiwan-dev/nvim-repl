# nvim-repl

A lightweight Neovim plugin that opens a REPL (Read-Eval-Print Loop) for the currently attached LSP. 
Why not using the plugins already available? Because this plugin is 66 lines of code with 30 that I already had for another plugin. It was easier to add the other 36 lines, rather than find and install a new plugin.

## Features

- Automatically detects the LSP client attached to the current buffer.
- Opens a REPL (e.g., `python3`, `lua`, `node`) based on the LSP name.
- Configuration: 
    - Configurable REPL commands per LSP.
    - Customizable split window position (top, bottom, left, right).

## Setup

Use your plugin manager to install and configure:

```lua
return {
  "gaiwan-dev/nvim-repl",
  branch = "master",

  config = function()
    local repl = require("nvim-repl")
    repl.setup({
      lsp = {
        ruff = "python3",
        pyright = "python3",
        lua_ls = "lua",
        ts_ls = "node",
      },
      window = {
        position = "bottom", 
      },
    })
  end,
}
```
The allowed values of `position` are: `bottom`, `up`, `left`, `right`. Defaults to `left`.
The `RunRepl` command is exposed for shortcut configuration:
```lua
vim.keymap.set("n", "<leader>rr", "<cmd>RunRepl<CR>", { desc = "[R]un [R]epl" })
```




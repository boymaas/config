-- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)

local dap = require 'dap'

dap.adapters.lldb = {
  type = "executable",
  command = "rust-lldb", -- adjust as needed
  name = "lldb",
}

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = '/home/bmaas/codelldb/extension/adapter/codelldb',
    args = { "--port", "${port}" },

    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}

-- NOTE: can reuse the codelldb configuration for other languages
dap.configurations.rust = {
  {
    name = "Launch file",
    type = "codelldb", -- matches the adapter
    request = "launch", -- could also attach to a currently running process
    program = function()
      return vim.fn.input(
        "Path to executable: ",
        vim.fn.getcwd() .. "/",
        "file"
      )
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = true,
    runInTerminal = false,
  }
}

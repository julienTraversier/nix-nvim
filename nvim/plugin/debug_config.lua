 local dap = require 'dap'
 local dapui = require 'dapui'
 -- Basic debugging keymaps, feel free to change to your liking!
 vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
 vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
 vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
 vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
 vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
 vim.keymap.set('n', '<leader>B', function()
   dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
 end, { desc = 'Debug: Set Breakpoint' })
 vim.keymap.set("n", "<leader>de", dapui.eval, { desc = "Debug: eval expression 2 time to step into it" })
 vim.keymap.set("n", "<leader>df", dapui.float_element, { desc = "Debug: pop up floating element" })
 vim.keymap.set("n", "<leader>dt", dapui.toggle, { desc = "Debug: pop up floating element" })

 function checkDebugPyInstallation()
    os.execute("pythonCheckDap")
 end
 -- Dap UI setup
 -- For more information, see |:help nvim-dap-ui|
 dapui.setup {
   -- Set icons to characters that are more likely to work in every terminal.
   --    Feel free to remove or use ones that you like more! :)
   --    Don't feel like these are good choices.
   icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
   controls = {
     icons = {
       pause = '⏸',
       play = '▶',
       step_into = '⏎',
       step_over = '⏭',
       step_out = '⏮',
       step_back = 'b',
       run_last = '▶▶',
       terminate = '⏹',
       disconnect = '⏏',
     },
   },
 }

 -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
 vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

 dap.listeners.after.event_initialized['dapui_config'] = dapui.open
 dap.listeners.before.event_terminated['dapui_config'] = dapui.close
 dap.listeners.before.event_exited['dapui_config'] = dapui.close
checkDebugPyInstallation()
 require('dap-python').setup("~/.virtualenvs/debugpy/bin/python")
 dap.configurations.python = {
   {
     type = "python",
     request = "launch",
     name = "launch file",
     cwd = "${workspaceFolder}",
     program = "${file}"
   }
 }


 --dap.adapters.cppdbg = {
 --  id = 'cppdbg',
 --  type = 'executable',
 --  command = '/home/jtraversier/Téléchargements/extension/debugAdapters/bin/OpenDebugAD7',
 --}
 dap.adapters.gdb = {
     type = 'executable',
     command = "gdb",
     args = {"-i", "dap"}
 }
 dap.configurations.c = {
   {
     name = "Launch file",
     type = "gdb",
     request = "launch",
     --program = function()
     --  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
     --end,
     -- program = "${workspaceFolder}/../build_x86/fiber-optic/Fiber_Optic",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
     cwd = '${workspaceFolder}',
     stopAtBeginningOfMainSubprogram = false,
   }
 }
 dap.configurations.cpp = {
   {
     name = "Launch file",
     type = "gdb",
     request = "launch",
     --program = function()
     --  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
     --end,
     -- program = "${workspaceFolder}/../build_x86/fiber-optic/Fiber_Optic",
    function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
     cwd = '${workspaceFolder}',
     stopAtBeginningOfMainSubprogram = false,
   }
 }
 --dap.configurations.rust = {
 --  {
 --  name = 'Launch',
 --  type = 'codelldb',
 --  request = 'launch',
 --  program = "${workspaceFolder}/target/debug/${file}",

 --  cwd = '${workspaceFolder}',
 --  stopOnEntry = false,
 --  args = {},
 --}
--}


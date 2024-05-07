
local on_attach = function(client,bufnr)
  require("lsp-inlayhints").on_attach(client, bufnr)
  vim.api.nvim_set_keymap('n','K',":RustLsp hover actions<CR>" , {noremap = true, silent = true, desc="Hover Documentation"})
  vim.api.nvim_set_keymap('n','<leader>ca',":RustLsp codeAction<CR>" ,                {noremap = true,silent = true, desc = 'Code actions'})
  vim.api.nvim_set_keymap('n','<leader>ch',":Lspsaga incoming_calls<CR>" ,            {noremap = true,silent = true, desc = '[C]all [H]ierarchy'})
  vim.api.nvim_set_keymap('n','<leader>fu',":Lspsaga finder<CR>" ,                    {noremap = true,silent = true, desc = '[F]ind [U]sage'})
  vim.api.nvim_set_keymap('n','<leader>pd',":Lspsaga peek_definition<CR>" ,           {noremap = true,silent = true, desc = '[P]eek [D]efinition'})
  vim.api.nvim_set_keymap('n','<leader>oo',":Lspsaga outline<CR>" ,                   {noremap = true,silent = true, desc = '[O]pen [O]utline'})
  --vim.api.nvim_set_keymap('n','<leader>rn',vim.lsp.buf.rename ,                       {noremap = true,silent = true, desc = '[R]e[n]ame'})
  vim.api.nvim_set_keymap('n','gd',":lua require('telescope.builtin').lsp_definitions()<CR>" ,     {noremap = true,silent = true, desc = '[G]oto [D]efinition'})
  vim.api.nvim_set_keymap('n','gr',":lua require('telescope.builtin').lsp_references()<CR>" ,      {noremap = true,silent = true, desc = '[G]oto [R]eferences'})
  vim.api.nvim_set_keymap('n','gD',":lua require('telescope.builtin').lsp_type_definitions()<CR>" ,{noremap = true,silent = true, desc = '[D]ocument [S]ymbols'})
  vim.api.nvim_set_keymap('n','<F5>',":RustLsp debuggables<CR>" ,{noremap = true,silent = true, desc = 'launch debug'})
end


local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'
local cfg = require('rustaceanvim.config')
vim.g.rustaceanvim = {
  server = {
    on_attach = on_attach
  },
  dap = {
      adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
  }
}


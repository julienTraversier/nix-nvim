---@class lsp.ClientCapabilities
local local_cap = vim.lsp.protocol.make_client_capabilities()
local util = require 'lspconfig.util'
local_cap.offsetEncoding = { "utf-16" }


local root_files = {
	'.clangd',
	'.clang-tidy',
	'.clang-format',
	'compile_commands.json',
	'compile_flags.txt',
	'build.sh', -- buildProject
	'configure.ac', -- AutoTools
	'run',
	'compile',
}

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
--  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  vim.keymap.set('n','<leader>ca',":Lspsaga code_action<CR>" ,{buffer = bufnr, desc = '[C]ode [A]ction'})
  vim.keymap.set('n','<leader>ch',":Lspsaga incoming_calls<CR>" ,{buffer = bufnr, desc = '[C]all [H]ierarchy'})
  vim.keymap.set('n','<leader>fu',":Lspsaga finder<CR>" ,{buffer = bufnr, desc = '[F]ind [U]sage'})
  vim.keymap.set('n','<leader>pd',":Lspsaga peek_definition<CR>" ,{buffer = bufnr, desc = '[P]eek [D]efinition'})
  vim.keymap.set('n','<leader>oo',":Lspsaga outline<CR>" ,{buffer = bufnr, desc = '[O]pen [O]utline'})

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  --nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  vim.keymap.set('n','K',":Lspsaga hover_doc<CR>" ,{buffer = bufnr, desc = 'Hover Documentation'})
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
  require("lsp-inlayhints").on_attach(_, bufnr)
end

-- TODO: add clang-tidy to on_atach with clangd
return {
	cmd = { 
		"clangd",
		"--all-scopes-completion",
		"--background-index",
		"--clang-tidy",
		"--compile_args_from=filesystem", -- lsp-> does not come from compie_commands.json
		"--completion-parse=always",
		"--completion-style=bundled",
		"--debug-origin",
		"--enable-config", -- clangd 11+ supports reading from .clangd configuration file
		"--fallback-style=GNU",
		"--function-arg-placeholders",
		"--header-insertion=iwyu",
		"--pch-storage=memory", -- could also be disk
		--"-j=4",		-- number of workers
		-- "--resource-dir="
		"--log=error",
		"--query-driver=/opt/viavi/sdk/**"--ALE-23.3.aarch64/sysroots/x86_64-viavi-linux/usr/bin/aarch64-poky-linux/aarch64-poky-linux-g++"
	},
	filetypes = { "c", "cpp", "objc", "objcpp" },
	root_dir = function(fname)
			return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
		end,
	single_file_support = true,
	init_options = {
		compilationDatabasePath= vim.fn.getcwd() .. "/build",
	},
	capabilities = local_cap,
	commands = {

	},
	on_attach = on_attach,
}


local status_ok, barbar = pcall(require, "barbar")
if not status_ok then
  return
end

vim.g.barbar_auto_setup = false
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }


barbar.setup {
  -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
  animation = true,
  clickable = true,
  icons = {
    -- Configure the base icons on the bufferline.
    -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
    buffer_index = false,
    buffer_number = false,
    button = '',
    -- Enables / disables diagnostic symbols
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = { enabled = true, icon = 'ﬀ' },
      [vim.diagnostic.severity.WARN] = { enabled = false },
      [vim.diagnostic.severity.INFO] = { enabled = false },
      [vim.diagnostic.severity.HINT] = { enabled = true },
    },
    gitsigns = {
      added = { enabled = true, icon = '+' },
      changed = { enabled = true, icon = '~' },
      deleted = { enabled = true, icon = '-' },
    },
    filetype = {
      -- Sets the icon's highlight group.
      -- If false, will use nvim-web-devicons colors
      custom_colors = false,

      -- Requires `nvim-web-devicons` if `true`
      enabled = true,
    },
  }
}

map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-;>', '<Cmd>BufferNext<CR>', opts)
map('n', '<A-left>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-right>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-&>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-é>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-">', '<Cmd>BufferGoto 3<CR>', opts)
map('n', "<A-'>", '<Cmd>BufferGoto 4<CR>', opts)
map('n', "<A-(>", '<Cmd>BufferGoto 5<CR>', opts)
map('n', "<A-->", '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-è>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-_>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-ç>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-à>', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
-- Sort automatically by...
map('n', '<Space>cc', '<Cmd>BufferCloseAllButCurrent<CR>', opts)
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  formatting = {
    --format = function(entry, vim_item)
    --  vim_item.abbr = string.sub(vim_item.abbr, 1, 20)
    --  return vim_item
    --end
    --format = function(_, vim_item)
    --  vim_item.menu = ""
    --  vim_item.kind = ""
    --  return vim_item
    --end,
    format = require('lspkind').cmp_format({
      before = function(entry, vim_item)
        vim_item.abbr = string.sub(vim_item.abbr, 1, 50)
        vim_item.menu = ""
        --vim_item.kind = ""
        return vim_item
      end,
      mode = "symbol",
      maxwidth = 50,
      ellipsis_char = '...',
      symbol_map = { Codeium = "", }
    })
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<enter>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sorting = {
    priority_weight = 1.0,
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      require("cmp-under-comparator").under,
      cmp.config.compare.kind,
    },
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'codeium' }
  },
}

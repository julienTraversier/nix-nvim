local status_ok, nvimtree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

nvimtree.setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
    adaptive_size=true,
  },
  renderer = {
    group_empty = true,
    highlight_modified = "all",
  },
  filters = {
    dotfiles = false,
  },
  update_focused_file = {
    enable = true
  },
  actions = {
    open_file = {
      quit_on_open = true
    }
  }
})

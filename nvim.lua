local function my_nvim_tree_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)
  local list = {
    { key = "<CR>",                         cb = api.node.open.edit },
    { key = "v",                            cb = api.node.open.vertical },
    { key = "C",                            cb = api.tree.change_root_to_node },
    { key = "s",                            cb = api.node.open.horizontal },
    { key = "t",                            cb = api.node.open.tab },
    -- { key = "<",                            cb = tree_cb("prev_sibling") },
    -- { key = ">",                            cb = tree_cb("next_sibling") },
    -- { key = "<Tab>",                        cb = tree_cb("preview") },
    -- { key = "K",                            cb = tree_cb("first_sibling") },
    -- { key = "J",                            cb = tree_cb("last_sibling") },
    { key = "-",                            cb = api.tree.close },
    -- { key = "H",                            cb = tree_cb("toggle_ignored") },
    -- { key = "I",                            cb = tree_cb("toggle_dotfiles") },
    -- { key = "R",                            cb = tree_cb("refresh") },
    -- { key = "a",                            cb = tree_cb("create") },
    { key = "dd",                           cb = api.fs.remove },
    -- { key = "r",                            cb = tree_cb("rename") },
    -- { key = "<C-r>",                        cb = tree_cb("full_rename") },
    { key = "x",                            cb = api.node.navigate.parent_close },
    -- { key = "yy",                           cb = tree_cb("copy") },
    { key = "P",                            cb = api.fs.paste },
    -- { key = "<c-y>",                        cb = tree_cb("copy_name") },
    -- { key = "Y",                            cb = tree_cb("copy_path") },
    -- { key = "gy",                           cb = tree_cb("copy_absolute_path") },
    -- { key = "[c",                           cb = tree_cb("prev_git_item") },
    -- { key = "]c",                           cb = tree_cb("next_git_item") },
    -- { key = "<BC>",                         cb = tree_cb("dir_up") },
    -- { key = "<c-s>",                        cb = tree_cb("system_open") },
    { key = "q",                            cb = api.tree.close },
    { key = "?",                           cb = api.tree.toggle_help },
  }
  -- vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
  for _, config in ipairs(list) do
    vim.keymap.set('n', config.key, config.cb, opts('TODO'))
  end
end

local tree_loaded = false
vim.g.setup_nvim_tree = function()
  if tree_loaded then return end
  tree_loaded = true

  -- vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache' } -- empty by default
  -- vim.g.nvim_tree_gitignore = 1
  vim.g.nvim_tree_hide_dotfiles = 1
  vim.g.nvim_tree_icon_padding = ' '

  -- local tree_cb = require'nvim-tree.config'.nvim_tree_callback
  -- -- default mappings
  require'nvim-tree'.setup {
    view = {
      width = 35,
    },
    on_attach = my_nvim_tree_on_attach,
    update_focused_file = {
      enable      = true,
      update_cwd  = false,
    },
      renderer = {
        group_empty = true,
    },
    filters = {
      custom = { '.git', 'node_modules', '.cache' }
    },
    actions = {
      open_file = {
        window_picker = {
          enable = false,
        },
      },
    },
  }
end

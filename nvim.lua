require('lualine').setup {
  options = {theme = 'solarized_light'},
  sections = {
    lualine_c = {'buffers'},
  },
  tabline = {
    lualine_b = {
      {
        'tabs',
        mode = 1,
        max_length = vim.o.columns,
      },
    }
  },
  extensions = {'fzf', 'nvim-tree', 'fugitive'},
}
require('which-key').setup {
  plugins = {
    spelling = {
      enabled = true,
    },
  }
}
local fzf_loaded = false
vim.g.setup_fzf_lua = function()
  if fzf_loaded then return end
  fzf_loaded = true

  local actions = require "fzf-lua.actions"
  require'fzf-lua'.setup {
    winopts = {
      split         = "belowright new",-- open in a split instead?
    },
    keymap = {
      -- These override the default tables completely
      -- no need to set to `false` to disable a bind
      -- delete or modify is sufficient
      builtin = {
        -- neovim `:tmap` mappings for the fzf win
        ["<F2>"]        = "toggle-fullscreen",
        -- Only valid with the 'builtin' previewer
        ["<F3>"]        = "toggle-preview-wrap",
        ["<F4>"]        = "toggle-preview",
        ["<S-down>"]    = "preview-page-down",
        ["<S-up>"]      = "preview-page-up",
        ["<S-left>"]    = "preview-page-reset",
      },
      fzf = {
        -- fzf '--bind=' options
        ["ctrl-u"]      = "unix-line-discard",
        ["ctrl-f"]      = "half-page-down",
        ["ctrl-b"]      = "half-page-up",
        ["ctrl-a"]      = "beginning-of-line",
        ["ctrl-e"]      = "end-of-line",
        ["alt-a"]       = "toggle-all",
        -- Only valid with fzf previewers (bat/cat/git/etc)
        ["f3"]          = "toggle-preview-wrap",
        ["f4"]          = "toggle-preview",
        ["shift-down"]  = "preview-page-down",
        ["shift-up"]    = "preview-page-up",
      },
    },
    -- use skim instead of fzf?
    -- https://github.com/lotabout/skim
    -- fzf_bin          = 'sk',
    fzf_opts = {
      -- options are sent as `<left>=<right>`
      -- set to `false` to remove a flag
      -- set to '' for a non-value flag
      -- for raw args use `fzf_args` instead
      ['--ansi']        = '',
      ['--prompt']      = ' >',
      ['--info']        = 'inline',
      ['--height']      = '100%',
      ['--layout'] = 'default',
    },
    preview_border      = 'border',       -- border|noborder
    preview_wrap        = 'nowrap',       -- wrap|nowrap
    preview_opts        = 'nohidden',     -- hidden|nohidden
    preview_vertical    = 'down:45%',     -- up|down:size
    preview_horizontal  = 'right:50%',    -- right|left:size
    preview_layout      = 'horizontal',         -- horizontal|vertical|flex
    flip_columns        = 120,            -- #cols to switch to horizontal on flex
    default_previewer   = "bat",       -- override the default previewer?
    -- by default uses the builtin previewer
    previewers = {
      bat = {
        cmd             = "bat",
        args            = "--style=numbers,changes --color always",
        config          = nil,            -- nil uses $BAT_CONFIG_PATH
      },
      head = {
        cmd             = "head",
        args            = nil,
      },
      git_diff = {
        cmd             = "git diff",
        args            = "--color",
      },
    },
    -- provider setup
    files = {
      -- previewer         = "cat",       -- uncomment to override previewer
      prompt            = 'Files❯ ',
      cmd               = 'ag -g ""',             -- "find . -type f -printf '%P\n'",
      git_icons         = false,           -- show git icons?
      file_icons        = true,           -- show file icons?
      color_icons       = true,           -- colorize file|git icons
    },
    grep = {
      prompt            = 'Ag❯ ',
      input_prompt      = 'Grep For❯ ',
      cmd               = "ag --color",
      git_icons         = false,           -- show git icons?
      file_icons        = true,           -- show file icons?
      color_icons       = true,           -- colorize file|git icons
    },
    oldfiles = {
      prompt            = 'History❯ ',
      cwd_only          = false,
    },
    -- uncomment to disable the previewer
    -- nvim = { marks    = { previewer = { _ctor = false } } },
    helptags = { previewer = { _ctor = false } },
    -- manpages = { previewer = { _ctor = false } },
    -- uncomment to set dummy win location (help|man bar)
    -- "topleft"  : up
    -- "botright" : down
    -- helptags = { previewer = { split = "topleft" } },
    -- manpages = { previewer = { split = "topleft" } },
    -- uncomment to use `man` command as native fzf previewer
    -- manpages = { previewer = { _ctor = require'fzf-lua.previewer'.fzf.man_pages } },
    -- optional override of file extension icon colors
    -- available colors (terminal):
    --    clear, bold, black, red, green, yellow
    --    blue, magenta, cyan, grey, dark_grey, white
    -- padding can help kitty term users with
    -- double-width icon rendering
    file_icon_padding = '',
  }
end

local tree_loaded = false
vim.g.setup_nvim_tree = function()
  if tree_loaded then return end
  tree_loaded = true

  vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache' } -- empty by default
  vim.g.nvim_tree_gitignore = 1
  vim.g.nvim_tree_hide_dotfiles = 1
  vim.g.nvim_tree_group_empty = 1
  -- vim.g.nvim_tree_indent_markers = 1
  vim.g.nvim_tree_disable_window_picker = 1 "0 by default, will disable the window picker.
  vim.g.nvim_tree_icon_padding = ' '

  local tree_cb = require'nvim-tree.config'.nvim_tree_callback
  -- default mappings
  local list = {
    { key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit") },
    { key = "v",                            cb = tree_cb("vsplit") },
    { key = "C",                            cb = tree_cb("cd") },
    { key = "s",                            cb = tree_cb("split") },
    { key = "t",                            cb = tree_cb("tabnew") },
    { key = "<",                            cb = tree_cb("prev_sibling") },
    { key = ">",                            cb = tree_cb("next_sibling") },
    { key = "<Tab>",                        cb = tree_cb("preview") },
    { key = "K",                            cb = tree_cb("first_sibling") },
    { key = "J",                            cb = tree_cb("last_sibling") },
    { key = "H",                            cb = tree_cb("toggle_ignored") },
    { key = "I",                            cb = tree_cb("toggle_dotfiles") },
    { key = "R",                            cb = tree_cb("refresh") },
    { key = "a",                            cb = tree_cb("create") },
    { key = "d",                            cb = tree_cb("remove") },
    { key = "r",                            cb = tree_cb("rename") },
    { key = "<C-r>",                        cb = tree_cb("full_rename") },
    { key = "x",                            cb = tree_cb("close_node") },
    { key = "yy",                           cb = tree_cb("copy") },
    { key = "P",                            cb = tree_cb("paste") },
    { key = "<c-y>",                        cb = tree_cb("copy_name") },
    { key = "Y",                            cb = tree_cb("copy_path") },
    { key = "gy",                           cb = tree_cb("copy_absolute_path") },
    { key = "[c",                           cb = tree_cb("prev_git_item") },
    { key = "]c",                           cb = tree_cb("next_git_item") },
    { key = "<BC>",                         cb = tree_cb("dir_up") },
    { key = "<c-s>",                        cb = tree_cb("system_open") },
    { key = "q",                            cb = tree_cb("close") },
    { key = "g?",                           cb = tree_cb("toggle_help") },
  }
  require'nvim-tree'.setup {
    view = {
      width = 35,
      mappings = {
        -- custom only false will merge the list with the default mappings
        -- if true, it will only use your list to set the mappings
        custom_only = true,
        -- list of mappings to set on the tree manually
        list = list
      }
    }
  }
end

-- keybindings
vim.api.nvim_set_keymap('n', '<leader>b', '<Cmd>FzfLua buffers<cr>', {noremap = true})

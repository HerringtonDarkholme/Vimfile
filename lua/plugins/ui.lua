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

local function setupWilder()
  local wilder = require('wilder')

  wilder.set_option('pipeline', {
    wilder.branch(
      wilder.cmdline_pipeline({
        -- sets the language to use, 'vim' and 'python' are supported
        language = 'python',
        -- 0 turns off fuzzy matching
        -- 1 turns on fuzzy matching
        -- 2 partial fuzzy matching (match does not have to begin with the same first letter)
        fuzzy = 1,
      }),
      wilder.python_search_pipeline({
        -- can be set to wilder#python_fuzzy_delimiter_pattern() for stricter fuzzy matching
        pattern = wilder.python_fuzzy_pattern(),
        -- omit to get results in the order they appear in the buffer
        sorter = wilder.python_difflib_sorter(),
        -- can be set to 're2' for performance, requires pyre2 to be installed
        -- see :h wilder#python_search() for more details
        engine = 're',
      })
    ),
  })
  wilder.set_option('renderer', wilder.wildmenu_renderer(
    -- use wilder.wildmenu_lightline_theme() if using Lightline
    wilder.wildmenu_airline_theme({
      -- highlights can be overriden, see :h wilder#wildmenu_renderer()
      highlights = {
        default = 'lualine_c',
        selected = 'lualine_b_normal',
        mode = 'lualine_a_command',
        left_arrow2 = '',
        right_arrow2 = '',
        index = 'lualine_b_inactive',
      },
      use_powerline_symbols = true,
      highlighter = wilder.basic_highlighter(),
      separator = ' ',
    })
  ))
  wilder.setup({modes = {':', '/', '?'}})
end

return {
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    opts = {
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
        },
      },
      extensions = {'fzf', 'nvim-tree', 'fugitive'},
    }
  },
  { 'lewis6991/gitsigns.nvim', lazy = false, opts = {} },
  {
    'lewis6991/satellite.nvim',
    opts = {
      width = 1,
      winblend = 50,
      handlers = {
        -- make gitsign overlap with scrollbar
        gitsigns = {
          overlap = true,
          -- also, bump down priority to make it less noisy
          priority = 5,
        }
      }
    }
  },
  {
    'folke/which-key.nvim',
    lazy = true,
    opts = {
      plugins = {
        spelling = {
          enabled = true,
        },
      }
    }
  },
  {
    'ibhagwan/fzf-lua',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      winopts = {
        split         = "belowright new",-- open in a split instead?
        preview = {
          border = 'border',       -- border|noborder
          wrap = false,
          hidden = false,
          vertical = 'down:45%',     -- up|down:size
          horizontal = 'right:50%',    -- right|left:size
          layout = 'horizontal',         -- horizontal|vertical|flex
          flip_columns        = 120,      -- #cols to switch to horizontal on flex
          default_previewer   = "bat",   -- override the default previewer?
        }
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
        -- cmd               = 'ag -g ""',             -- "find . -type f -printf '%P\n'",
        git_icons         = false,           -- show git icons?
        file_icons        = true,           -- show file icons?
        color_icons       = true,           -- colorize file|git icons
      },
      grep = {
        prompt            = 'Rg❯ ',
        input_prompt      = 'Grep For❯ ',
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
  },
  {
    'kyazdani42/nvim-tree.lua',
    init = function()
      -- vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache' } -- empty by default
      -- vim.g.nvim_tree_gitignore = 1
      vim.g.nvim_tree_hide_dotfiles = 1
      vim.g.nvim_tree_icon_padding = ' '
    end,
    opts = {
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
  },
  {
    'gelguy/wilder.nvim',
    event = 'CmdlineEnter',
    config = setupWilder,
  }
}

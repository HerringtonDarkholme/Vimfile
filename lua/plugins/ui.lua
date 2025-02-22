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
  { 'lewis6991/gitsigns.nvim' },
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
  }
}

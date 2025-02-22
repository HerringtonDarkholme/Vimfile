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
}

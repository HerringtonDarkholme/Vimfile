return {
  { 'lifepillar/vim-solarized8', lazy = false },
  { 'Raimondi/delimitMate', lazy = false },
  { 'michaeljsmith/vim-indent-object', lazy = false },
  { 'tpope/vim-repeat', lazy = false },
  { 'tpope/vim-rsi', lazy = false },
  { 'tpope/vim-commentary', lazy = false },
  { 'tpope/vim-surround', lazy = false },
  { 'editorconfig/editorconfig-vim', lazy = false },
  { 'vijaymarupudi/nvim-fzf', lazy = false },
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all" (the four listed parsers should always be installed)
        ensure_installed = { "go", "python" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        -- List of parsers to ignore installing (for "all")
        ignore_install = { "javascript" },

        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        highlight = {
          -- `false` will disable the whole extension
          enable = true,

          -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
          -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
          -- the name of the parser)
          -- list of language that will be disabled
          disable = { "c", "rust", "javascript", "typescript", "tsx", "vue" },
          -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
          -- disable = function(lang, buf)
          --     local max_filesize = 100 * 1024 -- 100 KB
          --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          --     if ok and stats and stats.size > max_filesize then
          --         return true
          --     end
          -- end,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        }
      }
    end
  },
  { 'anuvyklack/pretty-fold.nvim', lazy = false },
  { 'kyazdani42/nvim-tree.lua', lazy = false },

  { 'kyazdani42/nvim-web-devicons', lazy = true },

  -- language plugin
  { 'justmao945/vim-clang', ft= { 'c', 'cpp' } },
  { 'octol/vim-cpp-enhanced-highlight', ft = 'cpp'},
  { 'rust-lang/rust.vim', ft = 'rust'},
  { 'posva/vim-vue', ft = { 'vue' }},
  { 'othree/html5.vim', ft = { 'html', 'pug' }},
  { 'cakebaker/scss-syntax.vim', ft = { 'scss', 'sass' }},
  { 'maksimr/vim-jsbeautify', ft = 'javascript'},
  { 'othree/yajs.vim', ft = 'javascript'},
  { 'mxw/vim-jsx', ft = 'javascript'},
  { 'othree/es.next.syntax.vim', ft = 'javascript'},
  { 'moll/vim-node', ft = { 'javascript', 'typescript' }},
  { 'HerringtonDarkholme/yats.vim', ft = { 'typescript', 'typescriptreact' }},
  { 'udalov/kotlin-vim', ft = 'kotlin'},
  { 'solarnz/thrift.vim', ft = { 'thrift' } },

  { 'Shougo/vinarise.vim',  cmd = 'Vinarise' },
  { 'tpope/vim-fugitive', cmd = 'Git' },
  { 'godlygeek/tabular',  cmd = 'Tabularize'},
  { 'simrat39/symbols-outline.nvim',  cmd = 'SymbolsOutline' },
}


-- " Dein 'derekwyatt/vim-scala', {'on_ft': 'scala'}
-- " Dein 'fatih/vim-go', {'on_ft': 'go'}
-- " Dein 'mattn/emmet-vim', {'on_ft': ['html', 'xml', 'vue']}
-- " Dein 'flowtype/vim-flow', {'on_ft': 'javascript'}

-- Dein 'gelguy/wilder.nvim', {'on_event': 'CmdlineEnter', 'hook_source': function('SetupWilder')}


-- Dein 'milkypostman/vim-togglelist', {'on_func': 'ToggleLocationList'}
-- Dein 'othree/eregex.vim', {'on_func': 'eregex#toggle'}

-- exec 'source ' . expand('<sfile>:p:h') . '/nvim.lua'

-- Dein 'gerw/vim-HiLinkTrace'

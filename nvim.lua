local lualine = require('lualine')

lualine.setup {
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

require('gitsigns').setup()

require('satellite').setup({
  width = 1,
  winblend = 35,
  handlers = {
    -- make gitsign overlap with scrollbar
    gitsigns = {
      overlap = true,
      -- also, bump down priority to make it less noisy
      priority = 5,
    }
  }
})

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

  -- vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache' } -- empty by default
  -- vim.g.nvim_tree_gitignore = 1
  vim.g.nvim_tree_hide_dotfiles = 1
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
    { key = "-",                            cb = tree_cb("close") },
    -- { key = "H",                            cb = tree_cb("toggle_ignored") },
    -- { key = "I",                            cb = tree_cb("toggle_dotfiles") },
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
        custom_only = false,
        -- list of mappings to set on the tree manually
        list = list
      }
    },
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
    disable = { "c", "rust", "javascript", "typescript", "tsx" },
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

require('pretty-fold').setup()

vim.g.setup_nvim_cmp = function()
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    mapping = {
      ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
      ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    }),
    experimental = {
      ghost_text = true,
    },
    completion = {
      completeopt = 'menu,menuone,noinsert',
    },
  })

  -- -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  -- cmp.setup.cmdline('/', {
  --   sources = {
  --     { name = 'buffer' }
  --   }
  -- })

  -- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  -- cmp.setup.cmdline(':', {
  --   sources = cmp.config.sources({
  --     { name = 'path' }
  --   }, {
  --     { name = 'cmdline' }
  --   })
  -- })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.

  -- keybindings
  vim.api.nvim_set_keymap('n', '<leader>b', '<Cmd>FzfLua buffers<cr>', {noremap = true})

  local nvim_lsp = require('lspconfig')
  local navic = require("nvim-navic")
  lualine.setup {
    tabline = {
      lualine_c = {
        { navic.get_location, cond = navic.is_available },
      }
    },
  }

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', ';d', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', ';t', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', ';r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', ';a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', ';l', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[c', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']c', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', ';q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    buf_set_keymap('n', ';f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    -- vim.api.nvim_command('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()')
    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
    end
  end

  local configs = require 'lspconfig.configs'
  configs.ast_grep = {
    default_config = {
      cmd = {'sg', 'lsp'};
      filetypes = {'typescript'};
      single_file_support = true;
      root_dir = nvim_lsp.util.root_pattern('.git', 'sgconfig.yml');
    };
  }
  -- Use a loop to conveniently call 'setup' on multiple servers and
  -- map buffer local keybindings when the language server attaches
  local servers = { 'cssls', 'rust_analyzer', 'tsserver', 'volar', 'ast_grep', 'gopls', 'pyright' }
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      }
    }
  end
end

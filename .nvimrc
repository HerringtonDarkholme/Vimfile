""""""""""""""""""""""""""""""""""""""""""""""""
" => configuration
""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set fileencoding=utf-8
set hidden
set termguicolors
if !exists('g:tabsize')
  let g:tabsize=2
endif
""""""""""""""""""""""""""""""""""""""""""""""""
" => highlight help
""""""""""""""""""""""""""""""""""""""""""""""""
set number
set title
set foldmethod=indent
set foldlevel=9999
"turn on wild menu
set cursorline
set wildmenu
set wildmode=list:longest,full "list possible commands"
set showmatch "match parens"
set nojoinspaces "no space between J"
set pastetoggle=<f10> "toggle paste"
set wildignore=*.o,*.pyc,node_modules
set mouse=a
set nojoinspaces

"highlight search result"
set hlsearch
"instant search(help re?)"
set incsearch
nn <silent> <F4> :set hlsearch! hlsearch?<CR>
" remap F3 to ;. The latter is used as localleader
nnoremap <F3> ;
let g:eregex_default_enable = 0
"Powerline"
"keep statusline fixed
set laststatus=2
"skip mode info in cmd
set noshowmode
" "quick leave insert mode
" if ! has('gui_running')
"      set ttimeoutlen=10
"      augroup FastEscape
"          autocmd!
"          au InsertEnter * set timeoutlen=0
"          au InsertLeave * set timeoutlen=1000
"      augroup END
" endif


""""""""""""""""""""""""""""""""""""""""""""""""
" => plugin
""""""""""""""""""""""""""""""""""""""""""""""""
" remap leader key to space
let mapleader = "\<space>"
" filetype plugin should use <LocalLeader>.
let maplocalleader = ";"

set splitbelow

"egrep for PCRE"
nnoremap <leader>/ :call eregex#toggle()<CR>
set previewheight=10

""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, Tab and Indent Related
""""""""""""""""""""""""""""""""""""""""""""""""
"Replace tabs with spaces"
set expandtab

"Make tabs 2 spaces"
exe "set tabstop=".g:tabsize
exe "set shiftwidth=".g:tabsize
exe "set softtabstop=".g:tabsize
" Disable Rust plugin's indentation
let g:rust_recommended_style = 0


"auto indent"
set autoindent
set smartindent
"Remove trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e

""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and Backup
"""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
" constant writing backup hurts SSD
set nobackup
set nowb
set noswapfile

" Reload files modified outside of Vim"
set autoread

""""""""""""""""""""""""""""""""""""""""""""""""
" => color!!
""""""""""""""""""""""""""""""""""""""""""""""""

"Allow  256 colors in Terminal
set t_Co=256
set background=light

"theme
let g:solarized_bold=1
let g:solarized_italic=1
let g:solarized_underline=1

let g:WebDevIconsUnicodeGlyphDoubleWidth = 0
let g:bufferline_echo=0

nmap <leader>a :HLT<cr>
nmap <leader>ve <cmd>e ~/Vimfile/.nvimrc<cr>
nmap <leader>vl <cmd>e ~/Vimfile/nvim.lua<cr>

""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking: https://github.com/kamykn/spelunker.vim
""""""""""""""""""""""""""""""""""""""""""""""""
set updatetime=500
set timeoutlen=500 " for WhichKey"
let g:spelunker_check_type = 2
let g:spelunker_disable_uri_checking = 1
let g:spelunker_spell_bad_group = 'SpellBad'
let g:spelunker_complex_or_compound_word_group = 'SpellRare'
silent! nmap <unique> ]s <Plug>(spelunker-jump-next)
silent! nmap <unique> [s <Plug>(spelunker-jump-prev)

""""""""""""""""""""""""""""""""""""""""""""""""
" => key binding
""""""""""""""""""""""""""""""""""""""""""""""""
" => jsbeautify
autocmd FileType javascript nn <buffer>  <localleader>f :call JsBeautify()<cr>
" for html
autocmd FileType html nn <buffer> <localleader>f :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css nn <buffer> <localleader>f :call CSSBeautify()<cr>
" redraw
nnoremap <C-S-l> <esc>:<c-u>redraw!

autocmd FileType FZF setlocal nonumber

""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving Around!!
""""""""""""""""""""""""""""""""""""""""""""""""
"move between windows
nn <C-j> <C-W>j
nn <C-k> <C-W>k
nn <C-h> <C-W>h
nn <C-l> <C-W>l

"make j,k moves between visual line, and gj,gk moves between real lines
no j gj
no k gk
no gj j
no gk k

"Emacs like c-k"
inoremap <c-k> <space><left><c-o>D

"Quick switch tab"
nnoremap <tab> :bn<cr>
nnoremap <s-tab> :bp<cr>
"switch buffer"
nn <A-a> :tabp<CR>
nn <A-d> :tabn<CR>


" tnoremap <esc><esc> <C-\><C-n>

""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing Mappings!!
""""""""""""""""""""""""""""""""""""""""""""""""
"Move a line with jkhl and alt, kick ass ST"
"http://vim.wikia.com/wiki/Moving_lines_up_or_down"
nn <A-j> :m .+1<CR>==
nn <A-k> :m .-2<CR>==
vn <A-j> :m '>+1<CR>gv=gv
vn <A-k> :m '<-2<CR>gv=gv
nn <A-h> <lt><lt>
nn <A-l> >>
exe "vn <A-h> <lt>gv".g:tabsize."h"
exe "vn <A-l> >gv".g:tabsize."l"


autocmd FileType c nn <localleader>s :vert sf %:t:r.c<cr>
autocmd FileType cpp nn <localleader>s :vert sf %:t:r.cpp<cr>
autocmd FileType c nn <localleader>h :vert sf %:t:r.h<cr>
autocmd FileType cpp nn <localleader>h :vert sf %:t:r.h<cr>

" set <A-j>=j
" set <A-k>=k
" set <A-h>=h
" set <A-l>=l
" set <A-f>=f
" set <A-b>=b
" set <A-d>=d
" set <A-a>=a

" => File Browswing
nn - :call g:setup_nvim_tree()<CR>:NvimTreeToggle<CR>

" => Syntastic Lint
nnoremap <silent><F2> :call ToggleLocationList()<CR>

"yank history yankring"
nn <silent> <F8> :SymbolsOutline<CR>

"CtrlP like"
nn <C-p> <Cmd>FzfLua files<cr>

"undo list"
" nn <silent> <leader>u :GundoToggle<CR>

"emmet
" autocmd BufEnter *.xml imap <buffer><expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
" autocmd BufEnter *.html imap <buffer><expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
 imap <C-y><C-y> <plug>(emmet-expand-abbr)
" let g:EditorConfig_core_mode = 'external_command'
" let g:EditorConfig_exec_path = 'editorconfig'

" comment plugin"
au FileType scss setlocal commentstring=//%s


"Grep"
function! s:search_word()
  let cmd = 'ag --color --' . expand('%:e')
  let word = expand('<cword>')
  exec "lua require('fzf-lua').grep({ cmd = '" . cmd . "', search='".word."' })"
endfunction
nn <silent> <leader>g :FzfLua grep<CR>
nn <silent> gr :call <SID>search_word()<CR>

nn <silent> gs :Git<CR>
nn <silent> gb :Git blame<CR>

augroup CSSSyntax
  autocmd!
  autocmd FileType css,scss,stylus setlocal iskeyword+=-
augroup END

" let g:fzf_statusline = 0 " disable statusline overwriting
" let g:fzf_nvim_statusline = 0 " disable statusline overwriting
" let g:fzf_layout = {'down': '15'}
function! SetupWilder() abort
call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#cmdline_pipeline({
      \       'language': 'python',
      \       'sorter': wilder#python_difflib_sorter(),
      \       'fuzzy': 1,
      \     }),
      \     wilder#python_search_pipeline({
      \       'sorter': wilder#python_difflib_sorter(),
      \     }),
      \   ),
      \ ])
let s:highlighters = [
        \ wilder#basic_highlighter(),
        \ ]
call wilder#setup({'modes': [':', '/', '?'], 'accept_key': '<c-e>'})
call wilder#set_option('renderer', wilder#wildmenu_renderer(wilder#wildmenu_airline_theme({ 'use_powerline_symbols': v:true, 'highlights': { 'default': 'lualine_c', 'selected': 'lualine_b_normal', 'mode': 'lualine_a_command', 'left_arrow2': '', 'right_arrow2': '', 'index': 'lualine_b_inactive', }, 'highlighter': s:highlighters, 'separator': ' ', })))
endfunction

let g:copilot_filetypes = {'*': v:false, 'markdown': v:true}

let g:dein#types#git#clone_depth = 1
set rtp+=~/.vim/dein/repos/github.com/Shougo/dein.vim/
" set rtp+=~/.fzf

let g:dein#lazy_rplugins = v:true

command! -nargs=+ -buffer Dein call dein#add(<args>)

call dein#begin(expand('~/.vim/dein'))

Dein 'Shougo/dein.vim'

" Dein 'vim-scripts/L9'
Dein 'nvim-lualine/lualine.nvim'
Dein 'Raimondi/delimitMate'
" Dein 'Shougo/vimproc.vim', {'build': 'make'}
Dein 'lewis6991/gitsigns.nvim'
Dein 'lewis6991/satellite.nvim'
Dein 'michaeljsmith/vim-indent-object'
Dein 'tpope/vim-repeat'
Dein 'tpope/vim-rsi'
Dein 'tpope/vim-commentary'
Dein 'tpope/vim-surround'
Dein 'lifepillar/vim-solarized8'
" Dein 'altercation/vim-colors-solarized'
" Dein 'ryanoasis/vim-devicons'
Dein 'editorconfig/editorconfig-vim'
Dein 'gelguy/wilder.nvim', {'on_event': 'CmdlineEnter', 'hook_source': function('SetupWilder')}

Dein 'vijaymarupudi/nvim-fzf'
Dein 'ibhagwan/fzf-lua', {'on_event': ['CursorHold', 'FocusLost'], 'hook_source': 'call g:setup_fzf_lua()'}
Dein 'kyazdani42/nvim-web-devicons'
Dein 'kyazdani42/nvim-tree.lua'
Dein 'nvim-treesitter/nvim-treesitter'
Dein 'anuvyklack/pretty-fold.nvim'

" Dein 'junegunn/fzf'
" Dein 'junegunn/fzf.vim', {'depends': 'fzf'}
Dein 'folke/which-key.nvim'

Dein 'justmao945/vim-clang', {'on_ft': ['c', 'cpp']}
Dein 'octol/vim-cpp-enhanced-highlight', {'on_ft': 'cpp'}
" Dein 'derekwyatt/vim-scala', {'on_ft': 'scala'}
Dein 'rust-lang/rust.vim', {'on_ft': 'rust'}
" Dein 'fatih/vim-go', {'on_ft': 'go'}
" Dein 'digitaltoad/vim-pug', {'on_ft': ['pug', 'vue']}
Dein 'posva/vim-vue', {'on_ft': ['vue']}
" Dein 'mattn/emmet-vim', {'on_ft': ['html', 'xml', 'vue']}
Dein 'othree/html5.vim', {'on_ft': ['html', 'pug']}
" Dein 'wavded/vim-stylus', {'on_ft': ['stylus', 'vue']}
Dein 'cakebaker/scss-syntax.vim', {'on_ft': ['scss', 'sass']}
Dein 'maksimr/vim-jsbeautify', {'on_ft': 'javascript'}
" Dein 'flowtype/vim-flow', {'on_ft': 'javascript'}
Dein 'othree/yajs.vim', {'on_ft': 'javascript'}
Dein 'mxw/vim-jsx', {'on_ft': 'javascript'}
Dein 'othree/es.next.syntax.vim', {'on_ft': 'javascript'}
Dein 'moll/vim-node', {'on_ft': ['javascript', 'typescript']}
Dein 'HerringtonDarkholme/yats.vim', {'on_ft': ['typescript', 'typescriptreact']}
Dein 'udalov/kotlin-vim', {'on_ft': 'kotlin'}
Dein 'solarnz/thrift.vim', {'on_ft': ['thrift']}

Dein 'tpope/vim-fugitive', {'on_cmd': ['Git']}
Dein 'godlygeek/tabular',  {'on_cmd': 'Tabularize'}
Dein 'simrat39/symbols-outline.nvim',  {'on_cmd': 'SymbolsOutline', 'hook_source': 'lua require("symbols-outline").setup()'}
" Dein 'majutsushi/tagbar',  {'on_cmd': 'TagbarToggle'}
" Dein 'scrooloose/nerdtree',  {'on_cmd': 'NERDTreeToggle'}
" Dein 'sjl/gundo.vim',  {'on_cmd': 'GundoToggle'}
Dein 'Shougo/vinarise.vim',  {'on_cmd': 'Vinarise'}
Dein 'neovim/nvim-lspconfig', {'on_event': 'InsertEnter', 'hook_source': 'call g:setup_nvim_cmp()'}
Dein 'github/copilot.vim', {'on_event': 'InsertEnter'}
Dein 'hrsh7th/cmp-nvim-lsp', {'on_event': 'InsertEnter'}
Dein 'hrsh7th/cmp-buffer', {'on_event': 'InsertEnter'}
Dein 'hrsh7th/cmp-path', {'on_event': 'InsertEnter'}
" Dein 'hrsh7th/cmp-cmdline', {'on_event': 'InsertEnter'}
Dein 'hrsh7th/nvim-cmp', {'on_event': 'InsertEnter'}
Dein 'hrsh7th/cmp-vsnip', {'on_event': 'InsertEnter'}
Dein 'rafamadriz/friendly-snippets', {'on_event': 'InsertEnter'}
Dein 'SmiteshP/nvim-navic', {'on_event': 'InsertEnter'}

Dein 'kamykn/spelunker.vim', {'on_event': 'InsertEnter'}

Dein 'milkypostman/vim-togglelist', {'on_func': 'ToggleLocationList'}
Dein 'othree/eregex.vim', {'on_func': 'eregex#toggle'}

exec 'source ' . expand('<sfile>:p:h') . '/nvim.lua'

Dein 'gerw/vim-HiLinkTrace'
call dein#end()


filetype plugin indent on
colorscheme solarized8
syntax enable
hi Pmenu guibg=#e5decc
hi SpellBad guifg=transparent guisp=red
hi SpellRare guifg=transparent
" search hilight reverse is unreadable in FZF ag output
hi Search gui=none guifg=#fdf6e3 guibg=#b58900
hi lualine_a_command gui=bold guifg=#fdf6e3 guibg=#b58900
hi GitSignsCurrentLineBlame guifg=#93a1a1 gui=italic

" NormalFloat for coc doc window
" hi Normal ctermbg=None
" the default highlight reverse is readability disaster
" hi NormalFloat cterm=none ctermfg=7 ctermbg=0
" hi SignColumn ctermbg=15
" hi WhichKeyFloat ctermbg=7

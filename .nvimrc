""""""""""""""""""""""""""""""""""""""""""""""""
" => configuration
""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set fileencoding=utf-8
set hidden
set foldlevel=99
set foldmethod=indent
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
set omnifunc=syntaxcomplete#Complete

" remap leader key to space
let mapleader = "\<space>"
" filetype plugin should use <LocalLeader>.
let maplocalleader = ";"

set splitbelow
" Enable omni completion."
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

"egrep for PCRE"
nnoremap <leader>/ :call eregex#toggle()<CR>

let g:echodoc_enable_at_startup=1

set previewheight=10
set completeopt-=preview
set completeopt+=noinsert

" let g:flow#autoclose = 1

""""""""""""""""""""""""""""""""
" => TextMate like Ultisnip"
""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, Tab and Indent Related
""""""""""""""""""""""""""""""""""""""""""""""""
"Replace tabs with spaces"
set expandtab

"Make tabs 4 spaces"
exe "set tabstop=".g:tabsize
exe "set shiftwidth=".g:tabsize
exe "set softtabstop=".g:tabsize


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

let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2
" let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
" let g:airline#extensions#tabline#show_tabs = 0
let g:WebDevIconsUnicodeGlyphDoubleWidth = 0
let g:bufferline_echo=0

nnoremap <tab> :bn<cr>
nnoremap <s-tab> :bp<cr>

"lint"
" autocmd! BufWritePost * Neomake
let g:neomake_warning_sign = {'text': '!!', 'texthl': 'Search'}
let g:neomake_error_sign = {'text': '✗', 'texthl': 'ErrorMsg'}
nmap <leader>a :HLT<cr>

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

"Quick switch buffer"
noremap [b :bn<CR>
noremap ]b :bp<CR>

tnoremap <esc><esc> <C-\><C-n>

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

"switch tab"
nn <A-a> :tabp<CR>
nn <A-d> :tabn<CR>

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
nn - :NERDTreeToggle<CR>
let NERDTreeMapOpenSplit = 's'
let NERDTreeMapOpenVSplit = 'v'
let NERDTreeIgnore = ['\.pyc$']

" => Syntastic Lint
nnoremap <silent><F2> :call ToggleLocationList()<CR>

"yank history yankring"
" nn <silent> <F12> :Unite history/yank<CR>
nn <silent> <F8> :TagbarToggle<CR>

"CtrlP like"
nn <C-p> :<C-u>Files<cr>

"undo list"
nn <silent> <leader>u :GundoToggle<CR>

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
  let arg = call('fzf#vim#with_preview', ['right'])
  let ag_opt = '-s --hidden --' . expand('%:e')
  call fzf#vim#ag(expand('<cword>'), ag_opt, arg, v:false)
endfunction
nn <silent> <leader>g :Ag<Space>
nn <silent> gr :call <SID>search_word()<CR>

"let g:dein#install_process_timeout=1000

" don't mimic coc list like
let g:coc_fzf_preview = 'right'
let g:coc_fzf_opts = ['--bind', 'alt-a:select-all,alt-d:deselect-all']

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <localleader>d <Plug>(coc-declaration)
nmap <silent> <localleader>t <Plug>(coc-type-definition)
nmap <silent> <localleader>i <Plug>(coc-implementation)
nmap <silent> <localleader>l <Plug>(coc-references)
nmap <silent> <localleader>a <Plug>(coc-codeaction)

nn <silent> gs :Gstatus<CR>
nn <silent> gb :Gblame<CR>

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> <c-]> :call <SID>jump_definition()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

function! s:jump_definition()
  if (index(['vim','help'], &filetype) >= 0 || !coc#rpc#ready())
    execute 'tag '.expand('<cword>')
  else
    call CocActionAsync('jumpDefinition')
  endif
endfunction

augroup CSSSyntax
  autocmd!
  autocmd FileType css,scss,stylus setlocal iskeyword+=-
augroup END

let g:fzf_nvim_statusline = 0 " disable statusline overwriting
let g:fzf_layout = {'down': '15'}

set rtp+=~/.vim/dein/repos/github.com/Shougo/dein.vim/
set rtp+=~/.fzf

command! -nargs=+ -bar Dein call dein#add(<args>)

call dein#begin(expand('~/.vim/dein'))

Dein 'Shougo/dein.vim'

Dein 'vim-scripts/L9'
Dein 'vim-airline/vim-airline'
Dein 'vim-airline/vim-airline-themes'
Dein 'bling/vim-bufferline'
Dein 'Raimondi/delimitMate'
Dein 'HerringtonDarkholme/vim-nerdtree-syntax-highlight'
" Dein 'Shougo/vimproc.vim', {'build': 'make'}
Dein 'airblade/vim-gitgutter'
Dein 'michaeljsmith/vim-indent-object'
Dein 'tpope/vim-repeat'
Dein 'tpope/vim-rsi'
Dein 'tpope/vim-commentary'
Dein 'tpope/vim-surround'
Dein 'altercation/vim-colors-solarized'
Dein 'ryanoasis/vim-devicons'
Dein 'editorconfig/editorconfig-vim'
Dein 'junegunn/fzf'
Dein 'junegunn/fzf.vim', {'depends': 'fzf'}
Dein 'folke/which-key.nvim'

Dein 'justmao945/vim-clang', {'on_ft': ['c', 'cpp']}
Dein 'octol/vim-cpp-enhanced-highlight', {'on_ft': 'cpp'}
Dein 'derekwyatt/vim-scala', {'on_ft': 'scala'}
Dein 'rust-lang/rust.vim', {'on_ft': 'rust'}
Dein 'fatih/vim-go', {'on_ft': 'go'}
Dein 'digitaltoad/vim-pug', {'on_ft': ['pug', 'vue']}
Dein 'posva/vim-vue', {'on_ft': ['vue']}
Dein 'mattn/emmet-vim', {'on_ft': ['html', 'xml', 'vue']}
Dein 'othree/html5.vim', {'on_ft': ['html', 'pug']}
Dein 'wavded/vim-stylus', {'on_ft': ['stylus', 'vue']}
Dein 'cakebaker/scss-syntax.vim', {'on_ft': ['scss', 'sass']}
Dein 'maksimr/vim-jsbeautify', {'on_ft': 'javascript'}
Dein 'flowtype/vim-flow', {'on_ft': 'javascript'}
Dein 'othree/yajs.vim', {'on_ft': 'javascript'}
Dein 'mxw/vim-jsx', {'on_ft': 'javascript'}
Dein 'othree/es.next.syntax.vim', {'on_ft': 'javascript'}
Dein 'moll/vim-node'
Dein 'HerringtonDarkholme/yats.vim', {'on_ft': ['typescript', 'typescriptreact']}
Dein 'solarnz/thrift.vim', {'on_ft': ['thrift']}

Dein 'tpope/vim-fugitive', {'on_cmd': ['Gstatus', 'Gblame']}
Dein 'godlygeek/tabular',  {'on_cmd': 'Tabularize'}
Dein 'majutsushi/tagbar',  {'on_cmd': 'TagbarToggle'}
Dein 'scrooloose/nerdtree',  {'on_cmd': 'NERDTreeToggle'}
Dein 'sjl/gundo.vim',  {'on_cmd': 'GundoToggle'}
Dein 'Shougo/vinarise.vim',  {'on_cmd': 'Vinarise'}

Dein 'honza/vim-snippets', {'on_i': 1}
Dein 'neoclide/coc.nvim', {'on_i': 1, 'build': 'yarn install'}
Dein 'antoinemadec/coc-fzf', {'on_i': 1}
Dein 'Shougo/echodoc.vim', {'on_i': 1}
Dein 'SirVer/ultisnips', {'on_i': 1}
Dein 'kamykn/spelunker.vim', {'on_i': 1}

Dein 'milkypostman/vim-togglelist', {'on_func': 'ToggleLocationList'}
Dein 'othree/eregex.vim', {'on_func': 'eregex#toggle'}

Dein 'gerw/vim-HiLinkTrace'

lua << EOF
  require("which-key").setup {
    plugins = {
      spelling = {
        enabled = true,
      },
    }
  }
EOF

call dein#end()

" call coc#add_extension('coc-json', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-vetur', 'coc-pyls', 'coc-rls')


filetype plugin indent on
colorscheme solarized
syntax enable
" NormalFloat for coc doc window
hi Normal ctermbg=None
" the default highlight reverse is readability disaster
hi NormalFloat cterm=none ctermfg=7 ctermbg=0
" search hilight reverse is unreadable in FZF ag output
hi Search cterm=None ctermfg=15 ctermbg=3
hi SignColumn ctermbg=15
hi WhichKeyFloat ctermbg=7

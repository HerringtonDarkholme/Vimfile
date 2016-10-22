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
set nojoinspaces

"highlight search result"
set hlsearch
"instant search(help re?)"
set incsearch
nn <silent> <F4> :set hlsearch! hlsearch?<CR>
"egrep for PCRE"
nnoremap <leader>/ :call eregex#toggle()<CR>
let g:eregex_default_enable = 0
"Powerline"
"keep statusline fixed
set laststatus=2
"skip mode info in cmd
set noshowmode
"quick leave insert mode
if ! has('gui_running')
     set ttimeoutlen=10
     augroup FastEscape
         autocmd!
         au InsertEnter * set timeoutlen=0
         au InsertLeave * set timeoutlen=1000
     augroup END
endif

" " GUIsh insert cursor"
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

""""""""""""""""""""""""""""""""""""""""""""""""
" => plugin
""""""""""""""""""""""""""""""""""""""""""""""""
set omnifunc=syntaxcomplete#Complete


set splitbelow
" Enable omni completion."
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

let g:echodoc_enable_at_startup=1
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_completion_start_length = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.c =
\ '\w+\.\|\h\w*->'
let g:deoplete#omni_patterns.javascript = '[^. *\t]\.\w*'
" let g:deoplete#omni_patterns.typescript =
" \ '[^. *\t]\.\w*'
let g:deoplete#omni_patterns.python =
\ '\w+\.'

set previewheight=10
set completeopt-=preview
set completeopt+=noinsert

"neo-jedi compatibility"
let g:deoplete#sources#jedi#python_path='python3'
let g:flow#autoclose = 1

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
" set t_ZH=[3m
" set t_ZR=[23m
"Set colorscheme
" colorscheme monoterm
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
autocmd! BufWritePost * Neomake
let g:neomake_warning_sign = {'text': '!!', 'texthl': 'Search'}
let g:neomake_error_sign = {'text': '✗', 'texthl': 'ErrorMsg'}
nmap <leader>a :HLT<cr>

""""""""""""""""""""""""""""""""""""""""""""""""
" => key binding
""""""""""""""""""""""""""""""""""""""""""""""""
" => jsbeautify
autocmd FileType javascript nn <buffer>  <leader>f :call JsBeautify()<cr>
" for html
autocmd FileType html nn <buffer> <leader>f :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css nn <buffer> <leader>f :call CSSBeautify()<cr>
" redraw
nnoremap <C-S-l> <esc>:<c-u>redraw!

autocmd FileType typescript nn <buffer> K :<C-u>echo tsuquyomi#hint()<CR>

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
inoremap <c-k> <space><left><c-o>d$

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

autocmd FileType c nn <space>s :vert sf %:t:r.c<cr>
autocmd FileType cpp nn <space>s :vert sf %:t:r.cpp<cr>
autocmd FileType c nn <space>h :vert sf %:t:r.h<cr>
autocmd FileType cpp nn <space>h :vert sf %:t:r.h<cr>

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

" => TernJs shortcut
autocmd FileType javascript nn <buffer> <leader>. :TernDef<cr>
autocmd FileType javascript nn <buffer> <leader>r :TernRefs<cr>
autocmd FileType javascript nn <buffer> <leader>t :TernType<cr>
autocmd FileType javascript nn <buffer> <leader>q :TernRename<cr>

" => Syntastic Lint
nnoremap <silent><F2> :call ToggleLocationList()<CR>

"yank history yankring"
nn <silent> <F12> :Unite history/yank<CR>
nn <silent> <F8> :TagbarToggle<CR>

"VimShell"
nn <leader>s :lcd %:p:h<CR>:Ttoggle<CR>
"CtrlP MRU first"
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files --exclude-standard']
 let g:ctrlp_tilde_homedir = 1

"undo list"
nn <silent> <leader>u :GundoToggle<CR>
"Grep"
nn <silent> gb :Unite grep:%<CR><C-r><C-w><CR>
nn <silent> <leader>g :Unite grep:. -default-action=tabopen<CR>
nn <silent> gl :Unite grep:$buffers -default-action=tabopen<CR><C-r><C-w>
nn <silent> gr :Unite grep:.:--include='*.<C-r>=expand("%:e")<CR>' -default-action=tabopen<CR><C-r><C-w><CR>

" neoterm
let g:neoterm_size = '10'

"emmet
" autocmd BufEnter *.xml imap <buffer><expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
" autocmd BufEnter *.html imap <buffer><expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
let g:gitgutter_async = 0


" comment plugin"
au FileType scss setlocal commentstring=//%s

"Unite"
nnoremap <leader><C-p> :<C-u>Unite -start-insert file_rec/async<CR>
let g:unite_split_rule = 'botright'
let g:unite_prompt='> '
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts =
\ '--vimgrep --hidden --ignore ''.git'' ' .
\ '--ignore ''.min.js'''
let g:unite_source_grep_recursive_opt = ''

nn <silent> gr :Unite grep:.:'-G\.<C-r>=expand("%:e")<CR>$' -default-action=tabopen<CR><C-r><C-w><CR>

let g:dein#install_process_timeout=1000
"eclim
let g:EclimCompletionMethod='omnifunc'
let g:EclimFileTypeValidate = 0
autocmd FileType scala nn <buffer> <leader>i :ScalaImport<cr>
autocmd FileType java nn <buffer> <leader>i :JavaImport<cr>

set rtp+=~/.vim/dein/repos/github.com/Shougo/dein.vim/
call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')

call dein#add('L9')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('bling/vim-bufferline')
call dein#add('Raimondi/delimitMate')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/denite.nvim')
call dein#add('ryanoasis/vim-devicons')
call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})
call dein#add('airblade/vim-gitgutter')
call dein#add('michaeljsmith/vim-indent-object')
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-repeat')
call dein#add('tpope/vim-rsi')
call dein#add('tpope/vim-commentary')
call dein#add('SirVer/ultisnips')
call dein#add('honza/vim-snippets')
call dein#add('tpope/vim-surround')
call dein#add('altercation/vim-colors-solarized')
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('FelikZ/ctrlp-py-matcher')

call dein#add('justmao945/vim-clang',
      \{'on_ft': ['c', 'cpp']})
call dein#add('octol/vim-cpp-enhanced-highlight',
      \{'on_ft': 'cpp'})
" call dein#add('davidhalter/jedi-vim',
"       \{'on_ft': 'python'})
call dein#add('zchee/deoplete-jedi',
      \{'on_ft': 'python'})
call dein#add('derekwyatt/vim-scala',
      \{'on_ft': 'scala'})
call dein#add('fatih/vim-go',
      \{'on_ft': 'go'})
call dein#add('zchee/deoplete-go',
      \{'on_ft': 'go'})
call dein#add('digitaltoad/vim-pug',
      \{'on_ft': ['pug', 'vue']})
call dein#add('HerringtonDarkholme/jedi-syntax',
      \{'on_ft': 'jedi'})
call dein#add('mattn/emmet-vim',
      \{'on_ft': ['html', 'xml']})
call dein#add('othree/html5.vim',
      \{'on_ft': ['html', 'pug', 'jedi']})
call dein#add('wavded/vim-stylus',
      \{'on_ft': ['stylus', 'vue']})
call dein#add('cakebaker/scss-syntax.vim',
      \{'on_ft': ['scss', 'sass']})
call dein#add('maksimr/vim-jsbeautify',
      \{'on_ft': 'javascript'})
call dein#add('nikvdp/ejs-syntax',
      \{'on_ft': 'ejs'})
call dein#add('flowtype/vim-flow',
      \{'on_ft': 'javascript'})
call dein#add('othree/yajs.vim',
      \{'on_ft': 'javascript'})
call dein#add('moll/vim-node')
call dein#add('HerringtonDarkholme/yats.vim',
      \{'on_ft': ['typescript', 'vue']})
" call dein#add('Quramy/tsuquyomi')
call dein#add('Quramy/tsuquyomi',
      \{'on_ft': 'typescript'})
call dein#add('mhartington/deoplete-typescript',
      \{'on_ft': 'typescript'})

call dein#add('godlygeek/tabular',
      \ {'on_cmd': 'Tabularize'})
call dein#add('majutsushi/tagbar',
      \ {'on_cmd': 'TagbarToggle'})
call dein#add('scrooloose/nerdtree',
      \ {'on_cmd': 'NERDTreeToggle'})
call dein#add('sjl/gundo.vim',
      \ {'on_cmd': 'GundoToggle'})
call dein#add('benekastah/neomake',
      \ {'on_cmd': 'Neomake'})
" call dein#add('kassio/neoterm',
"       \ {'on_cmd': 'Ttoggle'})

call dein#add('posva/vim-vue',
      \{'on_ft': ['vue']})
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/echodoc.vim',
              \{'on_i': 1})

call dein#add('milkypostman/vim-togglelist',
            \{'on_func': 'ToggleLocationList'})
call dein#add('othree/eregex.vim',
            \{'on_func': 'eregex#toggle'})

call dein#add('gerw/vim-HiLinkTrace')
" call dein#add('terryma/vim-multiple-cursors')
call dein#add('editorconfig/editorconfig-vim')
"
" call dein#add('fisadev/vim-ctrlp-cmdpalette',
"       \ {'on_cmd': ['CtrlPCmdPalette']})
" call dein#add('sgur/ctrlp-extensions.vim',
"       \ {'on_cmd': ['CtrlPTag', 'CtrlPBufTag']})

" NeoBundle 'gregsexton/gitv'
" NeoBundle 'scrooloose/syntastic'
" NeoBundle 'sheerun/vim-polyglot'
" NeoBundle 'kien/rainbow_parentheses.vim'
" NeoBundle 'fholgado/minibufexpl.vim'

" NeoBundleLazy 'slim-template/vim-slim',
"             \FiletypeLoad('slim')
" NeoBundleLazy 'tpope/vim-haml',
"             \FiletypeLoad('slim', 'haml')
" NeoBundleLazy 'tpope/vim-rails',
"             \FiletypeLoad('ruby')
" NeoBundleLazy 'jon-jacky/PyModel',
"             \FiletypeLoad('python')
" NeoBundleLazy 'HerringtonDarkholme/vim-coffee-script',
"             \FiletypeLoad('coffee')

" NeoBundleLazy 'Xuyuanp/nerdtree-git-plugin',
"             \CMDLoad('IndentLineToggle')

call dein#end()

filetype plugin indent on
colorscheme solarized
syntax enable

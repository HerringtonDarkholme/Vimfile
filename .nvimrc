""""""""""""""""""""""""""""""""""""""""""""""""
" => configuration
""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set fileencoding=utf-8
set hidden
set foldlevel=99
set foldmethod=indent
let tabsize=2
""""""""""""""""""""""""""""""""""""""""""""""""
" => highlight help
""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
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
set wildignore=*.o,*.pyc
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

let g:Powerline_dividers_override = ['', '', '', '']
let g:Powerline_symbols_override = {}
let g:Powerline_symbols_override.BRANCH = ''
let g:Powerline_symbols_override.READONLY = ''
let g:Powerline_symbols_override.LINENR = ''

" GUIsh insert cursor"
" function! SetBeamCursor()
"     if &ft !~ 'vimshell'
"         silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
"     endif
" endfunction

" function! SetBlockCursor()
"     if &ft !~ 'vimshell'
"         silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
"     endif
" endfunction

" au InsertEnter * call SetBeamCursor()
" au InsertLeave * call SetBlockCursor()

""""""""""""""""""""""""""""""""""""""""""""""""
" => plugin
""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete


set splitbelow
" set splitright
" Enable omni completion."
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" <CR>: close popup and save indent.
" ino <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"     "use silent mode to avoid bizzare char insertion"
" function! s:my_cr_function()
"     return pumvisible() ? neocomplete#close_popup() : "\<CR>"
" endfunction

set noshowmode
let g:echodoc_enable_at_startup=1
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_completion_start_length = 1
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.c =
\ '\w+\.\|\h\w*->'
let g:deoplete#omni_patterns.javascript =
\ '\w+\.'
let g:deoplete#omni_patterns.typescript =
\ '[^. *\t]\.\w*'
let g:deoplete#omni_patterns.python =
\ '\w+\.'

set previewheight=2
set completeopt-=preview
set completeopt+=noinsert

"Disable faux syntax element"
"if !exists('g:neocomplcache_keyword_patterns')
    "let g:neocomplcache_keyword_patterns = {}
"endif


" "" Plugin key-mappings.
" "inoremap <expr><C-g> neocomplcache#undo_completion()
" inoremap <expr><C-l> neocomplete#complete_common_string()
" " Close popup by <Space>.
" inoremap <expr><S-Space> pumvisible() ? neocomplete#smart_close_popup() : "\<Space>"

"neo-jedi compatibility"
let g:jedi#popup_on_dot = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#completions_command = ''
let g:jedi#goto_definitions_command='<c-]>'
autocmd  FileType python let b:did_ftplugin = 1
let g:jedi#force_py_version = 3

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
exe "set tabstop=".tabsize
exe "set shiftwidth=".tabsize
exe "set softtabstop=".tabsize

autocmd FileType jade setlocal shiftwidth=2 tabstop=2 softtabstop=2

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
set t_ZH=[3m
set t_ZR=[23m
"Set colorscheme
" colorscheme monoterm
set background=light

"theme
let g:solarized_bold=1
let g:solarized_italic=1
let g:solarized_underline=1
let g:airline_powerline_fonts=1
"
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

tnoremap <esc> <C-\><C-n>

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
exe "vn <A-h> <lt>gv".tabsize."h"
exe "vn <A-l> >gv".tabsize."l"

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
let g:ctrlp_cmd = 'CtrlPMRU'

"VimShell"
nn <leader>s :lcd %:p:h<CR>:VimShellPop<CR>
"CtrlP MRU first"
let g:ctrlp_cmd = 'CtrlPMRU'
nnoremap <C-p> :<C-u>CtrlPMRU<CR>
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
" let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
"       \ --ignore .git
"       \ --ignore .svn
"       \ --ignore .hg
"       \ --ignore .DS_Store
"       \ --ignore "**/*.pyc"
"       \ --max-count 10000
"       \ -g ""'

"undo list"
nn <silent> <leader>u :GundoToggle<CR>
"Grep"
nn <silent> gb :Unite grep:%<CR><C-r><C-w><CR>
nn <silent> <leader>g :Unite grep:. -default-action=tabopen<CR>
nn <silent> gl :Unite grep:$buffers -default-action=tabopen<CR><C-r><C-w>
nn <silent> gr :Unite grep:.:--include='*.<C-r>=expand("%:e")<CR>' -default-action=tabopen<CR><C-r><C-w><CR>

" Use current directory as vimshell prompt.
let g:vimshell_prompt_expr =
\ '"λ ".escape(fnamemodify(getcwd(), ":~").">", "\\[]()?! ")." "'
let g:vimshell_prompt_pattern = '^λ \%(\f\|\\.\)\+> '
let g:vimshell_editor_command = 'vim'

aug vimshellOverride
  au FileType vimshell nmap <buffer> <C-k> <C-w>k
  au FileType vimshell imap <buffer> <C-l> <Plug>(vimshell_clear)
  au FileType vimshell imap <buffer> <C-r> <Plug>(vimshell_history_unite)
  au FileType vimshell inoremap <buffer> <C-x><C-r> <C-r>
  au BufEnter * let g:neocomplete#enable_auto_select=&filetype != 'vimshell'
aug END

" comment plugin"
au FileType scss setlocal commentstring=//%s

"Unite"
nnoremap <leader><C-p> :<C-u>Unite -start-insert file_rec/async<CR>
let g:unite_source_history_yank_enable=1
let g:unite_split_rule = 'botright'
let g:unite_source_grep_default_opts='-RHn'
let g:unite_prompt='> '

"eclim
let g:EclimCompletionMethod='omnifunc'
let g:EclimFileTypeValidate = 0
autocmd FileType scala nn <buffer> <leader>i :ScalaImport<cr>
autocmd FileType java nn <buffer> <leader>i :JavaImport<cr>

"vundle
function FiletypeLoad(...)
    return {'autoload': { 'filetypes' : a:000 }}
endfunction

function CMDLoad(...)
    return {'autoload': { 'commands' : a:000 }}
endfunction

filetype off                   " required!
set rtp+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))

"Neo bundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'L9'
NeoBundle 'bling/vim-airline'
NeoBundle 'bling/vim-bufferline'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'michaeljsmith/vim-indent-object'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-rsi'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'
NeoBundle 'tpope/vim-surround'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'FelikZ/ctrlp-py-matcher'

NeoBundleLazy 'fisadev/vim-ctrlp-cmdpalette',
            \CMDLoad('CtrlPCmdPalette')
NeoBundleLazy 'sgur/ctrlp-extensions.vim',
		\CMDLoad('CtrlPTag', 'CtrlPBufTag')

NeoBundleLazy 'Shougo/vimshell.vim',{
            \ 'depends' : 'Shougo/vimproc.vim',
            \ 'autoload' : {
            \   'commands' : [{ 'name' : 'VimShell',
            \                   'complete' : 'customlist,vimshell#complete'},
            \                 'VimShellExecute', 'VimShellInteractive',
            \                 'VimShellTerminal', 'VimShellPop'],
            \   'mappings' : ['<Plug>(vimshell_']
            \ }}

"NeoBundleCheck
NeoBundleLazy 'justmao945/vim-clang',
            \FiletypeLoad('c', 'cpp')
NeoBundleLazy 'cakebaker/scss-syntax.vim',
            \FiletypeLoad('scss', 'sass')
NeoBundleLazy 'davidhalter/jedi-vim',
            \FiletypeLoad('python')
NeoBundleLazy 'digitaltoad/vim-jade',
            \FiletypeLoad('jade')
NeoBundleLazy 'maksimr/vim-jsbeautify',
            \FiletypeLoad('javascript')
NeoBundleLazy 'marijnh/tern_for_vim',
            \FiletypeLoad('javascript')
NeoBundleLazy 'othree/yajs.vim',
            \FiletypeLoad('javascript')
NeoBundleLazy 'HerringtonDarkholme/yats.vim',
			\FiletypeLoad('typescript')
NeoBundleLazy 'Quramy/tsuquyomi',
			\FiletypeLoad('typescript')
NeoBundleLazy 'octol/vim-cpp-enhanced-highlight',
      \FiletypeLoad('cpp')
NeoBundleLazy 'mattn/emmet-vim',
            \FiletypeLoad('html', 'xml')
NeoBundleLazy 'moll/vim-node',
            \FiletypeLoad('javascript')
NeoBundleLazy 'othree/html5.vim',
            \FiletypeLoad('html', 'slim', 'jade')
NeoBundleLazy 'derekwyatt/vim-scala',
            \FiletypeLoad('scala')
NeoBundleLazy 'wavded/vim-stylus',
			\FiletypeLoad('stylus')


NeoBundleLazy 'godlygeek/tabular',
            \CMDLoad('Tabularize')
NeoBundleLazy 'majutsushi/tagbar',
            \CMDLoad('TagbarToggle')
NeoBundleLazy 'scrooloose/nerdtree',
            \CMDLoad('NERDTreeToggle')
NeoBundleLazy 'HerringtonDarkholme/vim-worksheet',
            \CMDLoad('WorksheetStart')
NeoBundleLazy 'sjl/gundo.vim',
            \CMDLoad('GundoToggle')
NeoBundleLazy 'benekastah/neomake',
            \CMDLoad('Neomake')

NeoBundleLazy 'Shougo/deoplete.nvim',
              \{'autoload': {'insert': 1}}
NeoBundleLazy 'Shougo/echodoc.vim',
              \{'autoload': {'insert': 1}}

NeoBundleLazy 'milkypostman/vim-togglelist',{
            \ 'autoload': {'functions':
            \   'ToggleLocationList'
            \}}
NeoBundleLazy 'othree/eregex.vim',{
            \ 'autoload': {'functions':
            \   'eregex#toggle'
            \}}

NeoBundle 'gerw/vim-HiLinkTrace'
" NeoBundle 'gregsexton/gitv'
" NeoBundle 'scrooloose/syntastic'
" NeoBundle 'zhuangya/YankRing.vim'
" NeoBundle 'scrooloose/nerdcommenter'
" NeoBundle 'tpope/vim-abolish'
" NeoBundle 'Valloric/YouCompleteMe'
" NeoBundle 'sheerun/vim-polyglot'
" NeoBundle 'kien/rainbow_parentheses.vim'
" NeoBundle 'fholgado/minibufexpl.vim'

" NeoBundleLazy 'slim-template/vim-slim',
"             \FiletypeLoad('slim')
" NeoBundleLazy 'tpope/vim-haml',
"             \FiletypeLoad('slim', 'haml')
" NeoBundleLazy 'tpope/vim-rails',
"             \FiletypeLoad('ruby')
" NeoBundleLazy 'vim-ruby/vim-ruby',
"             \FiletypeLoad('ruby')
" NeoBundleLazy 'HerringtonDarkholme/jedi-syntax',
" 			\FiletypeLoad('jedi')
" NeoBundleLazy 'jon-jacky/PyModel',
"             \FiletypeLoad('python')
" NeoBundleLazy 'HerringtonDarkholme/vim-coffee-script',
"             \FiletypeLoad('coffee')

" NeoBundleLazy 'Xuyuanp/nerdtree-git-plugin',
"             \CMDLoad('NERDTreeToggle')
" NeoBundleLazy 'vim-scripts/grep.vim',
"             \CMDLoad('Grep', 'GrepArgs', 'GrepBuffer')
" NeoBundleLazy 'Yggdroot/indentLine',
"             \CMDLoad('IndentLineToggle')

" NeoBundleLazy 'Shougo/neocomplete.vim',
"             \{'autoload': {'insert': 1 }}
call neobundle#end()

filetype plugin indent on
colorscheme solarized

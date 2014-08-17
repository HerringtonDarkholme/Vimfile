""""""""""""""""""""""""""""""""""""""""""""""""
" => configuration
""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set fileencoding=utf-8
set hidden
set backspace=2 "update2 vim74"
set foldmethod=indent
let tabsize=4
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
set wildignore=*.o,*.pyc

"highlight search result"
set hlsearch
"instant search(help re?)"
set incsearch
nn <silent> <F4> :set nohls<CR>
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

""""""""""""""""""""""""""""""""""""""""""""""""
" => plugin
""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

""""""""""""""""""""""""""""""""""""""""""""""""
" => auto complete and snippet for DarkVimMaster
""""""""""""""""""""""""""""""""""""""""""""""""
let g:neocomplete#enable_auto_select=1
let g:neocomplete#auto_completion_start_length=1
let g:neocomplete#enable_at_startup=1
"let g:neocomplete#enable_smart_case=1
"cursor move for insert mode"
let g:neocomplete#enable_insert_char_pre=1
"let g:neocomplete#enable_cursor_hold_i=1
let g:neocomplete#max_list=9
"don't auto close preview. makes it no ostentatious"
let g:neocomplete#enable_auto_close_preview=0
let g:neocomplete#enable_fuzzy_completion=0
set previewheight=2
set completeopt-=preview

"Disable faux syntax element"
"if !exists('g:neocomplcache_keyword_patterns')
    "let g:neocomplcache_keyword_patterns = {}
"endif

set splitbelow
" Enable omni completion."
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" <CR>: close popup and save indent.
ino <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    "use silent mode to avoid bizzare char insertion"
function! s:my_cr_function()
    return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

"" Plugin key-mappings.
"inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()
" Close popup by <Space>.
inoremap <expr><S-Space> pumvisible() ? neocomplete#smart_close_popup() : "\<S-Space>"

let g:neocomplete#force_overwrite_completefunc = 1
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
  let g:neocomplete#sources#omni#functions = {}
endif

let g:neocomplete#sources#omni#input_patterns.c =
\ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?'
let g:neocomplete#sources#omni#input_patterns.javascript =
\ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?'
let g:neocomplete#sources#omni#input_patterns.python =
\'[^. \t]\.\w*'

let g:neocomplete#sources#omni#functions.python = 'jedi#completions'
let g:neocomplete#sources#omni#functions.javascript = 'tern#Complete'

"neo-jedi compatibility"
let g:jedi#popup_on_dot = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#completions_command = ''
autocmd  FileType python let b:did_ftplugin = 1

""""""""""""""""""""""""""""""""
" => TextMate like Ultisnip"
"""""""""""""""""""""""""""""""
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

" indnet line"
let g:indentLine_color_term = 236
let g:indentLine_char = '┊'
let g:indentLine_noConcealCursor = 1
let g:indentLine_enabled = 0

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
"Set colorscheme
colorscheme monoterm



"lint"
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='!!'
let g:toggle_list_no_mappings=1


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
"switch tab"
nn <A-a> :tabp<CR>
nn <A-d> :tabn<CR>

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
nn cr <Plug>Coerce


set <A-j>=∆
set <A-k>=˚
set <A-h>=˙
set <A-l>=¬
set <A-a>=å
set <A-d>=∂

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
nn <silent> <F12> :YRShow<CR>
nn <silent> <F8> :TagbarToggle<CR>
"disable c-p for ctrl-p"
let g:yankring_replace_n_pkey = '<a-p>'

"VimShell"
nn <leader>s :lcd %:p:h<CR>:VimShellPop<CR>
"CtrlP MRU first"
let g:ctrlp_cmd = 'CtrlPMRU'
nnoremap <C-p> :<C-u>CtrlPMRU<CR>

"undo list"
nn <silent> <leader>u :GundoToggle<CR>
"Grep"
nn <silent> <leader>gg :Grep<CR>
nn <silent> <leader>ga :GrepArgs<CR>
nn <silent> <leader>gb :GrepBuffer<CR>

" Use current directory as vimshell prompt.
let g:vimshell_prompt_expr =
\ '"λ ".escape(fnamemodify(getcwd(), ":~").">", "\\[]()?! ")." "'
let g:vimshell_prompt_pattern = '^λ \%(\f\|\\.\)\+> '
let g:vimshell_editor_command = 'vim'

aug vimshellOverride
  au FileType vimshell imap <buffer> <SPACE> <SPACE>
  au FileType vimshell nmap <buffer> <C-k> <C-w>k
  au FileType vimshell imap <buffer> <expr><Tab> neocomplete#complete_common_string()
aug END

" comment plugin"
au FileType scss setlocal commentstring=//%s

let g:syntastic_javascript_jshint_args='-c ~/.jshintrc'

"Unite"
nnoremap <leader><C-p> :<C-u>Unite -start-insert file_rec/async<CR>
let g:unite_enable_start_insert = 1
let g:unite_winheight = 10
let g:unite_split_rule = 'botright'


"vundle
function FiletypeLoad(...)
    return {'autoload': { 'filetypes' : a:000 }}
endfunction

function CMDLoad(...)
    return {'autoload': { 'commands' : a:000 }}
endfunction

filetype off                   " required!
set rtp+=~/.vim/bundle/neobundle.vim/
call neobundle#rc(expand('~/.vim/bundle/'))

"Neo bundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'L9'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'gregsexton/gitv'
NeoBundle 'michaeljsmith/vim-indent-object'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-rsi'
NeoBundle 'zhuangya/YankRing.vim'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'
NeoBundle 'tpope/vim-surround'

NeoBundleLazy 'Shougo/vimshell',{
            \ 'depends' : 'Shougo/vimproc.vim',
            \ 'autoload' : {
            \   'commands' : [{ 'name' : 'VimShell',
            \                   'complete' : 'customlist,vimshell#complete'},
            \                 'VimShellExecute', 'VimShellInteractive',
            \                 'VimShellTerminal', 'VimShellPop'],
            \   'mappings' : ['<Plug>(vimshell_']
            \ }}

"Bundle 'Shougo/neocomplcache.vim'
"Bundle 'Valloric/YouCompleteMe'
"Bundle 'sheerun/vim-polyglot'
"Bundle 'kien/rainbow_parentheses.vim'
"Bundle 'fholgado/minibufexpl.vim'


"NeoBundleCheck
NeoBundleLazy 'HerringtonDarkholme/vim-coffee-script',
            \FiletypeLoad('coffee')
NeoBundleLazy 'Rip-Rip/clang_complete',
            \FiletypeLoad('c', 'cpp')
NeoBundleLazy 'cakebaker/scss-syntax.vim',
            \FiletypeLoad('scss', 'sass')
NeoBundleLazy 'davidhalter/jedi-vim',
            \FiletypeLoad('python')
NeoBundleLazy 'digitaltoad/vim-jade',
            \FiletypeLoad('jade')
NeoBundleLazy 'jon-jacky/PyModel',
            \FiletypeLoad('python')
NeoBundleLazy 'maksimr/vim-jsbeautify',
            \FiletypeLoad('javascript')
NeoBundleLazy 'marijnh/tern_for_vim',
            \FiletypeLoad('javascript')
NeoBundleLazy 'mattn/emmet-vim',
            \FiletypeLoad('html', 'xml')
NeoBundleLazy 'moll/vim-node',
            \FiletypeLoad('javascript')
NeoBundleLazy 'othree/html5.vim',
            \FiletypeLoad('html', 'slim', 'jade')
NeoBundleLazy 'slim-template/vim-slim',
            \FiletypeLoad('slim')
NeoBundleLazy 'tpope/vim-haml',
            \FiletypeLoad('slim', 'haml')
NeoBundleLazy 'tpope/vim-rails',
            \FiletypeLoad('ruby')
NeoBundleLazy 'vim-ruby/vim-ruby',
            \FiletypeLoad('ruby')
NeoBundleLazy 'derekwyatt/vim-scala',
            \FiletypeLoad('scala')

NeoBundleLazy 'Yggdroot/indentLine',
            \CMDLoad('IndentLineToggle')
NeoBundleLazy 'fisadev/vim-ctrlp-cmdpalette',
            \CMDLoad('CtrlPCmdPalette')
NeoBundleLazy 'godlygeek/tabular',
            \CMDLoad('Tabularize')
NeoBundleLazy 'kien/ctrlp.vim',
            \CMDLoad('CtrlPMRU')
NeoBundleLazy 'majutsushi/tagbar',
            \CMDLoad('TagbarToggle')
NeoBundleLazy 'scrooloose/nerdtree',
            \CMDLoad('NERDTreeToggle')
NeoBundleLazy 'sjl/gundo.vim',
            \CMDLoad('GundoToggle')
NeoBundleLazy 'vim-scripts/grep.vim',
            \CMDLoad('Grep', 'GrepArgs', 'GrepBuffer')

" NeoBundle 'JazzCore/neocomplcache-ultisnips'
" NeoBundle 'Shougo/neocomplete.vim'
" NeoBundleLazy 'HerringtonDarkholme/neocomplcache-ultisnips',
"             \{'autoload': {'insert': 1 }}
NeoBundleLazy 'Shougo/neocomplete.vim',
            \{'autoload': {'insert': 1 }}

NeoBundleLazy 'milkypostman/vim-togglelist',{
            \ 'autoload': {'functions':
            \   'ToggleLocationList'
            \}}
NeoBundleLazy 'othree/eregex.vim',{
            \ 'autoload': {'functions':
            \   'eregex#toggle'
            \}}


filetype plugin indent on

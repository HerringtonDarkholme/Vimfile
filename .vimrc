""""""""""""""""""""""""""""""""""""""""""""""""
" => configuration
""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set fileencoding=utf-8
set hidden
set backspace=2 "update2 vim74"
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
set wildignore=*.o,*.pyc
"highlight search result"
set hlsearch
"instant search(help re?)"
set incsearch
nnoremap <F4> :set nohls<CR>
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
let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_smart_case=1
let g:neocomplcache_auto_completion_start_length=1
let g:neocomplcache_enable_auto_select=1
"cursor move for insert mode"
let g:neocomplcache_enable_insert_char_pre=1
"let g:neocomplcache_enable_cursor_hold_i=1
"make compl list reasonably long.
let g:neocomplcache_max_list=9
"don't auto close preview. makes it no ostentatious"
let g:neocomplcache_enable_auto_close_preview=0
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
    return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction

"" Plugin key-mappings.
"inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()
" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? neocomplcache#smart_close_popup() : "\<Space>"

if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
  let g:neocomplcache_omni_functions = {}
endif

let g:neocomplcache_omni_patterns.c =
\ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?'
let g:neocomplcache_omni_patterns.javascript =
\ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?'
let g:neocomplcache_omni_patterns.python =
\'[^. \t]\.\w*'

let g:neocomplcache_omni_functions.python = 'jedi#completions'
let g:neocomplcache_omni_functions.javascript = 'tern#Complete'

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
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
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

inoremap <c-k> <space><left><c-o>d$

"Quick switch buffer"
noremap [b :bn<CR>
noremap ]b :bp<CR>

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
"vn <A-left> <lt>gv4h
exe "vn <A-h> <lt>gv".tabsize."h"
"vn <A-right> >gv4l
exe "vn <A-l> >gv".tabsize."l"

"switch tab"
nn <A-a> :tabp<CR>
nn <A-d> :tabn<CR>

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
nmap <silent> <F2> :call ToggleLocationList()<CR>

"yank history yankring"
nn <silent> <F12> :YRShow<CR>
"disable c-p for ctrl-p"
nn <silent> <F8> :TagbarToggle<CR>
let g:yankring_replace_n_pkey='<a-p>'

"CtrlP MRU first"
let g:ctrlp_cmd = 'CtrlPMRU'

"undo list"
nn <leader>u :GundoToggle<CR>
"Grep"
nn <leader>g :Grep<CR>

"vimshell"
nn <leader>s :lcd %:p:h<CR>:VimShellPop<CR>
" Use current directory as vimshell prompt.
let g:vimshell_prompt_expr =
\ '"λ ".escape(fnamemodify(getcwd(), ":~").">", "\\[]()?! ")." "'
let g:vimshell_prompt_pattern = '^λ \%(\f\|\\.\)\+> '
let g:vimshell_editor_command = 'vim'
aug vimshellOverride
  au FileType vimshell imap <buffer> <SPACE> <SPACE>
  au FileType vimshell nmap <buffer> <C-k> <C-w>k
  " au FileType vimshell imap <buffer> <expr><Tab> neocomplcache#complete_common_string()
aug END

" comment plugin"
au FileType scss setlocal commentstring=//%s
vmap gcc <leader>c<space>
nmap gcc <leader>c<space>

let g:syntastic_javascript_jshint_args='-c ~/.jshintrc'

"Unite"
nnoremap <leader><C-p> :<C-u>Unite -start-insert file_rec/async<CR>
let g:unite_enable_start_insert = 1
let g:unite_winheight = 10
let g:unite_split_rule = 'botright'


"vundle
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"vundle bundle
Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'L9'
Bundle 'scrooloose/nerdtree'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'vim-scripts/grep.vim'
Bundle 'Yggdroot/indentLine'
Bundle 'scrooloose/syntastic'
Bundle 'majutsushi/tagbar'
Bundle 'sjl/gundo.vim'
Bundle 'SirVer/ultisnips'
Bundle 'marijnh/tern_for_vim'
Bundle 'maksimr/vim-jsbeautify'
Bundle 'Shougo/vimproc.vim'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimshell.vim'
Bundle 'Shougo/neocomplcache.vim'
Bundle 'davidhalter/jedi-vim'
Bundle 'JazzCore/neocomplcache-ultisnips'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-rsi'
Bundle 'Lokaltog/vim-powerline'
Bundle 'othree/eregex.vim'
Bundle 'gregsexton/gitv'
Bundle 'Raimondi/delimitMate'
Bundle 'godlygeek/tabular'
Bundle 'milkypostman/vim-togglelist'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'vim-ruby/vim-ruby'
Bundle 'othree/html5.vim'
Bundle 'slim-template/vim-slim'
Bundle 'tpope/vim-haml'
Bundle 'HerringtonDarkholme/vim-coffee-script'
Bundle 'mattn/emmet-vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'fisadev/vim-ctrlp-cmdpalette'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'digitaltoad/vim-jade'
Bundle 'moll/vim-node'
Bundle 'tpope/vim-rails'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-repeat'
Bundle 'scrooloose/nerdcommenter'
Bundle 'jon-jacky/PyModel'
"Bundle 'Valloric/YouCompleteMe'
"Bundle 'sheerun/vim-polyglot'
"Bundle 'kien/rainbow_parentheses.vim'
"Bundle 'fholgado/minibufexpl.vim'

filetype plugin indent on

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
"egrep for PCRE"
nnoremap <leader>/ :call eregex#toggle()<CR>
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

let mapleader = "\<space>"


set splitbelow
" Enable omni completion."
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

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

" autocmd FileType typescript nn <buffer> K :<C-u>echo tsuquyomi#hint()<CR>
let g:nvim_typescript#default_mappings = 1

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
let NERDTreeIgnore = ['\.pyc$']

" => TernJs shortcut
autocmd FileType javascript nn <buffer> <leader>. :TernDef<cr>
autocmd FileType javascript nn <buffer> <leader>r :TernRefs<cr>
autocmd FileType javascript nn <buffer> <leader>t :TernType<cr>
autocmd FileType javascript nn <buffer> <leader>q :TernRename<cr>

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
let g:gitgutter_async = 0
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
" nn <silent> gr :Denite grep:.:-G\.<C-r>=expand("%:e")<CR>$:<C-r><C-w> -prompt='>'<CR>
nn <silent> gr :call <SID>search_word()<CR>
nn <silent> gb :BLines <C-r><C-w><CR>

"let g:dein#install_process_timeout=1000

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <c-]> <Plug>(coc-definition)
nmap <silent> gd <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
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
call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')

call dein#add('vim-scripts/L9')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('bling/vim-bufferline')
call dein#add('Raimondi/delimitMate')
call dein#add('HerringtonDarkholme/vim-nerdtree-syntax-highlight')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})
call dein#add('airblade/vim-gitgutter')
call dein#add('michaeljsmith/vim-indent-object')
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-repeat')
call dein#add('tpope/vim-rsi')
call dein#add('tpope/vim-commentary')
call dein#add('tpope/vim-surround')
call dein#add('altercation/vim-colors-solarized')
call dein#add('ryanoasis/vim-devicons')
" call dein#add('ctrlpvim/ctrlp.vim')
" call dein#add('FelikZ/ctrlp-py-matcher')
call dein#add('junegunn/fzf')
call dein#add('junegunn/fzf.vim', {'depends': 'fzf'})

call dein#add('justmao945/vim-clang',
      \{'on_ft': ['c', 'cpp']})
call dein#add('octol/vim-cpp-enhanced-highlight',
      \{'on_ft': 'cpp'})
call dein#add('derekwyatt/vim-scala',
      \{'on_ft': 'scala'})
call dein#add('rust-lang/rust.vim',
      \{'on_ft': 'rust'})
" call dein#add('fatih/vim-go',
"       \{'on_ft': 'go'})
call dein#add('digitaltoad/vim-pug',
      \{'on_ft': ['pug', 'vue']})
call dein#add('mattn/emmet-vim',
      \{'on_ft': ['html', 'xml', 'vue']})
call dein#add('othree/html5.vim',
      \{'on_ft': ['html', 'pug']})
call dein#add('wavded/vim-stylus',
      \{'on_ft': ['stylus', 'vue']})
call dein#add('cakebaker/scss-syntax.vim',
      \{'on_ft': ['scss', 'sass']})
call dein#add('maksimr/vim-jsbeautify',
      \{'on_ft': 'javascript'})
call dein#add('flowtype/vim-flow',
      \{'on_ft': 'javascript'})
call dein#add('othree/yajs.vim',
      \{'on_ft': 'javascript'})
call dein#add('mxw/vim-jsx',
      \{'on_ft': 'javascript'})
call dein#add('othree/es.next.syntax.vim',
      \{'on_ft': 'javascript'})
call dein#add('moll/vim-node')
call dein#add('HerringtonDarkholme/yats.vim',
      \{'on_ft': ['typescript', 'typescriptreact']})
call dein#add('solarnz/thrift.vim',
      \{'on_ft': ['thrift']})

call dein#add('godlygeek/tabular',
      \ {'on_cmd': 'Tabularize'})
call dein#add('majutsushi/tagbar',
      \ {'on_cmd': 'TagbarToggle'})
call dein#add('scrooloose/nerdtree',
      \ {'on_cmd': 'NERDTreeToggle'})
call dein#add('sjl/gundo.vim',
      \ {'on_cmd': 'GundoToggle'})
call dein#add('Shougo/denite.nvim',
      \ {'on_cmd': 'Denite'})
call dein#add('Shougo/vinarise.vim',
      \ {'on_cmd': 'Vinarise'})

call dein#add('posva/vim-vue',
      \{'on_ft': ['vue']})
call dein#add('honza/vim-snippets',
              \{'on_i': 1})
call dein#add('neoclide/coc.nvim',
              \{'on_i': 1, 'build': 'yarn install'})
call dein#add('Shougo/echodoc.vim',
              \{'on_i': 1})
call dein#add('SirVer/ultisnips',
              \{'on_i': 1})
call dein#add('editorconfig/editorconfig-vim')

call dein#add('milkypostman/vim-togglelist',
            \{'on_func': 'ToggleLocationList'})
call dein#add('othree/eregex.vim',
            \{'on_func': 'eregex#toggle'})

call dein#add('gerw/vim-HiLinkTrace')

" NeoBundleLazy 'Xuyuanp/nerdtree-git-plugin',
"             \CMDLoad('IndentLineToggle')

call dein#end()

" function DeniteCustomize()
"   call denite#custom#map('insert', "<C-j>", '<denite:move_to_next_line>')
"   call denite#custom#map('insert', "<C-k>", '<denite:move_to_previous_line>')
"   call denite#custom#map('insert', "<C-t>", '<denite:do_action:tabopen>')

"   call denite#custom#var('grep', 'command', ['ag'])
"   call denite#custom#var('grep', 'recursive_opts', [])
"   call denite#custom#var('grep', 'final_opts', [])
"   call denite#custom#var('grep', 'pattern_opt', [])
"   call denite#custom#var('grep', 'separator', [])
"   call denite#custom#var('grep', 'default_opts',
"       \ ['--vimgrep', '--hidden', '--ignore', '.git', '--ignore', '.min.js'])

"   autocmd FileType denite call s:denite_my_settings()
"   function! s:denite_my_settings() abort
"     nnoremap <silent><buffer><expr> <CR>
"     \ denite#do_map('do_action')
"     nnoremap <silent><buffer><expr> d
"     \ denite#do_map('do_action', 'delete')
"     nnoremap <silent><buffer><expr> p
"     \ denite#do_map('do_action', 'preview')
"     nnoremap <silent><buffer><expr> t
"     \ denite#do_map('do_action', 'tabopen')
"     nnoremap <silent><buffer><expr> v
"     \ denite#do_map('do_action', 'vsplit')
"     nnoremap <silent><buffer><expr> s
"     \ denite#do_map('do_action', 'split')
"     nnoremap <silent><buffer><expr> <ESC>
"     \ denite#do_map('quit')
"     nnoremap <silent><buffer><expr> i
"     \ denite#do_map('open_filter_buffer')
"     nnoremap <silent><buffer><expr> <Space>
"     \ denite#do_map('toggle_select').'j'
"   endfunction
" endfunction

" call coc#add_extension('coc-json', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-vetur', 'coc-pyls', 'coc-rls')

" call dein#set_hook('denite.nvim', 'hook_source', function('DeniteCustomize'))

filetype plugin indent on
colorscheme solarized
syntax enable
" NormalFloat for coc doc window
hi Normal ctermbg=None
" the default highlight reverse is readability disaster
hi NormalFloat cterm=none ctermfg=7 ctermbg=0
" search hilight reverse is unreadable in FZF ag output
hi Search cterm=None ctermfg=15 ctermbg=3

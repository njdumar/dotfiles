"--------------------------------vim settings----------------------------------
" This is neccessary for the colorscheme appearantly
filetype off
filetype plugin indent on

set dir=~/tmp,/var/tmp
set backupdir=~/tmp,~/
set undodir=~/tmp,~/

set colorcolumn=132

"set the editor to act like vim rather than vi
set nocompatible

"stop creating those annoying ~ files.
set nobackup

"auto tab and untab when using braces
set smarttab
"set autoindent

"so when you must backspace it deletes the correct character
set backspace=2

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"do incremental searching
set incsearch

"when you are in visual mode and you press > or < it will shift that many spaces
set shiftwidth=4

"display incomplete commands
set showcmd

"keep 50 lines of command line history
set history=50

"show the cursor position all the time
set ruler

"hide the mouse if you are typing
set mousehide

"In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

if !has('nvim')
    set ttymouse=sgr
endif

"do not wrap lines around
set nowrap

"necessary to turn tabs into spaces
set tabstop=4
set expandtab

"Search case insensitive
set ignorecase
set smartcase

set vb

set winfixwidth

"set the font
set guifont=DejaVu\ Sans\ Mono\ 11
"set guifont=ProggyCleanTT\ 15
"set guifont=Crisp\ 14

"show line numbers by default
set nonumber

" trailing whitespace will be shoen as +'s
set list lcs=trail:+,tab:\ \ 

" Turn off menubar
set guioptions-=m

" Turn off toolbar
set guioptions-=T

" Turn off scrollbar
set guioptions-=r
set guioptions-=b
set guioptions-=L

set tabpagemax=100

set foldmethod=manual

set clipboard+=unnamed

" Curson setting
highlight Cursor guibg=white guifg=black
highlight iCursor guibg=white guifg=black
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver25-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

set diffopt+=iwhite
set diffexpr=DiffW()

function! DiffW()
  let opt = ""
   if &diffopt =~ "icase"
     let opt = opt . "-i "
   endif
   if &diffopt =~ "iwhite"
     let opt = opt . "-w " " swapped vim's -b with -w
   endif
   silent execute "!diff -a --binary " . opt .
     \ v:fname_in . " " . v:fname_new .  " > " . v:fname_out
endfunction

" termdebug window options
let g:termdebug_popup = 0
let g:termdebug_wide = 163

" Vim packages
packadd termdebug

"------------------------------------------------
" Plug
"------------------------------------------------
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

"-----------------
" coc.nvim plugins
"-----------------
Plug 'neoclide/coc.nvim', {'branch': 'release',  'for': ['cpp', 'python', 'go', 'tcl', 'typescript', 'json']}

 " Really only for the :CclsCallHierarchy and :CclsDerivedHierarchy tool to get nice trees
Plug 'm-pilia/vim-ccls', {'for': ['cpp', 'python', 'go', 'tcl', 'typescript', 'json']}

 " Used for semantic highlighting
Plug 'jackguo380/vim-lsp-cxx-highlight', {'for': ['cpp', 'python', 'go', 'tcl', 'typescript', 'json']}

" Something like tagbar
Plug 'liuchengxu/vista.vim', {'for': ['cpp', 'python', 'go', 'tcl', 'typescript', 'json']}

" status line plugin
 Plug 'itchyny/lightline.vim'
"-----------------
" ^ coc.nvim plugins
"-----------------

Plug 'guns/xterm-color-table.vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'godlygeek/tabular'
Plug 'scrooloose/nerdtree'
Plug 'rking/ag.vim'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
Plug 'fatih/vim-go'
Plug 'aklt/plantuml-syntax'
Plug 'hdima/python-syntax'
Plug 'chrisbra/Colorizer'
Plug 'dkprice/vim-easygrep'
Plug 'christoomey/vim-tmux-navigator'
Plug 'arecarn/vim-crunch'
Plug 'airblade/vim-gitgutter'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Color schemes
Plug 'rakr/vim-one'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'Rigellute/shades-of-purple.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'joshdick/onedark.vim'
Plug 'bluz71/vim-nightfly-colors'
Plug 'rose-pine/neovim'
Plug 'EdenEast/nightfox.nvim'

"Plug 'vim-scripts/git-time-lapse'
"Plug 'kshenoy/vim-signature'

call plug#end()

" Set these now, required for the colorizer plugin setup
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

if has('nvim')
    lua require'colorizer'.setup()
endif

" vim-crunch calculator usage
"normal 	g={motion} 	Evaluate the text that {motion} moves over
"normal 	g== 	Evaluate the current line
"visual 	g= 	Evaluate the highlighted expressions

if isdirectory("~/dotfiles/notes")
    let g:notes_directories = ['~/dotfiles/notes']
endif

" Must ctrl-p for searchg for files cia fzf
map <C-p> :GFiles <Esc>

let python_highlight_all = 1

"----------------------------------------
" Golang settings
"----------------------------------------
let g:go_fmt_autosave = 1
let g:go_imports_autosave = 0
let g:go_term_mode = "split"
let g:go_term_enabled = 1

let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

let g:go_highlight_types = 1
let g:go_highlight_fields = 1

autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>i  <Plug>(go-install)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
au filetype go inoremap <buffer> . .<C-x><C-o>

"----------------------------------------
" Git Gutter (performance issues?)
"----------------------------------------
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

"------------------------------------------------------------------------------------------------------------
" coc.nvim
"------------------------------------------------------------------------------------------------------------
let g:coc_global_extensions = ['coc-json', 'coc-go', 'coc-pairs', 'coc-spell-checker', 'coc-yank', 'coc-pyright']

" For the coc-spell-checker
vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" For coc-yank
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<CR>

" CCLS specific settings
let g:ccls_size = 20
let g:ccls_orientation = 'horizontal'
let g:ccls_position = 'bot'

nmap <silent> gh :CclsCallHierarchy<CR>
nmap <silent> gc :CclsBaseHierarchy<CR>
nmap <silent> gm :CclsMemberHierarchy<CR>

nn <silent> xc :call CocLocations('ccls','$ccls/call', {'hierarchy':v:true})<cr>

let g:yggdrasil_no_default_maps = 1

" Use <space> to expand/collapse nodes in the trees
au FileType yggdrasil nmap <silent> <buffer> <space> <Plug>(yggdrasil-toggle-node)

" Use <cr> to jump to the line
au FileType yggdrasil nmap <silent> <buffer> <cr> <Plug>(yggdrasil-execute-node)


" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" lightline configurations
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'gitybranch', 'cocstatus', 'readonly', 'filename', 'modified', 'method' ] ]
\ },
\ 'component_function': {
\   'cocstatus': 'coc#status',
\   'method': 'NearestMethodOrFunction',
\   'gitybranch': 'FugitiveHead'
\ },
\ }

" Use autocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
"------------------------------------------------------------------------------------------------------------
" ^ coc.nvim
"------------------------------------------------------------------------------------------------------------

"-----------------------------------------------------------------------------
" Build tags recursively
"-----------------------------------------------------------------------------
set tags=./tags;/
function! Ctags()
    execute "!ctags -R ."
endfunction

"-----------------------------------------------------------------------------
" Color scheme
"-----------------------------------------------------------------------------
syntax enable

" Custom colorscheme and other vim configurations
if has('gui_running')
    set background=dark
    colorscheme natecolors
else
    set background=dark
    colorscheme natecolors
endif

"-----------------------------------------------------------------------------
" Random settings
"-----------------------------------------------------------------------------
let conceallevel=2
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2
let g:indentLine_enabled = 0
let g:indentLine_color_term = 236
let g:indentLine_color_gui = '#A4E57E'

" Remember where the cursor was when reopening a file
function! ResetCursor()
    if line("'\"") > 0 && line("'\"") <= line("$")
        exe "normal! g`\""
    endif
endfunction

au BufReadPost * call ResetCursor()

" prevent single line comments from being automatic, it's annoying
au FileType c,cpp setlocal comments-=:// comments+=f://
au FileType tcl setlocal comments-=:# comments+=f:#

"================== Completion Options ===============
set completeopt=longest,menuone,preview

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"-----------------------------------------------------------------------------
"---------------------------- Some Custom Stuff ------------------------------
"-----------------------------------------------------------------------------

" Setup tsv rules, we're making a screadsheet. If this is a new file, load the
" template, starting at line 0
au BufNewFile,BufRead,BufEnter *.tsv set ft=tsv
au BufNewFile *.tsv 0r ~/.vim/templates/template.tsv

au BufNewFile,BufRead *.chklst set ft=chklst
let g:checklist_use_timestamps = 0

au BufNewFile *.gnt 0r ~/.vim/bundle/ganttchart/templates/template.gnt

"-----------------------------------------------------------------------------
"---------------------------Vim Functions/Mappings-----------------------------
"-----------------------------------------------------------------------------

inoremap jj <ESC>

inoremap <M-n> :NERDTreeToggle<CR>
nnoremap <M-n> :NERDTreeToggle<CR>

vnoremap <M-a> :Ag <C-R>"<CR>

" Save files as sudo when I forget to start vim using sudo
cmap w!! w !sudo tee > /dev/null %

"c++, python, vimscript style comment
map ,/ :s/^/\/\//<CR> :/asdfasdf<CR>
map ,# :s/^/#/<CR> :/asdfasdf<CR>
map ," :s/^/"/<CR> :/asdfasdf<CR>
map ,% :s/^/%/<CR> :/asdfasdf<CR>

"c++, python, vimscript style uncomment
map ./ :s/\/\///<CR> :/asdfasdf<CR>
map .# :s/#//<CR> :/asdfasdf<CR>
map ." :s/"//<CR> :/asdfasdf<CR>
map .% :s/%//<CR> :/asdfasdf<CR>

" Move split window to new tab
noremap <C-t> <C-W>T

"CTRL-l/k/j/h moves to another window
noremap <C-l> <C-W>l
noremap <C-k> <C-W>k
noremap <C-j> <C-W>j
noremap <C-h> <C-W>h

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
            \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \gvy/<C-R><C-R>=substitute(
            \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
            \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \gvy?<C-R><C-R>=substitute(
            \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \gV:call setreg('"', old_reg, old_regtype)<CR>

map <C-i> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
          \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
          \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Fold everything not being serached for
nnoremap \z :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>

" Get the highlight group under the cursor
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
nnoremap <silent> <F3> :call SynGroup()<CR>

"========================= Function key Mappings ==========================

set autoread

map <F1> :term<CR>
map <F2> :NERDTreeToggle<CR>

nnoremap <F5> :redraw!<CR>

map <F8> :tabnew<CR>
map <C-F8> :tabclose<CR>
map <F9> :call SynGroup()<CR>

" Show highlight group for thing under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'. synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

map <F3> :CclsCallHierarchy<CR>
map <F4> :CclsDerivedHierarchy<CR>
map <F11> :Vista coc<CR>
map <F12> :call AddCclsProject()<CR>

" Needs to be at the end for git-gutter
highlight clear SignColumn

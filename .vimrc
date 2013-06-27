"--------------------------------Vim Settings----------------------------------
" This is neccessary for the colorscheme appearantly
filetype off
filetype plugin indent on

" Custom colorscheme and other vim configurations 
source ~/.vim/config/ide.vim
:colorscheme natecolors

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

"do not wrap lines around
set nowrap

"necessary to turn tabs into spaces
set tabstop=4
set expandtab

"Search case insensitive
set ignorecase

set vb

set winfixwidth

"set the font
set guifont=Monospace\ 9

"show line numbers by default
set number

set cursorline
set cursorcolumn

" This is required or used for Vundle
" To install configured bundles, :BundleInstall
" ------------- Vundle -------------------
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic'
Bundle 'majutsushi/tagbar.git'
Bundle 'gregsexton/MatchTag.git'
Bundle 'corntrace/bufexplorer.git'
Bundle 'mbbill/undotree'
Bundle 'guns/xterm-color-table.vim.git'

" ------------- General checks ------------------

if filereadable(glob("~/.vimrc_HITACHI.vim"))
    let work = "true"
    source ~/.vimrc_HITACHI.vim
else
    if filereadable($VIM . "/.vimrc_HITACHI.vim")
        let work = "true"
        source $VIM/.vimrc_HITACHI.vim
    else
        let work = "false"
    endif
endif

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
au BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif

" prevent single line comments from being automatic, it's annoying
au FileType c,cpp setlocal comments-=:// comments+=f://

"---------------------------- Load work functions ----------------------------
if work == "true"
    au Filetype c,cpp :call HighlightTypes()
    au BufRead trace*.txt :call EnableTraceSyntax()
    au BufRead etm*.txt :call EnableTraceSyntax()
    au BufRead *.etm :call EnableTraceSyntax()
    au BufRead *.fo :call HighlightCodeFo()
    au BufRead *.dis :call HighlightCodeDis()
    au BufRead *.*sym :call HighlightCodeSym()
endif

"---------------------------Vim Functions/Mappings-----------------------------
"These functions will work with Vim and GVim

" Command to recursively search through all source files begining in the
" folder you started vim in (use :pwd to figure that out if you don't know) 
" Use :copen to view and jump the the results
command -nargs=* DeepSearch grep! -rn --include={Makefile,*.{c,h,cpp,c++,php,inc,mk,h,hh,hpp,tcl,ipp,s,spp,dat,asm,bat,mak}} '<args>' .

"Vim only defaults to 3 matches so this is the syntax for the first 2
"highlight any extra white space green
"match ExtraWhitespace /\s\+$\| \+\ze\t/   This will highlight only white
"space at the end of a tab
"Highlight any characters above 80 places red

highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
let s:longlines = 1
function! Match_long_lines()
  if s:longlines == 1
    let s:longlines = 0
    :match ExtraWhitespace /\s\+$\|\t/
    :2match ErrorMsg '\%>132v.\+'
  else
    let s:longlines = 1
    :match
    :2match
  endif
endfunction

nnoremap <F3> :call Match_long_lines()<CR>
inoremap <F3> <Esc>:call Match_long_lines()<CR>a

" toggles highlights with searching
noremap <F4> :set hls!<CR>

" toggles binary mode
map <F5> :%!xxd<cr>a
map! <F5> <Esc>:%!xxd -r<cr>

" Open up a newtab
map <F7> :browse tabnew<CR>

"c++, python style comment
map ,/ :s/^/\/\//<CR> :/asdfasdf<CR>
map ,# :s/^/#/<CR> :/asdfasdf<CR>

"c++, python style uncomment
map ./ :s/\/\///<CR> :/asdfasdf<CR>
map .# :s/#//<CR> :/asdfasdf<CR>

" Easier to hit then ESC
inoremap qq <Esc>

"CTRL-l/k/j/h moves to another window
noremap <C-l> <C-W>l
noremap <C-k> <C-W>k
noremap <C-j> <C-W>j
noremap <C-h> <C-W>h

"Alt-Arrow is next(or previous tab
nnoremap <A-Right> :tabnext<CR>
nnoremap <A-Left>  :tabprevious<CR>
inoremap <A-Right> <ESC>:tabnext<CR>
inoremap <A-Left>  <ESC>:tabprevious<CR>

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
"Windows GVim settings

if has("gui_running")
  source ~/.vim/config/gui.vim
endif  "end of if has gui_running


"--------------------------------Vim Settings----------------------------------
" This is neccessary for the colorscheme appearantly
filetype off
filetype plugin indent on

" Custom colorscheme and other vim configurations 
:colorscheme natecolors
source ~/.vim/config/ide.vim

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

" trailing whitespace will be shoen as +'s 
set list lcs=trail:+

" Underline words inbetween underscores
" match MyUnderline /_.*_/

" This is required or used for Vundle
" To install configured bundles, :BundleInstall
" ------------- Vundle -------------------
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar.git'
Bundle 'gregsexton/MatchTag.git'
Bundle 'mbbill/undotree'
Bundle 'guns/xterm-color-table.vim.git'
Bundle 'airblade/vim-gitgutter.git'
Bundle 'tpope/vim-fugitive'
Bundle 'kshenoy/vim-signature'
Bundle 'vim-scripts/git-time-lapse'
Bundle 'vim-scripts/CCTree'
Bundle 'vim-scripts/taglist.vim'
Bundle 'vim-scripts/OmniCppComplete'
Bundle 'kien/ctrlp.vim'
Bundle 'godlygeek/tabular'

" ------------- General checks ------------------

if filereadable(glob("~/work.vim"))
    let work = "true"
    source ~/work.vim
else
    if filereadable($VIM . "/work.vim")
        let work = "true"
        source $VIM/work.vim
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

" Resource vimrc whenever it gets modified. However, it doesn't play well with
" highlightTypes() for some reason, so I'll fix it later.
" au! BufWritePost $MYVIMRC source $MYVIMRC

" Setup tsv rules, we're making a screadsheet. If this is a new file, load the
" template, starting at line 0
au BufNewFile,BufRead,BufEnter *.tsv set ft=tsv
au BufNewFile *.tsv 0r ~/.vim/templates/template.tsv

au BufNewFile,BufRead *.chklst set ft=chklst
let g:checklist_use_timestamps = 0

"---------------------------Vim Functions/Mappings-----------------------------
"These functions will work with Vim and GVim

" Command to recursively search through all source files begining in the
" folder you started vim in (use :pwd to figure that out if you don't know) 
" Use :copen to view and jump the the results
command -nargs=* DeepSearch grep! -rn --include={Makefile,*.{c,h,cpp,c++,php,inc,mk,h,hh,hpp,tcl,ipp,s,spp,dat,asm,bat,mak}} '<args>' .
command -nargs=* SearchReplace :!find . -regextype posix-extended -regex '.*\.(cpp|tcl|c|h|hh|hpp|asm|ipp|s|spp)' -exec sed -i '<args>' '{}' \; -print
command -nargs=* Shell :echo system('<args>')

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

" Opens of the buffer explorer
" noremap <F6> :BufExplorer<CR>

" Open up a newtab
map <F7> :browse tabnew<CR>

"c++, python, vimscript style comment
map ,/ :s/^/\/\//<CR> :/asdfasdf<CR>
map ,# :s/^/#/<CR> :/asdfasdf<CR>
map ," :s/^/"/<CR> :/asdfasdf<CR>

"c++, python, vimscript style uncomment
map ./ :s/\/\///<CR> :/asdfasdf<CR>
map .# :s/#//<CR> :/asdfasdf<CR>
map ." :s/"//<CR> :/asdfasdf<CR>

" Easier to hit then ESC
inoremap qq <Esc>

" Setup CtrlP for opening files
map <C-p> :CtrlP <Esc>

"CTRL-l/k/j/h moves to another window
noremap <C-l> <C-W>l
noremap <C-k> <C-W>k
noremap <C-j> <C-W>j
noremap <C-h> <C-W>h

"CTRL-Arrow is next(or previous tab
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-Left>  :tabprevious<CR>
inoremap <C-Right> <ESC>:tabnext<CR>
inoremap <C-Left>  <ESC>:tabprevious<CR>

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

"define 3 custom highlight groups
hi User1 ctermbg=gray ctermfg=black   guibg=gray guifg=black
hi User2 ctermbg=gray   ctermfg=56  guibg=gray   guifg=darkblue
hi User3 ctermbg=blue  ctermfg=green guibg=blue  guifg=green

set statusline=%1*     "switch to user1 colors
set statusline+=%f       "tail of the filename
set statusline+=%m      "modified flag
set statusline+=\ [%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%r      "read only flag
set statusline+=%2*     "switch to user2 colors
set statusline+=\ %{fugitive#statusline()}
set statusline+=%1*     "switch to user1 colors
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

" Create a Checklist like feature
function! HighlightPlusMinus ()

    highlight Plus ctermfg=green
    highlight Minus ctermfg=red
    syn match Minus /^- / skipwhite
    syn match Plus  /^+ / skipwhite

endfunction

function! ToggleItem ()
    " Define variables
    let current_line = getline('.')
    let l:line = getline(line(".") - 1)

  " Toggle Folds
    if match(current_line,'^- ') >= 0
       exe 's/\V- /+ /i'
   elseif match(current_line,'^+ ') >= 0
        exe 's/\V+ //i'
    else
        exe 's/\V/- /i'
    endif

    call HighlightPlusMinus()

    return ""
endfunction

noremap <F2> :call ToggleItem()<CR><End>
au BufRead *.* :call HighlightPlusMinus()

highlight Plus ctermfg=green
highlight Minus ctermfg=red
syn match Minus /^- / skipwhite
syn match Plus  /^+ / skipwhite

"Windows GVim settings
if has("gui_running")
    source ~/.vim/config/gui.vim
endif  "end of if has gui_running

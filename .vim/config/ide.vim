"========================= Mappings ==========================

" Create the project. This creates the ctags and cscope files 
" needed by everything
"map <F8> :cs kill -1<CR>
"        \:!~/dotfiles/start_project.sh `pwd` <CR> 
"        \:cs add cscope.out<CR> 

map <F6> :call TimeLapse()<CR>

"map <F8> :cs kill -1<CR>
"        \:!rm tags<CR>
"        \:!rm cscope.*<CR>
"        \:!echo "Find Files"<CR>
"        \:!find . -regextype posix-extended -regex '.*\.(cpp\|tcl\|c\|h\|hh\|hpp\|asm\|ipp\|s\|spp)' > cscope.files<CR>
"        \:!echo "Run ctags"<CR>
"        \:!ctags -f `pwd`/tags -a -h \".php.inc\" -L cscope.files -I --totals=yes --tag-relative=yes --PHP-kinds=+cf --python-kinds=+i --c++-kinds=+p --extra=+q  --fields=+liaS --language-force=C++<CR>
"        \:!echo "Run cscope"<CR>
"        \:!cscope -b -i cscope.files -f cscope.out<CR>
"        \:cs add cscope.out<CR>

map <F8> :Shell echo "Find Files";
        \find . -regextype posix-extended -regex '.*\.(cpp\|tcl\|c\|h\|hh\|hpp\|asm\|ipp\|s\|spp)' > cscope.files;
        \echo "Run ctags";
        \ctags -f `pwd`/tags -L cscope.files -I --totals=yes
                            \--tag-relative=yes --PHP-kinds=+cf
                            \--python-kinds=+i --c++-kinds=+p
                            \--extra=+q  --fields=+liaS --language-force=C++;
        \echo "Run cscope";
        \cscope -b -i cscope.files -f cscope.out;
        \echo "Reset csope db connection"; sleep 1;
        \vim --servername IDE --remote-send ":cs reset"<CR><CR>

let g:NERDTreeWinSize = 25
map <F9> :NERDTreeToggle<CR>

let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_WinWidth = 30
map <F10> :TlistToggle \| :silent NERDTreeMirror<CR>

let g:tagbar_left = 1
map <F11> :TagbarToggle <CR>

"========================= PluginColors ==========================

" Turn off the column highlighting for the vim-gitgutter plugin
highlight clear SignColumn

"=================== Clang/SuperTab =========================

set completeopt=longest,menuone

" Set the behavior of SuperTab to always use clang complete
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:SuperTabContextDiscoverDiscovery =
    \ ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]

" SuperTab option for context aware completion
let g:SuperTabDefaultCompletionType = "context"
let g:SuperSetTabDefaultCompletionType = "<c-x><c-u>"

" Disable auto popup, use <Tab> to autocomplete
let g:clang_complete_auto = 0

" Turn off automatically selecting the first entry in the popup menu
let g:clang_auto_select =  0
let g:SuperTabLongestHighlight = 0

" Show clang errors in the quickfix window
let g:clang_complete_copen = 1

let g:clang_snippets=1
let g:clang_conceal_snippets=1

"The single one that works with clang_complete
let g:clang_snippets_engine='clang_complete'

" used for clang_index (excplisy clang-complete fork)
"let g:clang_user_options=""
"let g:clang_auto_user_options="path, .clang_complete"
"let g:clang_use_library=1
"let g:clang_library_path="/usr/lib/"
"let g:clang_sort_algo="priority"
"let g:clang_complete_macros=1
"let g:clang_complete_patterns=0
"nnoremap <Leader>q :call g:ClangUpdateQuickFix()<CR>
"
"let g:clic_filename="/home/dumarn/work/Checkouts/git/index/index.db"
"nnoremap <Leader>r :call ClangGetReferences()<CR>
"nnoremap <Leader>d :call ClangGetDeclarations()<CR>
"nnoremap <Leader>s :call ClangGetSubclasses()<CR>

"========================= YCM ===============================

" This is the default, I just put it here for my own reference
" I'm not actually using YCM for its clang complete, it's just too 
" much of a pain in the ass to get working correctly for large, complex code
"let g:ycm_semantic_triggers =  {
"  \   'c' : ['->', '.'],
"  \   'objc' : ['->', '.'],
"  \   'ocaml' : ['.', '#'],
"  \   'cpp,objcpp,ipp' : ['->', '.', '::'],
"  \   'perl' : ['->'],
"  \   'php' : ['->', '::'],
"  \   'cs,java,javascript,d,vim,python,perl6,scala,vb,elixir,go' : ['.'],
"  \   'ruby' : ['.', '::'],
"  \   'lua' : ['.', ':'],
"  \   'erlang' : [':'],
"  \ }
"let g:ycm_min_num_of_chars_for_completion = 1
"let g:ycm_confirm_extra_conf = 0
"let g:ycm_collect_identifiers_from_tags_files = 1

"=================== OmniCppComplete =========================

"set omnifunc=syntaxcomplete#Complete " override built-in C omnicomplete with C++ OmniCppComplete plugin
"let OmniCpp_GlobalScopeSearch   = 1
"let OmniCpp_DisplayMode         = 1
"let OmniCpp_ShowScopeInAbbr     = 0 "do not show namespace in pop-up
"let OmniCpp_ShowPrototypeInAbbr = 1 "show prototype in pop-up
"let OmniCpp_ShowAccess          = 1 "show access in pop-up
"let OmniCpp_SelectFirstItem     = 0 "do not select first item in pop-up
"set completeopt=menuone,menu,longest
"au BufNewFile,BufRead,BufEnter *.cpp,*.hpp,*.ipp set omnifunc=omni#cpp#complete#Main

"=================== NeoComplete =========================
"
"" Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
"
"" Disable Auto select
"let g:neocomplete#enable_auto_select = 0
"
"" Use neocomplete.
"let g:neocomplete#enable_at_startup = 1
"
"" Use smartcase.
"let g:neocomplete#enable_smart_case = 1
"
"" Set minimum syntax keyword length.
"let g:neocomplete#sources#syntax#min_keyword_length = 3
"let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
"
"" Define dictionary.
"let g:neocomplete#sources#dictionary#dictionaries = {
"    \ 'default' : '',
"    \ 'vimshell' : $HOME.'/.vimshell_hist',
"    \ 'scheme' : $HOME.'/.gosh_completions'
"        \ }
"
"" Define keyword.
"if !exists('g:neocomplete#keyword_patterns')
"    let g:neocomplete#keyword_patterns = {}
"endif
"let g:neocomplete#keyword_patterns['default'] = '\h\w*'
"
"" Plugin key-mappings.
"inoremap <expr><C-g>     neocomplete#undo_completion()
"inoremap <expr><C-l>     neocomplete#complete_common_string()
"
"if !exists('g:neocomplete#force_omni_input_patterns')
"    let g:neocomplete#force_omni_input_patterns = {}
"endif
"let g:neocomplete#force_overwrite_completefunc = 1
""let g:neocomplete#force_omni_input_patterns.c =
""            \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
""let g:neocomplete#force_omni_input_patterns.cpp =
""            \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
""let g:neocomplete#force_omni_input_patterns.objc =
""            \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
""let g:neocomplete#force_omni_input_patterns.objcpp =
""            \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
"let g:clang_use_library = 1
"
"========================= cTags =============================

"set the tags file
set tags=./tags;/

"========================= cScope =============================
"
" This file contains some boilerplate settings for vim's cscope interface,
" plus some keyboard mappings that I've found useful.
"
" USAGE:
" -- vim 6:     Stick this file in your ~/.vim/plugin directory (or in a
"               'plugin' directory in some other directory that is in your
"               'runtimepath'.
"
" -- vim 5:     Stick this file somewhere and 'source cscope.vim' it from
"               your ~/.vimrc file (or cut and paste it into your .vimrc).
"
" NOTE:
" These key maps use multiple keystrokes (2 or 3 keys).  If you find that vim
" keeps timing you out before you can complete them, try changing your timeout
" settings, as explained below.
"
" Happy cscoping,
"
" Jason Duell       jduell@alumni.princeton.edu     2002/3/7
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim...
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    "set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs kill -1
        cs add cscope.out
    " else add the database pointed to by environment variable
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose


    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "
    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
    " unlikely that you need their default mappings (CTRL-\'s default use is
    " as part of CTRL-\ CTRL-N typemap, which basically just does the same
    " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
    " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
    " of these maps to use other keys.  One likely candidate is 'CTRL-_'
    " (which also maps to CTRL-/, which is easier to type).  By default it is
    " used to switch between Hebrew and English keyboard mode.
    "
    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).


    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.
    "

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>


    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>

    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>


    " Hitting CTRL-space *twice* before the search type does a vertical
    " split instead of a horizontal one (vim 6 and up only)
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left

    nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

endif

" Create the cells
set noexpandtab
set shiftwidth=25
set softtabstop=25
set tabstop=25
set list lcs=tab:__

set nocursorline
set nocursorcolumn

highlight LineNr    cterm=bold guifg=darkred  ctermfg=darkred
" Make the contents of the cells underlined and color it white
" match Underlined /|.*|/
" highlight Underlined guifg=gray ctermfg=gray

highlight FirstLine cterm=bold ctermfg=darkred
match FirstLine /\%1l/

map <F2> :r ~/.vim/templates/template.tsv<CR>
inoremap <F2> <Esc> :r ~/.vim/templates/template.tsv<CR>


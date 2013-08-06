" Create the cells
set noexpandtab
set shiftwidth=25
set softtabstop=25
set tabstop=25
set list lcs=tab:__

highlight LineNr    guifg=darkred  ctermfg=darkred

" Highlight the first line red and underlined, the rest of the cells can have
" whatever characters they have underlined, but not the tab. Underlining the
" entire cell looks bad with such a smallish font
highlight FirstLine cterm=bold cterm=underline ctermfg=darkred
match FirstLine /\%1l|.*|/

highlight TheRest cterm=underline
2match TheRest /\%>1l|[a-zA-Z0-9(){}\-_!@#$%^&*\[\]:;"'<,>.?\/+= ]*/

map <F2> :r ~/.vim/templates/template.tsv<CR>
inoremap <F2> <Esc> :r ~/.vim/templates/template.tsv<CR>


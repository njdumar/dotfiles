" Tips:
" Color test
"      :so $VIMRUNTIME/syntax/hitest.vim
" Show highlight group for thing under cursor
"      :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'. synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"
" Tree-Sitter playground
"      :TSHighlightCapturesUnderCursor
" LSP
"      :LspCxxHlCursorSym

let s:italic = "italic"
let s:bold = "bold"

function! s:hi(group, fg, bg, attr, attrsp)
  if !empty(a:fg)
    exec "hi " . a:group . " guifg=" .  a:fg[0]
    exec "hi " . a:group . " ctermfg=" . a:fg[1]
  endif
  if !empty(a:bg)
    exec "hi " . a:group . " guibg=" .  a:bg[0]
    exec "hi " . a:group . " ctermbg=" . a:bg[1]
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" .   a:attr
    exec "hi " . a:group . " cterm=" . a:attr
  endif
  if !empty(a:attrsp)
    exec "hi " . a:group . " guisp=" . a:attrsp[0]
  endif
endfunction

"------------------------Color Scheme Settings----------------------------
syn region Comment start=/"""/ end=/"""/

set background=dark

if !exists("g:syntax_on")
    syntax enable
endif

"Set the number of terminal colors to 256, this will work on most systems
set t_Co=256

" Colors {{{
let s:none   = ['NONE', 'NONE']
let s:white  = ['#ffffff', '15']
let s:black  = ['#000000', '0']
let s:base   = ['#121212', '233']
let s:base00 = ['#1b2b34', '235']
let s:base10 = ['#262626', '235']
let s:base01 = ['#343d46', '237']
let s:base02 = ['#4f5b66', '240']
let s:base03 = ['#65737e', '243']
let s:base04 = ['#808080', 'gray']
let s:base05 = ['#a7adba', '145']
let s:base06 = ['#c0c5ce', '251']
let s:base07 = ['#cdd3de', '252']
let s:base08 = ['#d8dee9', '253']

let s:cyan    = ['#62b3b2', '73']
let s:blue    = ['#6699cc', '68']
let s:orange  = ['#f99157', '209']
let s:brown   = ['#dfaf87', '180']
let s:yellow0 = ['#DFDF5F', '185']
let s:yellow1 = ['#fac863', '221']
let s:green0  = ['#5faf5f', '71']
let s:green1  = ['#99c794', '114']
let s:red0    = ['#d75f5f', '167']
let s:red1    = ['#af5f5f', '131']
let s:purple0 = ['#c594c5', '176']
let s:purple1 = ['#5f5faf', '61'] " old comments"
let s:purple2 = ['#AF87FF', '141']
let s:purple3 = ['#af5fff', '135']
let s:purple4 = ['#ff87ff', '213']
let s:purple5 = ['#ff00af', '199']
" }}}

" Vim {{{
call s:hi('Bold',              '',         '',         s:bold,       '')
call s:hi('Italic',            '',         '',         s:italic,     '')
call s:hi('Normal',            s:base04,   s:base,     '',           '')
call s:hi('Visual',            s:none,     s:none,     'standout',   '')

call s:hi('Comment',           s:base03,   '',         s:italic,     '')
call s:hi('Constant',          s:white,    '',         '',           '')
call s:hi('Function',          s:cyan,    '',         '',           '')
call s:hi('Identifier',        s:base04,   '',         s:italic,     '')
call s:hi('PreProc',           s:yellow0,  '',         '',           '')
call s:hi('Question',          s:green0,   '',         '',           '')
call s:hi('Statement',         s:red0,     '',         '',           '')
call s:hi('Type',              s:green0,   '',         '',           '')

call s:hi('Braces',            s:red1,     '',         '',           '')
call s:hi('Directory',         s:purple1,  '',         '',           '')
call s:hi('Folded',            s:purple1,  s:none,     '',           '')
call s:hi('FoldColumn',        s:purple1,  s:none,     '',           '')
call s:hi('LineNr',            s:base05,   '',         '',           '')
call s:hi('NonText',           s:purple2,  '',         '',           '')
call s:hi('Search',            s:none,     s:none,     'standout',   '')
call s:hi('Special',           s:red1,     '',         '',           '')
call s:hi('SpecialKey',        s:cyan,    '',         '',           '')
call s:hi('Todo',              s:black,    s:yellow0,  '',           '')
call s:hi('Title',             s:purple5,  '',         '',           '')
call s:hi('VertSplit',         s:base04,   s:base,     '',           '')

call s:hi('Debug',             s:red0,     '',         '',           '')
call s:hi('ErrorMsg',          s:red0,     s:none,     '',           '')
call s:hi('Exception',         s:red0,     '',         '',           '')
call s:hi('LineTooLong',       '',         '',         '',           '')
call s:hi('WarningMsg',        s:orange,   s:none,     '',           '')

call s:hi('colorcolumn',       '',         s:base00,   '',           '')
call s:hi('Conceal',           s:blue,     s:none,     '',           '')
call s:hi('Cursor',            '',         '',         '',           '')
call s:hi('CursorLine',        '',         s:base00,   '',           '')
call s:hi('CursorColumn',      '',         s:base00,   '',           '')
call s:hi('CursorLineNr',      s:purple4,  '',         '',           '')
call s:hi('MatchParen',        s:none,     s:none,     '',           '')
call s:hi('PMenu',             s:black,    s:purple4,  '',           '')
call s:hi('PMenuSel',          s:black,    s:base04,   '',           '')
call s:hi('PMenuSbar',         s:black,    s:base04,   '',           '')
call s:hi('PmenuThumb',        '',         '',         '',           '')
call s:hi('StatusLine',        s:black,    s:green0,   '',           '')
call s:hi('StatusLineNC',      s:black,    s:green0,   '',           '')
call s:hi('StatusLineTerm',    s:black,    s:green0,   '',           '')
call s:hi('StatusLineTermNC',  s:black,    s:green0,   '',           '')
call s:hi('TabLine',           s:black,    s:base04,   '',           '')
call s:hi('TabLineFill',       s:black,    s:base04,   '',           '')
call s:hi('TabLineSel',        s:purple5,  s:base10,   '',           '')
call s:hi('ToolbarLine',       s:none,     s:none,     '',           '')
call s:hi('ToolbarButton',     s:none,     s:none,     '',           '')
call s:hi('WildMenu',          s:black,    s:purple4,  '',           '')

call s:hi('DiffAdd',           s:green1,   s:none,     '',           '')
call s:hi('DiffAdded',         s:green1,   s:none,     '',           '')
call s:hi('DiffChange',        s:blue,     s:none,     '',           '')
call s:hi('DiffDelete',        s:red1,     s:none,     '',           '')
call s:hi('DiffFile',          s:red1,     s:none,     '',           '')
call s:hi('DiffLine',          s:blue,     s:none,     '',           '')
call s:hi('DiffNewFile',       s:green1,   s:none,     '',           '')
call s:hi('DiffRemoved',       s:red1,     s:none,     '',           '')
call s:hi('DiffText',          '',         s:none,     '',           '')

call s:hi('IncSearch',         '',         '',         '',           '')
call s:hi('FoldedColumn',      '',         '',         '',           '')

call s:hi('SpellBad',          s:none,     s:none,     'undercurl',  '')
call s:hi('SpellCap',          s:none,     s:none,     'undercurl',  '')
call s:hi('SpellLocal',        s:none,     s:none,     'undercurl',  '')
call s:hi('SpellRare',         s:none,     s:none,     'undercurl',  '')

call s:hi('debugBreakpoint',           s:black,    s:red0,      '',        '')
call s:hi('debugBreakpointDisabled',   s:black,    s:red0,      '',        '')

call s:hi('vimUsrCmd',    s:red0,     '',  '',  '')
call s:hi('vimVar',       s:purple0,  '',  '',  '')
call s:hi('vimMapLhs',    s:purple0,  '',  '',  '')
call s:hi('vimMapRhs',    '',         '',  '',  '')
call s:hi('vimSetEqual',  s:red0,     '',  '',  '')
" }}}

" Random Plugins {{{
" GitGutter
call s:hi('GitGutterAdd',           s:green0,   '',  '',  '')
call s:hi('GitGutterChange',        s:yellow1,  '',  '',  '')
call s:hi('GitGutterDelete',        s:red0,     '',  '',  '')

" Coc
call s:hi('CocErrorSign',           s:red0,     '',  '',  '')
call s:hi('CocWarningSign',         s:yellow0,  '',  '',  '')
call s:hi('CocInfoSign',            s:blue,     '',  '',  '')
call s:hi('CocHintSign',            s:cyan,    '',  '',  '')
call s:hi('CocErrorFloat',          s:red0,     '',  '',  '')
call s:hi('CocWarningFloat',        s:yellow0,  '',  '',  '')
call s:hi('CocInfoFloat',           s:blue,     '',  '',  '')
call s:hi('CocHintFloat',           s:cyan,    '',  '',  '')
call s:hi('CocDiagnosticsError',    s:red0,     '',  '',  '')
call s:hi('CocDiagnosticsWarning',  s:yellow0,  '',  '',  '')
call s:hi('CocDiagnosticsInfo',     s:blue,     '',  '',  '')
call s:hi('CocDiagnosticsHint',     s:cyan,    '',  '',  '')
call s:hi('CocSelectedText',        s:purple0,  '',  '',  '')
call s:hi('CocCodeLens',            s:base04,   '',  '',  '')
" }}}

" LSP {{{
call s:hi('DiagnosticOK',                       s:green0,   '',        '',           '')
call s:hi('DiagnosticUnderlineOK',              s:green0,   '',        'undercurl',  '')
call s:hi('DiagnosticWarn',                     s:yellow1,  '',        '',           '')
call s:hi('DiagnosticUnderlineWarn',            s:yellow1,  '',        'undercurl',  '')
call s:hi('DiagnosticError',                    s:red0,     '',        '',           '')
call s:hi('DiagnosticUnderlineError',           s:red0,     '',        'undercurl',  '')
call s:hi('DiagnosticInfo',                     s:blue,     '',        '',           '')
call s:hi('DiagnosticUnderlineInfo',            s:blue,     '',        'undercurl',  '')
call s:hi('DiagnosticHint',                     s:base08,   '',        '',           '')
call s:hi('DiagnosticUnderlineHint',            s:base08,   '',        'undercurl',  '')
call s:hi('DiagnosticDeprecated',               s:orange,   '',        '',           '')

call s:hi('LspReferenceText',                   '',         s:base01,  '',           '')
call s:hi('LspReferenceRead',                   '',         s:base01,  '',           '')
call s:hi('LspReferenceWrite',                  '',         s:base01,  '',           '')
call s:hi('FloatBorder',                        s:base04,   '',        '',           '')
call s:hi('IndentBlanklineChar',                s:base01,   '',        'nocombine',  '')
call s:hi('IndentBlanklineSpaceChar',           s:base01,   '',        'nocombine',  '')
call s:hi('IndentBlanklineSpaceCharBlankline',  s:base01,   '',        'nocombine',  '')

" Class Member variables
call s:hi('LspCxxHlGroupMemberVariable',        s:purple2,  '',        '',           '')
call s:hi('LspCxxHlGroupMemberStatic',          s:purple2,  '',        '',           '')
call s:hi('LspCxxHlGroupMemberConstant',        s:purple2,  '',        '',           '')
" Statics do not get assigned a group correctly, for whatever reason. However,
" other types are already covered, so this is all that's left
call s:hi('LspCxxHlSymUnknownVariableStatic',  s:purple2,  '',      '',        '')

" c++ function variables/constants:
call s:hi('LspCxxHlSymMethodVariable',         s:base04,   s:base,  '',        '')
call s:hi('LspCxxHlSymMethodConstant',         s:base04,   s:base,  '',        '')
call s:hi('LspCxxHlSymFunctionVariable',       s:base04,   s:base,  '',        '')
call s:hi('LspCxxHlSymFunctionConstant',       s:base04,   s:base,  '',        '')

" Enums
call s:hi('LspCxxHlGroupEnumConstant',         s:brown,   '',      '',        '')
call s:hi('LspCxxHlSymEnumMember',             s:brown,   '',      '',        '')

" Namespaces
call s:hi('LspCxxHlGroupNamespace',            s:purple3,  '',      '',        '')
call s:hi('LspCxxHlSymNamespace',              s:purple3,  '',      '',        '')
call s:hi('LspCxxHlSymNamespaceVariable',      s:purple2,  '',      '',        '')
call s:hi('LspCxxHlSymNamespaceConstant',      s:purple2,  '',      '',        '')
call s:hi('LspCxxHlSymNamespaceStatic',        s:purple2,  '',      '',        '')
call s:hi('LspCxxHlSymNamespaceFunction',      s:purple2,  '',      '',        '')

call s:hi('LspCxxHlSymFileVariable',           s:purple4,  '',      s:italic,  '')
call s:hi('LspCxxHlSymFileStatic',             s:purple4,  '',      s:italic,  '')
call s:hi('LspCxxHlSymFileConstant',           s:purple4,  '',      s:italic,  '')
call s:hi('LspCxxHlSymFileFunction',           s:purple4,  '',      s:italic,  '')
" }}}

" NVIM and Tree-Sitter {{{
if has('nvim')
    call s:hi('RedrawDebugNormal',      s:black,    s:base04,   '',        '')
    call s:hi('RedrawDebugClear',       s:black,    s:yellow0,  '',        '')
    call s:hi('RedrawDebugComposed',    s:black,    s:green1,   '',        '')
    call s:hi('RedrawDebugRecompose',   s:black,    s:red0,     '',        '')

    call s:hi('NvimInternalError',      s:black,    s:red0,     '',        '')

    call s:hi('@comment',               s:base03,   '',         s:italic,  '')
    call s:hi('@string.documentation',  s:base03,   '',         s:italic,  '')
    call s:hi('@variable.builtin',      s:red0,     '',         '',        '')
    call s:hi('@function',              s:blue,     '',         '',        '')
    call s:hi('@constructor',           s:blue,     '',         '',        '')
    call s:hi('@method',                s:blue,     '',         '',        '')
    call s:hi('@type',                  s:green0,   '',         '',        '')

    call s:hi('@constant',              s:purple4,  '',         '',        '')
    call s:hi('@number',                s:white,    '',         '',        '')
    call s:hi('@string',                s:white,    '',         '',        '')
    call s:hi('@constant.builtin',      s:white,    '',         s:bold,    '')
    call s:hi('@variable',              s:purple0,  '',         '',        '')
    call s:hi('@parameter',             s:purple0,  '',         '',        '')
    call s:hi('@property',              s:purple0,  '',         '',        '')
    call s:hi('@field',                 s:purple2,  '',         '',        '')
    call s:hi('@namespace',             s:purple3,  '',         '',        '')

    call s:hi('@include',               s:yellow0,  '',         '',        '')
    call s:hi('@keyword',               s:red1,     '',         s:bold,    '')
    call s:hi('@operator',              s:red1,     '',         '',        '')
    call s:hi('@punctuation',           s:red1,     '',         '',        '')
    call s:hi('@repeat',                s:red1,     '',         '',        '')
    call s:hi('@symbol',                s:green0,   '',         '',        '')
    call s:hi('@exception',             s:red0,     '',         '',        '')
endif
" }}}

" TODO Others {{{
" xml
" TeX
" Perl
" markdown
" go
"
"call s:hi('Macro',         '',  '',            '',  '')
"call s:hi('ModeMsg',       '',  '',            '',  '')
"call s:hi('MoreMsg',       '',  '',            '',  '')
"call s:hi('TooLong',       '',  '',            '',  '')
"call s:hi('Underlined',    '',  '',            '',  '')
"call s:hi('VisualNOS',     '',  '',            '',  '')
"call s:hi('EndOfBuffer',   '',  '',            '',  '')
"call s:hi('SignColumn',    '',  '',            '',  '')
"call s:hi('helpExample',   '',  '',            '',  '')
"call s:hi('helpCommand',   '',  '',            '',  '')

"call s:hi('csClass',                 '',  '',  '',  '')
"call s:hi('csAttribute',             '',  '',  '',  '')
"call s:hi('csModifier',              '',  '',  '',  '')
"call s:hi('csType',                  '',  '',  '',  '')
"call s:hi('csUnspecifiedStatement',  '',  '',  '',  '')
"call s:hi('csContextualStatement',   '',  '',  '',  '')
"call s:hi('csNewDecleration',        '',  '',  '',  '')
"call s:hi('cOperator',               '',  '',  '',  '')
"call s:hi('cPreCondit',              '',  '',  '',  '')
"
"call s:hi('cssColor',                '',  '',  '',  '')
"call s:hi('cssBraces',               '',  '',  '',  '')
"call s:hi('cssClassName',            '',  '',  '',  '')

"call s:hi('gitCommitOverflow',                 red,    '',       '',          '')
"call s:hi('gitCommitSummary',                  green,  '',       '',          '')
"
"call s:hi('htmlBold',                          yellow, '',       '',          '')
"call s:hi('htmlItalic',                        purple, '',       '',          '')
"call s:hi('htmlTag',                           cyan,   '',       '',          '')
"call s:hi('htmlEndTag',                        cyan,   '',       '',          '')
"call s:hi('htmlArg',                           yellow, '',       '',          '')
"call s:hi('htmlTagName',                       base07, '',       '',          '')
"
"call s:hi('javaScript',                        base05, '',       '',          '')
"call s:hi('javaScriptNumber',                  orange, '',       '',          '')
"call s:hi('javaScriptBraces',                  base05, '',       '',          '')
"
"call s:hi('jsonKeyword',                       green,  '',       '',          '')
"call s:hi('jsonQuote',                         green,  '',       '',          '')
"
"call s:hi('markdownCode',                      green,  '',       '',          '')
"call s:hi('markdownCodeBlock',                 green,  '',       '',          '')
"call s:hi('markdownHeadingDelimiter',          blue,   '',       '',          '')
"call s:hi('markdownItalic',                    purple, '',       s:italic,    '')
"call s:hi('markdownBold',                      yellow, '',       s:bold,      '')
"call s:hi('markdownCodeDelimiter',             brown,  '',       s:italic,    '')
"call s:hi('markdownError',                     base05, base00, '',          '')
"
"call s:hi('typescriptParens',                  base05, none,   '',          '')
"
"call s:hi('NeomakeErrorSign',                  red,    base00, '',          '')
"call s:hi('NeomakeWarningSign',                yellow, base00, '',          '')
"call s:hi('NeomakeInfoSign',                   white,  base00, '',          '')
"call s:hi('NeomakeError',                      red,    '',       'underline', red)
"call s:hi('NeomakeWarning',                    red,    '',       'underline', red)
"
"call s:hi('ALEErrorSign',                      red,    base00, s:bold,      '')
"call s:hi('ALEWarningSign',                    yellow, base00, s:bold,      '')
"call s:hi('ALEInfoSign',                       white,  base00, s:bold,      '')
"
"call s:hi('NERDTreeExecFile',                  base05, '',       '',          '')
"call s:hi('NERDTreeDirSlash',                  blue,   '',       '',          '')
"call s:hi('NERDTreeOpenable',                  blue,   '',       '',          '')
"call s:hi('NERDTreeFile',                      '',       none,   '',          '')
"call s:hi('NERDTreeFlags',                     blue,   '',       '',          '')
"
"call s:hi('YanilTreeFile',                     '',       none,   '',          '')
"
"call s:hi('phpComparison',                     base05, '',       '',          '')
"call s:hi('phpParent',                         base05, '',       '',          '')
"call s:hi('phpMemberSelector',                 base05, '',       '',          '')
"
"call s:hi('pythonRepeat',                      purple, '',       '',          '')
"call s:hi('pythonOperator',                    purple, '',       '',          '')
"
"call s:hi('rubyConstant',                      yellow, '',       '',          '')
"call s:hi('rubySymbol',                        green,  '',       '',          '')
"call s:hi('rubyAttribute',                     blue,   '',       '',          '')
"call s:hi('rubyInterpolation',                 green,  '',       '',          '')
"call s:hi('rubyInterpolationDelimiter',        brown,  '',       '',          '')
"call s:hi('rubyStringDelimiter',               green,  '',       '',          '')
"call s:hi('rubyRegexp',                        cyan,   '',       '',          '')
"
"call s:hi('sassidChar',                        red,    '',       '',          '')
"call s:hi('sassClassChar',                     orange, '',       '',          '')
"call s:hi('sassInclude',                       purple, '',       '',          '')
"call s:hi('sassMixing',                        purple, '',       '',          '')
"call s:hi('sassMixinName',                     blue,   '',       '',          '')
"
"call s:hi('vimfilerLeaf',                      base05, '',       '',          '')
"call s:hi('vimfilerNormalFile',                base05, base00, '',          '')
"call s:hi('vimfilerOpenedFile',                blue,   '',       '',          '')
"call s:hi('vimfilerClosedFile',                blue,   '',       '',          '')

" }}}

" Custom regex {{{
"--------------------------------------------------------------------------------------------------
" nvim has tree-sitter, which takes care of the following
if !has('nvim')
    au BufReadPost * syn match OperatorChars "?\|+\|-\|\*\|;\|:\|,\|<\|>\|&\||\|!\|\~\|%\|=\|)\|(\|{\|}\|\.\|\[\|\]\|/\(/\|*\)\@!"
    au BufReadPost * syn match Braces          "[(){}\[\]]"
    au BufReadPost * syn match cCustomParen    "("
    au BufReadPost * syn match cCustomScope    "::"
    au BufReadPost * syn match cCustomScope2   "\."
    au BufReadPost * syn match cCustomFunc     "\w\+\s*(" contains=cCustomParen
    au BufReadPost * syn match cCustomNamespace "\(\w\+\s*::\)\+" contains=cCustomScope

    " The following can be annoying when looking at files that are not source code
    " classes or structs using a member variable
    au BufReadPost *.cpp,*.hh,*.hpp,*.ipp,*.tpp,*.go,*.py syn match cCustomClass "\(\<\w\+\>\.\)\+" contains=cCustomScope2

    " The member variable of a class or struct (not a member function)
    au BufReadPost *.cpp,*.hh,*.hpp,*.ipp,*.tpp,*.go,*.py syn match cCustomMember "\(\<\w\+\>\.\)\+\<\w\+\>[([<]\@!" contains=cCustomClass

    " Variable defined in a namespace (not a function function)
    au BufReadPost *.cpp,*.hh,*.hpp,*.ipp,*.tpp,*.go,*.py syn match cCustomNamespaceMember "\(\w\+\s*::\)\+\<\w\+\>[([<]\@!" contains=cCustomNamespace

    " Try to find macros
    au BufReadPost *.cpp,*.hh,*.hpp,*.ipp,*.tpp,*.go,*.py syn match cCustomMarco "[A-Z_]\+\s*(" contains=cCustomParen

    hi def link cCustomParen Braces
    hi def link cCustomFunc Function
    hi def link cCustomMarco PreProc
    hi def link cCustomNamespace Namespace

    hi def link cCustomMember GroupMembers
    hi def link cCustomNamespaceMember GroupMembers

    hi def link cCustomScope Statement
    hi def link cCustomScope2 Statement
    hi def link OperatorChars Statement
endif
" }}}

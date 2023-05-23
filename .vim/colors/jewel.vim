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

"Set the number of terminal colors to 256, this will work on most systems
"set t_Co=256
" Colors {{{
let s:none = ['NONE', 'NONE']
let s:black = ['#000000', '0']
let s:base = ['#121212', '233']
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
let s:red    = ['#ec5f67', '203']
let s:orange = ['#f99157', '209']
let s:yellow = ['#fac863', '221']
let s:green  = ['#99c794', '114']
let s:cyan   = ['#62b3b2', '73']
let s:blue   = ['#6699cc', '68']
let s:blue2   = ['#000080', '0']

let s:cyan0   = ['#00afaf', '37']
let s:brown0  = ['#ab7967', '137']
let s:brown1 = ['#dfaf87', '180']
let s:yellow0 = ['#DFDF5F', '185']
let s:green0  = ['#5faf5f', '71']
let s:red0    = ['#d75f5f', '167']
let s:red1    = ['#af5f5f', '131']
let s:purple0 = ['#c594c5', '176']
let s:purple1 = ['#5f5faf', '61'] " old comments"
let s:purple2 = ['#AF87FF', '141']
let s:purple3 = ['#af5fff', '135']
let s:purple4 = ['#ff87ff', '213']
let s:purple5 = ['#ff00af', '199']

let s:white  = ['#ffffff', '15']
let s:none   = ['NONE',    'NONE']
" }}}

syntax on
set hlsearch

" Vim {{{
call s:hi('Bold',              '',         '',         s:bold,       '')
call s:hi('Italic',            '',         '',         s:italic,     '')
call s:hi('Normal',            s:base04,   s:base,     '',           '')
call s:hi('Visual',            s:none,     s:none,     'standout',   '')

call s:hi('Comment',           s:base03,   '',         s:italic,     '')
call s:hi('Constant',          s:white,    '',         '',           '')
call s:hi('Function',          s:cyan,     '',         '',           '')
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
call s:hi('SpecialKey',        s:cyan0,    '',         '',           '')
call s:hi('Todo',              s:black,    s:yellow0,  '',           '')
call s:hi('Title',             s:purple5,  '',         '',           '')
call s:hi('VertSplit',         s:base04,   s:base,     '',           '')

call s:hi('Debug',             s:red0,     '',   '',           '')
call s:hi('ErrorMsg',          s:red0,     s:none,     '',           '')
call s:hi('Exception',         s:red0,     '',   '',           '')
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

call s:hi('DiffAdd',           s:green,    s:none,     '',           '')
call s:hi('DiffAdded',         s:green,    s:none,     '',           '')
call s:hi('DiffChange',        s:blue,     s:none,     '',           '')
call s:hi('DiffDelete',        s:red1,     s:none,     '',           '')
call s:hi('DiffFile',          s:red1,     s:none,     '',           '')
call s:hi('DiffLine',          s:blue,     s:none,     '',           '')
call s:hi('DiffNewFile',       s:green,    s:none,     '',           '')
call s:hi('DiffRemoved',       s:red1,     s:none,     '',           '')
call s:hi('DiffText',          '',         s:none,     '',           '')

call s:hi('IncSearch',         '',         '',         '',           '')
call s:hi('FoldedColumn',      '',         '',         '',           '')

call s:hi('SpellBad',          s:none,     s:none,     'undercurl',  '')
call s:hi('SpellCap',          s:none,     s:none,     'undercurl',  '')
call s:hi('SpellLocal',        s:none,     s:none,     'undercurl',  '')
call s:hi('SpellRare',         s:none,     s:none,     'undercurl',  '')

call s:hi('debugBreakpoint',   s:black,    s:red,      '',        '')
call s:hi('debugBreakpointDisabled',   s:black,    s:red,      '',        '')

" }}}

" Random Plugins {{{
" GitGutter
call s:hi('GitGutterAdd',           s:green0,   '',  '',  '')
call s:hi('GitGutterChange',        s:yellow,   '',  '',  '')
call s:hi('GitGutterDelete',        s:red0,     '',  '',  '')

" Coc
call s:hi('CocErrorSign',           s:red0,     '',  '',  '')
call s:hi('CocWarningSign',         s:yellow0,  '',  '',  '')
call s:hi('CocInfoSign',            s:blue,     '',  '',  '')
call s:hi('CocHintSign',            s:cyan,     '',  '',  '')
call s:hi('CocErrorFloat',          s:red0,     '',  '',  '')
call s:hi('CocWarningFloat',        s:yellow0,  '',  '',  '')
call s:hi('CocInfoFloat',           s:blue,     '',  '',  '')
call s:hi('CocHintFloat',           s:cyan,     '',  '',  '')
call s:hi('CocDiagnosticsError',    s:red0,     '',  '',  '')
call s:hi('CocDiagnosticsWarning',  s:yellow0,  '',  '',  '')
call s:hi('CocDiagnosticsInfo',     s:blue,     '',  '',  '')
call s:hi('CocDiagnosticsHint',     s:cyan,     '',  '',  '')
call s:hi('CocSelectedText',        s:purple0,  '',  '',  '')
call s:hi('CocCodeLens',            s:base04,   '',  '',  '')
" }}}

" LSP {{{
call s:hi('DiagnosticOK',         s:green0,   '',         '',           '')
call s:hi('DiagnosticUnderlineOK',                s:green0,                      '',        'undercurl',  '')
call s:hi('DiagnosticWarn',                       s:yellow,                      '',        '',           '')
call s:hi('DiagnosticUnderlineWarn',              s:yellow,                      '',        'undercurl',  '')
call s:hi('DiagnosticError',                      s:red0,                        '',        '',           '')
call s:hi('DiagnosticUnderlineError',             s:red0,                        '',        'undercurl',  '')
call s:hi('DiagnosticInfo',                       s:blue,                        '',        '',           '')
call s:hi('DiagnosticUnderlineInfo',              s:blue,                        '',        'undercurl',  '')
call s:hi('DiagnosticHint',                       s:base08,                      '',        '',           '')
call s:hi('DiagnosticUnderlineHint',              s:base08,                      '',        'undercurl',  '')
call s:hi('DiagnosticDeprecated',                 s:orange,                      '',        '',           '')

call s:hi('LspReferenceText',                     '',                            s:base01,  '',           '')
call s:hi('LspReferenceRead',                     '',                            s:base01,  '',           '')
call s:hi('LspReferenceWrite',                    '',                            s:base01,  '',           '')
call s:hi('FloatBorder',                          s:base04,                      '',        '',           '')
call s:hi('IndentBlanklineChar',                  s:base01,                      '',        'nocombine',  '')
call s:hi('IndentBlanklineSpaceChar',             s:base01,                      '',        'nocombine',  '')
call s:hi('IndentBlanklineSpaceCharBlankline',    s:base01,                      '',        'nocombine',  '')

" Class Member variables
call s:hi('LspCxxHlGroupMemberVariable',          s:purple2,                     '',        '',           '')
call s:hi('LspCxxHlGroupMemberStatic',            s:purple2,                     '',        '',           '')
call s:hi('LspCxxHlGroupMemberConstant',          s:purple2,                     '',        '',           '')
" Statics do not get assigned a group correctly,  for whatever reason. However,
" other types are already covered,                so this is all that's left
call s:hi('LspCxxHlSymUnknownVariableStatic',     s:purple2,                     '',        '',           '')

" c++ function variables/constants:
call s:hi('LspCxxHlSymMethodVariable',            s:base04,                      s:base,    '',           '')
call s:hi('LspCxxHlSymMethodConstant',            s:base04,                      s:base,    '',           '')
call s:hi('LspCxxHlSymFunctionVariable',          s:base04,                      s:base,    '',           '')
call s:hi('LspCxxHlSymFunctionConstant',          s:base04,                      s:base,    '',           '')

" Enums
call s:hi('LspCxxHlGroupEnumConstant',            s:brown1,                      '',        '',           '')
call s:hi('LspCxxHlSymEnumMember',                s:brown1,                      '',        '',           '')

" Namespaces
call s:hi('LspCxxHlGroupNamespace',               s:purple3,                     '',        '',           '')
call s:hi('LspCxxHlSymNamespace',                 s:purple3,                     '',        '',           '')
call s:hi('LspCxxHlSymNamespaceVariable',         s:purple2,                     '',        '',           '')
call s:hi('LspCxxHlSymNamespaceConstant',         s:purple2,                     '',        '',           '')
call s:hi('LspCxxHlSymNamespaceStatic',           s:purple2,                     '',        '',           '')
call s:hi('LspCxxHlSymNamespaceFunction',         s:purple2,                     '',        '',           '')

call s:hi('LspCxxHlSymFileVariable',              s:purple4,                     '',        s:italic,     '')
call s:hi('LspCxxHlSymFileStatic',                s:purple4,                     '',        s:italic,     '')
call s:hi('LspCxxHlSymFileConstant',              s:purple4,                     '',        s:italic,     '')
call s:hi('LspCxxHlSymFileFunction',              s:purple4,                     '',        s:italic,     '')
" }}}

" NVIM and Tree-Sitter {{{
if has('nvim')
    call s:hi('RedrawDebugNormal',      s:black,    s:base04,   '',        '')
    call s:hi('RedrawDebugClear',       s:black,    s:yellow0,  '',        '')
    call s:hi('RedrawDebugComposed',    s:black,    s:green,    '',        '')
    call s:hi('RedrawDebugRecompose',   s:black,    s:red,      '',        '')

    call s:hi('NvimInternalError',      s:black,    s:red,      '',        '')

    call s:hi('@comment',               s:base03,   '',         s:italic,  '')
    call s:hi('@string.documentation',  s:base03,   '',         s:italic,  '')
    call s:hi('@variable.builtin',      s:red0,     '',         '',        '')
    call s:hi('@function',              s:blue,     '',         '',        '')
    call s:hi('@constructor',           s:blue,     '',         '',        '')
    call s:hi('@method',                s:blue,     '',         '',        '')
    call s:hi('@type',                  s:green0,   '',         '',        '')

    call s:hi('@constant',              s:white,    '',         '',        '')
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

"call s:hi('gitCommitOverflow',                a:red,    '',       '',          '')
"call s:hi('gitCommitSummary',                  a:green,  '',       '',          '')
"
"call s:hi('htmlBold',                          a:yellow, '',       '',          '')
"call s:hi('htmlItalic',                        a:purple, '',       '',          '')
"call s:hi('htmlTag',                           a:cyan,   '',       '',          '')
"call s:hi('htmlEndTag',                        a:cyan,   '',       '',          '')
"call s:hi('htmlArg',                           a:yellow, '',       '',          '')
"call s:hi('htmlTagName',                       a:base07, '',       '',          '')
"
"call s:hi('javaScript',                        a:base05, '',       '',          '')
"call s:hi('javaScriptNumber',                  a:orange, '',       '',          '')
"call s:hi('javaScriptBraces',                  a:base05, '',       '',          '')
"
"call s:hi('jsonKeyword',                       a:green,  '',       '',          '')
"call s:hi('jsonQuote',                         a:green,  '',       '',          '')
"
"call s:hi('markdownCode',                      a:green,  '',       '',          '')
"call s:hi('markdownCodeBlock',                 a:green,  '',       '',          '')
"call s:hi('markdownHeadingDelimiter',          a:blue,   '',       '',          '')
"call s:hi('markdownItalic',                    a:purple, '',       s:italic,    '')
"call s:hi('markdownBold',                      a:yellow, '',       s:bold,      '')
"call s:hi('markdownCodeDelimiter',             a:brown,  '',       s:italic,    '')
"call s:hi('markdownError',                     a:base05, a:base00, '',          '')
"
"call s:hi('typescriptParens',                  a:base05, a:none,   '',          '')
"
"call s:hi('NeomakeErrorSign',                  a:red,    a:base00, '',          '')
"call s:hi('NeomakeWarningSign',                a:yellow, a:base00, '',          '')
"call s:hi('NeomakeInfoSign',                   a:white,  a:base00, '',          '')
"call s:hi('NeomakeError',                      a:red,    '',       'underline', a:red)
"call s:hi('NeomakeWarning',                    a:red,    '',       'underline', a:red)
"
"call s:hi('ALEErrorSign',                      a:red,    a:base00, s:bold,      '')
"call s:hi('ALEWarningSign',                    a:yellow, a:base00, s:bold,      '')
"call s:hi('ALEInfoSign',                       a:white,  a:base00, s:bold,      '')
"
"call s:hi('NERDTreeExecFile',                  a:base05, '',       '',          '')
"call s:hi('NERDTreeDirSlash',                  a:blue,   '',       '',          '')
"call s:hi('NERDTreeOpenable',                  a:blue,   '',       '',          '')
"call s:hi('NERDTreeFile',                      '',       a:none,   '',          '')
"call s:hi('NERDTreeFlags',                     a:blue,   '',       '',          '')
"
"call s:hi('YanilTreeFile',                     '',       a:none,   '',          '')
"
"call s:hi('phpComparison',                     a:base05, '',       '',          '')
"call s:hi('phpParent',                         a:base05, '',       '',          '')
"call s:hi('phpMemberSelector',                 a:base05, '',       '',          '')
"
"call s:hi('pythonRepeat',                      a:purple, '',       '',          '')
"call s:hi('pythonOperator',                    a:purple, '',       '',          '')
"
"call s:hi('rubyConstant',                      a:yellow, '',       '',          '')
"call s:hi('rubySymbol',                        a:green,  '',       '',          '')
"call s:hi('rubyAttribute',                     a:blue,   '',       '',          '')
"call s:hi('rubyInterpolation',                 a:green,  '',       '',          '')
"call s:hi('rubyInterpolationDelimiter',        a:brown,  '',       '',          '')
"call s:hi('rubyStringDelimiter',               a:green,  '',       '',          '')
"call s:hi('rubyRegexp',                        a:cyan,   '',       '',          '')
"
"call s:hi('sassidChar',                        a:red,    '',       '',          '')
"call s:hi('sassClassChar',                     a:orange, '',       '',          '')
"call s:hi('sassInclude',                       a:purple, '',       '',          '')
"call s:hi('sassMixing',                        a:purple, '',       '',          '')
"call s:hi('sassMixinName',                     a:blue,   '',       '',          '')
"
"call s:hi('vimfilerLeaf',                      a:base05, '',       '',          '')
"call s:hi('vimfilerNormalFile',                a:base05, a:base00, '',          '')
"call s:hi('vimfilerOpenedFile',                a:blue,   '',       '',          '')
"call s:hi('vimfilerClosedFile',                a:blue,   '',       '',          '')

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

if !exists('g:loaded_gfm_syntax')
    runtime plugin/gfm_syntax.vim
endif

if !g:gfm_syntax_enable_always && index(g:gfm_syntax_enable_filetypes, &l:filetype) == -1
    finish
endif

" Inline code
"
" This is `inline` code.
" Note: \%(^\|[^`\\]\)\zs`[^`] does not work (issue #5)
syn region githubFlavoredMarkdownCode start="\%(^\|[^`\\]\)\@<=`[^`]" end="`" display oneline

" Mentions
"
" @rhysd @foo/bar
syn match githubFlavoredMarkdownMention "\%(^\|\s\)\@<=@\S\+" display

" Tags
"
" #rhysd #foo/bar
syn match githubFlavoredMarkdownTag "\%(^\|\s\)\#<=@\S\+" display

" Strikethrough
"
" ~~This text is deleted~~
syn region githubFlavoredMarkdownStrikethrough start="\~\~" end="\~\~"

" Internal link
"
" [[This is a filename]]
syn region githubFlavoredMarkdownInternalLink matchgroup=githubFlavoredMarkdownInternalLinkDelimiter start="\[\[" end="\]\]" contains=@markdownInline,markdownLineStart concealends

" External link conceal
"
" []()
syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" keepend contained conceal contains=markdownUrl
syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart concealends

" Check box
"
" - [x] Checked
" - [ ] Not checked
syn match githubFlavoredMarkdownCheckBox "\%(\_^\s*\%(-\|\*\|+\|\d\+\.\)\s\+\)\@<=\[[ x]]" contains=githubFlavoredMarkdownCheckBoxBracket,githubFlavoredMarkdownCheckBoxX
syn match githubFlavoredMarkdownCheckBoxBracket "\[\|]" contained containedin=githubFlavoredMarkdownCheckBox
syn keyword githubFlavoredMarkdownCheckBoxX x contained containedin=githubFlavoredMarkdownCheckBox

syntax match todoCheckbox "\[\ \]" conceal cchar=
syntax match todoCheckbox "\[x\]" conceal cchar=
hi def link todoCheckbox Todo

hi def link githubFlavoredMarkdownCode            Constant
hi def link githubFlavoredMarkdownMention         markdownLinkText
hi def link githubFlavoredMarkdownTag             markdownLinkText
hi def link githubFlavoredMarkdownInternalLink    Type
hi def link githubFlavoredMarkdownStrikethrough   Comment
hi def link githubFlavoredMarkdownEmoji           PreProc
hi def link githubFlavoredMarkdownTableDelimiter  Delimiter
hi def link githubFlavoredMarkdownTableAligner    Delimiter
hi def link githubFlavoredMarkdownTableBorder     Type
hi def link githubFlavoredMarkdownIssueNumber     Number
hi def link githubFlavoredMarkdownCheckBoxBracket markdownListMarker
hi def link githubFlavoredMarkdownCheckBoxX       Special

let b:gfm_syntax_enabled = 1

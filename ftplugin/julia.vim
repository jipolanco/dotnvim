" This is compatible with the Julia VSCode plugin:
" https://www.julia-vscode.org/docs/stable/userguide/runningcode/#Julia:-Execute-Code-Cell-in-REPL
let b:slime_cell_delimiter = "##"

" Use ]} et al. to move between "##" blocks.
" Adapted from https://learnvimscriptthehardway.stevelosh.com/chapters/51.html

function! s:NextCell(type, backwards, visual)
    if a:visual
        normal! gv
    end

    " The pattern matches either a line starting with ##, either the first line
    " of the file.
    " TODO for now 'type' doesn't do anything... should we add a second behaviour?
    if a:type == 1
        let pattern = '\v(\n\n^##|%^)'
        let flags = 'e'
    elseif a:type == 2
        let pattern = '\v(\n\n^##|%^)'
        let flags = 'e'
    endif

    if a:backwards
        let dir = '?'
    else
        let dir = '/'
    endif

    execute 'silent normal! ' . dir . pattern . dir . flags . "\r"
endfunction

noremap <script> <buffer> <silent> ]}
        \ :call <SID>NextCell(1, 0, 0)<cr>

noremap <script> <buffer> <silent> [{
        \ :call <SID>NextCell(1, 1, 0)<cr>

noremap <script> <buffer> <silent> ]{
        \ :call <SID>NextCell(2, 0, 0)<cr>

noremap <script> <buffer> <silent> [}
        \ :call <SID>NextCell(2, 1, 0)<cr>

vnoremap <script> <buffer> <silent> ]}
        \ :call <SID>NextCell(1, 0, 1)<cr>

vnoremap <script> <buffer> <silent> [{
        \ :call <SID>NextCell(1, 1, 1)<cr>

vnoremap <script> <buffer> <silent> ]{
        \ :call <SID>NextCell(2, 0, 1)<cr>

vnoremap <script> <buffer> <silent> [}
        \ :call <SID>NextCell(2, 1, 1)<cr>

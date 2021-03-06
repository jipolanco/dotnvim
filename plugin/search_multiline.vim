" Search for the ... arguments separated with whitespace (if no '!'),
" or with non-word characters (if '!' added to command).
"
" Useful for LaTeX!
" Copied from http://vim.wikia.com/wiki/Search_across_multiple_lines
function! SearchMultiLine(bang, ...)
  if a:0 > 0
    let l:sep = (a:bang) ? '\_W\+' : '\_s\+'
    let @/ = join(a:000, l:sep)
  endif
endfunction
command! -bang -nargs=* -complete=tag S
            \ call SearchMultiLine(<bang>0, <f-args>)|normal! /<C-R>/<CR>

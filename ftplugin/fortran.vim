" Indenting.
setlocal shiftwidth=2
setlocal tabstop=2

" Folding.
" setlocal foldmethod=syntax
let fortran_fold = 1
let fortran_fold_conditionals = 0
let fortran_fold_multilinecomments = 0

let fortran_free_source = 1

" More precise syntax colouring.
let fortran_more_precise = 1

" Indent do-enddo loops.
let fortran_do_enddo = 1

" Syntastic.
" See https://github.com/scrooloose/syntastic/wiki/Fortran%3A---gfortran .
" To override the compiler options, use a ".syntastic_fortran_config" file.
let g:syntastic_fortran_compiler = 'gfortran'
let g:syntastic_fortran_compiler_options = '-Wall -Wextra -cpp -std=f2008'
let g:syntastic_fortran_remove_include_errors = 1

let g:ale_fortran_gcc_executable = 'gfortran'
let g:ale_fortran_gcc_options = '-Wall -Wextra -cpp -std=f2008'
let g:ale_fortran_gcc_use_free_form = 1

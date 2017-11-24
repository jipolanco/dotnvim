let b:commentary_format = '// %s'

" Google style C++ (see `clang-format -style=google -dump-config`)
setlocal textwidth=80
setlocal expandtab
setlocal shiftwidth=2
setlocal tabstop=2

" Folding
syn sync fromstart
setlocal foldmethod=syntax
set foldnestmax=4
let g:c_no_comment_fold = 1

" Mappings for clang-format
if has('python3')
    map <localleader>f :py3file $HOME/.config/nvim/clang-format.py<cr>
end

" https://github.com/roxma/ncm-clang#utilities
augroup ncm_clang_wrap_clang_complete_goto
    " default key mapping is annoying
    let g:clang_make_default_keymappings = 0
    " ncm-clang is auto detecting compile_commands.json and .clang_complete
    " file
    let g:clang_auto_user_options = ''

    func! WrapClangGoTo()
        let l:cwd = getcwd()
        let l:info = ncm_clang#compilation_info()
        exec 'cd ' . l:info['directory']
        try
            let b:clang_user_options = join(l:info['args'], ' ')
            call g:ClangGotoDeclaration()
        catch
        endtry
        " restore
        exec 'cd ' . l:cwd
    endfunc

    " map to gd key
    nnoremap <buffer> gd :call WrapClangGoTo()<CR>
augroup END

augroup ncm_clang_with_ale
    let g:ale_linters = {
                \   'c': ['clang'],
                \   'cpp': ['clang'],
                \}
    let g:ale_c_clang_options = join(ncm_clang#compilation_info()['args'], ' ')
    let g:ale_cpp_clang_options = join(ncm_clang#compilation_info()['args'], ' ')

    " (optional, for completion performance) run linters only when I save files
    let g:ale_lint_on_text_changed = 'never'
    let g:ale_lint_on_enter = 0
augroup END

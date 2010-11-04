" vim:foldmethod=marker:fen:
scriptencoding utf-8

" Load Once {{{
if exists('g:loaded_init_loader') && g:loaded_init_loader
    finish
endif
let g:loaded_init_loader = 1
" }}}
" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}


function! init_loader#init(dir) "{{{
    if getftype(a:dir) == ''    " Does not exist.
        return
    endif

    for script in s:glob_init_scripts(a:dir.'/*')
        source `=script`
    endfor
endfunction " }}}

function! s:glob_init_scripts(pattern) "{{{
    let filename_pattern = '\.vim$'
    return filter(split(glob(a:pattern), '\n'), 'v:val =~# filename_pattern')
endfunction " }}}


" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
" }}}

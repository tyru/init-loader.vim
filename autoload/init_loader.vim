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


function! init_loader#init_path(...) "{{{
    let path = a:0 ? a:1 : 'inits'
    return init_loader#init(
    \   init_loader#vim_dir()
    \   . init_loader#separator()
    \   . path
    \)
endfunction " }}}

function! init_loader#is_win() "{{{
    return has('win16') || has('win32') || has('win64') || has('win95')
endfunction " }}}

function! init_loader#separator() "{{{
    " same as pathogen
    return !exists("+shellslash") || &shellslash ? '/' : '\'
endfunction " }}}

function! init_loader#vim_dir() "{{{
    return $HOME . (init_loader#is_win() ? '/vimfiles' : '/.vim')
endfunction " }}}

function! init_loader#init(dir) "{{{
    if getftype(a:dir) == ''    " Does not exist.
        return
    endif

    let got_files = split(glob(a:dir . '/*'), '\n')
    let script_pattern = '\.vim$'
    let scripts = filter(got_files, 'v:val =~# script_pattern')
    for script in scripts
        source `=script`
    endfor
endfunction " }}}


" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
" }}}

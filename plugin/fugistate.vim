" Filename: plugin/fugistate.vim
" Author: Paul-Christian Volkmer <code@pcvolkmer.de>
" License: MIT License

if exists('g:loaded_fugistate') || v:version < 800
  finish
endif
let g:loaded_fugistate = 1

if ! exists('g:fugistate_expand_filename')
  let g:fugistate_expand_filename = '%:t'
endif

if ! exists('g:fugistate_label_changed')
  let g:fugistate_label_changed = 'changed'
endif

if ! exists('g:fugistate_label_new')
  let g:fugistate_label_new = 'new'
endif

if ! exists('g:fugistate_label_unversioned')
  let g:fugistate_label_unversioned = 'unversioned'
endif

augroup FugiState
  autocmd!
  autocmd BufEnter,BufWritePost,FocusGained * :call fugistate#update()
  autocmd User FugitiveChanged :call fugistate#update()
augroup END

function! FugiState()
  return fugistate#file()
endfunction

function! FugiStateGitDir()
  return fugistate#gitdir()
endfunction

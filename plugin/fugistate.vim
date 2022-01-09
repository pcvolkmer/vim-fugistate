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

augroup FugiState
  autocmd!
  autocmd BufEnter,BufWritePost,FocusGained * :call fugistate#update()
  autocmd User FugitiveChanged :call fugistate#update()
augroup END

function! FugiState()
  return fugistate#filename_status()
endfunction

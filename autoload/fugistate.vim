" Filename: plugin/fugistate.vim
" Author: Paul-Christian Volkmer <code@pcvolkmer.de>
" License: MIT License

let s:filename_status = ''

let s:changed = 0
let s:new = 0
let s:unversioned = 0

function! fugistate#update()

  if empty(g:fugistate_expand_filename)
    let filename = expand(@%)
  else
    let filename = expand(g:fugistate_expand_filename)
  endif

  let s:changed = 0
  let s:new = 0
  let s:unversioned = 0

  let s:filename_status = filename

  try
    let gitstatus = FugitiveExecute('status', '-s')
    if gitstatus.exit_status == 0
      for filestate in gitstatus.stdout
        if match(filestate, '^?') == 0
          let s:unversioned = s:unversioned + 1
        elseif match(filestate, '^A') == 0
          let s:new = s:new + 1
        elseif ! empty(filestate)
          let s:changed = s:changed + 1
        endif

        if ! empty(@%) && @% == filestate[3:]
          let s:filename_status = filename . " [" . filestate[0:1] . "]"
        endif
      endfor
    endif
  endtry

endfunction

function! fugistate#file()

  return s:filename_status

endfunction

function! fugistate#gitdir()

  let s:out = []

  if s:changed == 1
    call add(s:out, "1 change")
  endif

  if s:changed > 1
    call add(s:out, s:changed . " changes")
  endif

  if s:new > 0
    call add(s:out, s:new . " new")
  endif

  if s:unversioned > 0
    call add(s:out, s:unversioned . " unversioned")
  endif

  return join(s:out, ', ')

endfunction

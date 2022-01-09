" Filename: plugin/fugistate.vim
" Author: Paul-Christian Volkmer <code@pcvolkmer.de>
" License: MIT License

let s:filename_status = ''

function! fugistate#update()

 if empty(@%)
    let s:filename_status = ''
    return
  endif

  if empty(g:fugistate_expand_filename)
    let filename = expand(@%)
  else
    let filename = expand(g:fugistate_expand_filename)
  endif

  try

    if ! FugitiveIsGitDir()
      let s:filename_status = filename
      return
    endif

    let gitstatus = FugitiveExecute('status', '-s', @%)
    if gitstatus.exit_status != 0 || empty(gitstatus.stdout[0])
      let s:filename_status = filename
      return
    endif
    let s:filename_status = filename . " [" . gitstatus.stdout[0][0:1] . "]"

  catch

    let s:filename_status = filename

  endtry

endfunction

function! fugistate#filename_status()

  return s:filename_status

endfunction

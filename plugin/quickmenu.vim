let s:cmds = { }

fun! s:get_command_name(line)
  let cmd = matchstr( a:line, '\(\d\+)\s\+\)\@<=.\+')
  return cmd
endf

fun! s:run_command()
  let line = getline('.')
  wincmd q
  let cmdname = s:get_command_name( line )
  let cmd = s:get_command( cmdname )
  echo "Executing " . cmd.name . " => " . cmd.command
  exec cmd.command
  echo "Done"
endf

fun! s:get_command(cmd)
  return s:cmds[ a:cmd ]
endf

fun! s:render()
  let index = 0
  for name in keys(s:cmds)
    let cmd = s:cmds[ name ]
    let index += 1
    let item_name = index . ') ' . cmd['name']
                 cal append( line('$') , item_name)
    exec 'nnoremap <buffer> ' . index . " :wincmd q<CR>:" . cmd['command'] . '<CR>'
  endfor
  normal ggdd
  " nnoremap <buffer><script> <CR> :cal <SID>get_command_name()<CR>
  nnoremap <buffer><script> <CR> :cal <SID>run_command()<CR>
endf

fun! QMAdd(cmd,config)
  let config = a:config
  let config['name'] = a:cmd
  let s:cmds[ a:cmd ] = config
endf

fun! QMOpen()
  30vnew
  setlocal bufhidden=wipe buftype=nofile nonu fdc=0
  cal s:render()
  setlocal nomodifiable cursorline
endf

" merge pre-defined commands
if exists('g:quickmenu_cmds')
  let s:cmds = extend(s:cmds, g:quickmenu_cmds)
endif

com! QMOpen  :cal QMOpen()

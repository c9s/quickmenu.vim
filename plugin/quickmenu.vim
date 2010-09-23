
let s:cmds = { }

fun! s:render()

  let index = 0
  for name in keys(s:cmds)
    let cmd = s:cmds[ name ]
    let index += 1
    let item_name = cmd['command']
    cal append(0, item_name)
  endfor
endf

fun! QMAdd(cmd,config)
  let config = a:config
  let config['command'] = a:cmd
  let s:cmds[ a:cmd ] = config
endf

fun! QMOpen()
  30vnew
  setlocal bufhidden=wipe buftype=nofile nonu fdc=0
  cal s:render()

  setlocal nomodifiable
  setlocal cursorline
endf

cal QMAdd( 'Command' , {  } )
cal QMAdd( 'Command2' , {  } )
cal QMOpen()

"------------------------------------------------------------------------------------------"
" version:                                                                                  "
"   - 1.0  @ 2022.03.27                                                                     "
" owner: luole                                                                              "
" description:                                                                              "
"   1.0:                                                                                    "
"       - list all the buffer in a new split window named '-- Buffer List --' ;             "
"       - buffer default only shown file name , type <SPACE> can switch to                  "
"         full file path display mode;                                                      "
"       - sort all the buffer based on the reversed buffer num ;                            "
"       - access '-- Buffer List --' shown buffer support below 3 ways:                     "
"           - type the red 'handle' character;                                              "
"           - using the j k ctrl+f ctrl+b to move , then type Enter key ;                   "
"           - use the / to search keyword(support regexp) , then n or N to skip             "
"             to your wanted buffer , finally type Enter;                                   "
"       - support below highlighted tag:                                                    "
"           - yellow <M> tag will displayed when buffer Modified ;                          "
"           - green <A> tag will displayed when buffer active displayed in buffer;          "
"       - support dd shortcut to delete a buffer when it not Modified ,buffer               "
"         modified must be accessed and manually delted due to safty concern;               "
"                                                                                           "
"-------------------------------------------------------------------------------------------"
if !exists("g:path_display_mode")
    " default 0 only show filename,  1 mean absolutely path
    let g:path_display_mode = 0
endif

if !exists("g:file_sort_mod")
    " default 0 sort by file name , 1 sort by reversed bid 
    let g:file_sort_mod = 0
endif

" --- variable initial ---
let s:BufferList  = "-- Buffer List --"  " new split buffer list window name
let s:HandleIndex = {}                   " handle index
let s:nowBids     = []                   " now loaded buffer bids list
let s:LineCount   = 0                    " buffer list window display lines
let s:CursorLine  = line(".")            " current cursorLine position line

let g:winBufferSwitchRecord = {win_getid() : []}
let g:winBufferSwitchNow       = {win_getid() : 0 }

function! s:initWinBufferSwitchRecordDic()
"    echo 'initWinBufferSwitchRecordDic'
    let currentWinId = win_getid()
    if !has_key(g:winBufferSwitchRecord,currentWinId)
        let g:winBufferSwitchRecord[currentWinId] = []
    endif
    if !has_key(g:winBufferSwitchNow,currentWinId)
        let g:winBufferSwitchNow[currentWinId] = 0
    endif

    for win in keys(g:winBufferSwitchRecord)
        if win_id2tabwin(win)[0] == 0 &&  win_id2tabwin(win)[1] == 0
            call remove(g:winBufferSwitchRecord, win)
            call remove(g:winBufferSwitchNow, win)
        endif
    endfor
endfunction

function! bufferHandle#Popup()
    call s:initWinBufferSwitchRecordDic()
    "info:  if the \ is click on  in the buffer list window , it exit
    if bufloaded(bufnr(s:BufferList))
        execute 'bwipeout! ' . bufnr(s:BufferList)
        return
    endif

    if empty(s:HandleIndex) 
        call s:GenHandleIndex()
    endif
    
    if g:file_sort_mod == 0
        let bufcontent = s:SortByPath()
    else
        let bufcontent = s:SortByBid()
    endif

    if empty(bufcontent)
        return
    endif

" --- split a window ---
    execute 'silent! ' . '24' . 'new ' . s:BufferList

" --- BufferList local setting ---
    setlocal number
    setlocal noshowcmd
    setlocal noswapfile
    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal nobuflisted
    setlocal nowrap
" --- keyword highlighting ---
   highlight index_red    ctermfg=red    cterm=BOLD guifg=red 
   highlight index_yellow ctermfg=yellow cterm=BOLD guifg=yellow 
   highlight index_green  ctermfg=green  cterm=BOLD guifg=green 
   highlight index_bold   cterm=BOLD  gui=BOLD
   syntax match index_red     "^ [a-z]\+\|^[';.][a-z]\|\[[a-z]\|\][a-z]"
   syntax match index_yellow  '+'
   syntax match index_green   '@'
   syntax match index_bold    '>'

" --- put the content to buffer list window ---
    setlocal modifiable
        put! = bufcontent
        "- delete the last dummy line 
        execute "$ delete"
    setlocal nomodifiable


" ---  map the handle key
    call s:MapHandleKeys()

"    nnoremap     <silent> <buffer>   q     :bwipeout<CR> 
    nnoremap     <silent> <buffer>   =     :call bufferHandle#SwitchSortMode()<CR>
    nnoremap     <silent> <buffer>   0     :call bufferHandle#SwitchPathDisplay()<CR>
    nnoremap     <silent> <buffer> <CR>    :call bufferHandle#LoadByCursor()<CR>
    nnoremap     <silent> <buffer>  dd     :call bufferHandle#KillByCursor()<CR>
    " add mouse double left open file feature
    nnoremap <silent> <buffer> <rightmouse> :call bufferHandle#LoadByCursor()<CR>
    nnoremap <silent> <buffer> <middlemouse> :call bufferHandle#LoadByCursorInNewTab()<CR>

    autocmd! VimResized  <buffer> call s:OnResized()
    autocmd! CursorMoved <buffer> call s:OnCursorMoved()

    " - curso move to the previous current line  
    call cursor(s:CursorLine, 4)

endfunction

function! bufferHandle#DiffTheBuffer()
   let currentBid = bufnr() 
   let file       = getbufinfo(currentBid)[0]['name']
   let filetype   = &filetype
   execute 'diffthis'
   execute 'vertical split ' . file . '--!!!' .'--<' . currentBid. '>--' .'DIFF'
   execute 'normal dG'
   execute 'read ' . file 
   execute 'normal ggdd'
   exec "set ft=".filetype
   setlocal buftype=nowrite
   setlocal bufhidden=delete
   execute 'diffthis'
endfunction





function! bufferHandle#LoadByCursorInNewTab()
    let idx = line(".") - 1
    execute '$tabnew'
    let tempBufferBid = bufnr('%')
    call s:LoadByIndex(idx)
    exec 'bwipeout' . tempBufferBid 
endfunction

function! s:OnResized()
    bwipeout
    call bufferHandle#Popup()
    call s:DrawBufferList()
endfunction

function! s:OnCursorMoved()
    call s:DrawBufferList()
    let s:CursorLine = line(".")
endfunction


function! bufferHandle#SwitchSortMode()
    let g:file_sort_mod = (g:file_sort_mod + 1) % 2
    bwipeout
    call bufferHandle#Popup()
endfunction

function! bufferHandle#SwitchPathDisplay()
    let g:path_display_mode = (g:path_display_mode + 1) % 2
    bwipeout
    call bufferHandle#Popup()
endfunction


" TODO   this func need enhance to flexable gen index
function! s:GenHandleIndex()
    let handleIndex = {}
    let handle1 = "qwertasfzxcvyuiopm"
    let handle2 = ".;['"
    let handle3 = "qwertasdfgzxcvbyuiophjklnm"

    let handle1_index = 0
    let handle2_index = 0
    let handle3_index = 0

    let maxHandleKeyNum = strlen(handle1) + strlen(handle2)*strlen(handle3) - 1
    for idx in range(0,maxHandleKeyNum) 
        if idx < strlen(handle1)
            let handle = handle1[idx]
        else
            let handle = handle2[handle2_index] . handle3[handle3_index]
            let handle3_index = handle3_index + 1
            if handle3_index == strlen(handle3)
                let handle3_index = 0
                let handle2_index = handle2_index + 1
            endif
        endif 
        let handleIndex[handle] = idx              "need change
    endfor
    let s:HandleIndex = handleIndex
endfunction

function! s:MapHandleKeys()
    let handleIndex = s:HandleIndex
    if empty(handleIndex)
        echo "Need HandleIndex!"
        return
    endif
    setlocal modifiable
        for handle in keys(handleIndex)
            execute 'nnoremap <silent> <buffer> '  . handle . ' :call bufferHandle#LoadByHandle("' . handle . '")<CR>'
            execute 'nnoremap <silent> <buffer> d' . handle . ' :call bufferHandle#KillByHandle("' . handle . '")<CR>'
            execute "nnoremap <silent> <buffer> <space>" . handle . ' :call bufferHandle#LoadByHandleSplit("' . handle . '")<CR>'
            execute "nnoremap <silent> <buffer> <space><space>" . handle . ' :call bufferHandle#LoadByHandleNewtab("' . handle . '")<CR>'
        endfor
    setlocal nomodifiable
endfunction

function! bufferHandle#LoadByHandleNewtab(handle)
    let handleIndex = s:HandleIndex
    if !has_key(handleIndex, a:handle)
        echo "No such key: " . a:handle
        return
    endif
    let idx = line("w0") + handleIndex[a:handle] - 1
    execute '$tabnew'
    let tempBufferBid = bufnr('%')
    call s:LoadByIndex(idx)
    exec 'bwipeout' . tempBufferBid 
endfunction

function! s:DrawBufferList()
    let handleIndex = s:HandleIndex
    if empty(handleIndex)
        echo "Need HandleIndex!"
        return
    endif
    setlocal modifiable
        for handle in keys(handleIndex)
            let row = line("w0") + handleIndex[handle]
            if row > s:LineCount
                continue
            endif
            if strlen(handle) < 2
                let handle =  " " .handle . " "
                let str = handle . strpart(getline(row), 3)
            else
                let str = handle . strpart(getline(row), 2)
            endif
            call setline(row, str)
        endfor
    setlocal nomodifiable
endfunction

function! s:FormatPath(bid, path)
    let bid = a:bid
    let path = a:path
    let maxw = 1000
    " FIXME       the getbufvar(bid, '&modifiable') will cause issue 
"    if strlen(path) <= 0 || !getbufvar(bid, '&modifiable') || !getbufvar(bid, '&buflisted')
    if strlen(path) <= 0 || !getbufvar(bid, '&buflisted')
        return ""
    endif


    " adapt the length of path
    let path_list = matchlist(path, '.*/\(.*\)')

    if get(path_list,1,'not_exist') != 'not_exist' && g:path_display_mode == 0
        let path = path_list[1]
    endif

    if bufwinnr(bid) != -1 || getbufvar(bid,'&modified')
        if bufwinnr(bid) != -1
            let path =  '@->  ' . path
        else
            let path =  '-->  ' . path
        endif

        if getbufvar(bid, '&modified')
        let path = ' -+-' . path
        else
            let path =  ' ---' . path
        endif
    else
        let path = ' ----->  ' . path

    endif


    return path
endfunction


function! s:SortByBid()
    let lastBuf = bufnr('$')
    let content = ""

    let currentListedBids = []
    let noBidTag    = 1

" it is very confused the buflisted(0) will return 1 !!! and sometimes 0, curious
    for bid in range(1,lastBuf)
        if !buflisted(bid) 
            continue
        else
            let noBidTag = 0
            call add(currentListedBids, bid)
        end
    endfor

    if noBidTag
        return
    end
    let nline = 0
    " in fact the currentListedBids is really reversed when it using reverse() func
    for bid in reverse(currentListedBids)
        if getbufinfo(bid)[0]['name'] == ''
            let path = 'BID_' . bid . '----NO_NAME_BUFFER----'
        else
            let path = getbufinfo(bid)[0]['name']
        endif

        let line = s:FormatPath(bid, path)

        if empty(line) | continue | endif

        let content = content . "   " . line . "\n"
        let nline = nline + 1
    endfor

    let s:nowBids = currentListedBids
    let s:LineCount = nline
    return content
endfunction

fu! s:SortByPath()

    let lastBuf = bufnr('$')
    let content = ""

    let currentListedBids = []
    let noBidTag    = 1

" NOTE it is very confused the buflisted(0) will return 1 !!! and sometimes 0, curious
    for bid in range(1,lastBuf)
        if !buflisted(bid) 
            continue
        else
            let noBidTag = 0
            call add(currentListedBids, bid)
        end
    endfor

    if noBidTag
        return
    end

    let nline = 0
    let file_bid_dic = {}
    let bid_path_dic = {}
    for bid in currentListedBids
        if getbufinfo(bid)[0]['name'] == ''
            let path = 'BID_' . bid . '----NO_NAME_BUFFER----'
        else
            let path = getbufinfo(bid)[0]['name']
        endif

        let path_list = matchlist(path, '.*/\(.*\)')
        if get(path_list,1,'not_exist') != 'not_exist'
            let file = path_list[1]
        else 
            let file = path
        endif

        if has_key(file_bid_dic, file)
            let file = file . bid
        endif

        let file_bid_dic[file] = bid 
        let bid_path_dic[bid] = path 
    endfor


    let path_sorted_bid_list = []
    for key in sort(keys(file_bid_dic))
        let bid  = file_bid_dic[key]
        let path = bid_path_dic[bid]

        call add(path_sorted_bid_list, bid)

        let line = s:FormatPath(bid, path)

        if empty(line) | continue | endif

        let content = content . "   " . line . "\n"
        let nline = nline + 1
    endfor

    let s:nowBids = path_sorted_bid_list
    let s:LineCount = nline
    return content
endfu


function! bufferHandle#LoadByHandleSplit(handle)
    let handleIndex = s:HandleIndex
    if !has_key(handleIndex, a:handle)
        echo "No such key: " . a:handle
        return
    endif
    let idx = line("w0") + handleIndex[a:handle] - 1
    execute 'new'
    let tempBufferBid = bufnr('%')
    call s:LoadByIndex(idx)
    exec 'bwipeout' . tempBufferBid 
endfunction

function! bufferHandle#LoadByHandle(handle)
    let handleIndex = s:HandleIndex
    if !has_key(handleIndex, a:handle)
        echo "No such key: " . a:handle
        return
    endif
    let idx = (line("w0") -1) + handleIndex[a:handle]
    call s:LoadByIndex(idx)
endfunction

function! bufferHandle#LoadByCursor()
    let idx = line(".") - 1
    call s:LoadByIndex(idx)
endfunction


function! s:LoadByIndex(idx)
    let bids = s:nowBids
    if a:idx >= len(bids) || a:idx < 0
        return
    endif

    let bid = bids[a:idx]

    " load buffer
    if bufexists(bufnr(s:BufferList))
        execute 'bwipeout ' . bufnr(s:BufferList)
    endif
    for idx in range(0,len(g:winBufferSwitchRecord[win_getid()])-1)
        if g:winBufferSwitchRecord[win_getid()][idx] == bid
            call remove(g:winBufferSwitchRecord[win_getid()], idx)
            break
        endif
    endfor
    call add(g:winBufferSwitchRecord[win_getid()], bid)
    "FIXME    the bufferSwitchNow seems has some issue cause the index out of range
    let g:winBufferSwitchNow[win_getid()] = len(g:winBufferSwitchRecord[win_getid()])-1
    execute "b " . bid

endfunction


function! bufferHandle#KillByHandle(handle)
    let handleIndex = s:HandleIndex
    if !has_key(handleIndex, a:handle)
        echo "No such key: " . a:handle
        return
    endif
    let idx = line("w0") + handleIndex[a:handle] - 1
    call s:KillByIndex(idx)
endfunction

function! bufferHandle#KillByCursor()
    let idx = line(".") - 1
    call s:KillByIndex(idx)
endfunction

function! s:KillByIndex(idx)
    if a:idx >= len(s:nowBids) || a:idx < 0
        echo "Out of range!"
        return
    endif
    let bid = s:nowBids[a:idx]
    bwipeout

	"if getbufvar(bid, '&modified')
    "    echo "  -----------    WARNING    -------------  "
	"	echo "    No write since last change in file     " 
	"	echo "    Review and manually delete/save it     "
    "    echo "-------------------------------------------"
    "    call bufferHandle#Popup()
    "    return
	"endif

    " kill buffer

    execute "silent bwipeout! " . bid
    call bufferHandle#Popup()
endfunction



function! bufferHandle#prevBuffer()
    " avoid mistype in --buffer list--- window cause error
    if !has_key(g:winBufferSwitchRecord ,win_getid()) || !has_key(g:winBufferSwitchNow,win_getid())
        return
    endif

    call s:RecordBuf()
    let g:winBufferSwitchNow[win_getid()] = g:winBufferSwitchNow[win_getid()] - 1

    if g:winBufferSwitchNow[win_getid()] < 0 
        let g:winBufferSwitchNow[win_getid()] = len(g:winBufferSwitchRecord[win_getid()])-1
    endif
    if bufexists(g:winBufferSwitchRecord[win_getid()][g:winBufferSwitchNow[win_getid()]])
        execute "b " . g:winBufferSwitchRecord[win_getid()][g:winBufferSwitchNow[win_getid()]]
    else 
        call remove(g:winBufferSwitchRecord[win_getid()], g:winBufferSwitchNow[win_getid()])
        if empty(g:winBufferSwitchRecord[win_getid()])
            return
        else
            call bufferHandle#nextBuffer()
        endif
    endif

endfunction

function! bufferHandle#nextBuffer()
    if !has_key(g:winBufferSwitchRecord ,win_getid()) || !has_key(g:winBufferSwitchNow,win_getid())
        return
    endif
    call s:RecordBuf()
    let g:winBufferSwitchNow[win_getid()] = g:winBufferSwitchNow[win_getid()] + 1
    if g:winBufferSwitchNow[win_getid()] > len(g:winBufferSwitchRecord[win_getid()])-1 
        let g:winBufferSwitchNow[win_getid()] = 0
    endif
    if bufexists(g:winBufferSwitchRecord[win_getid()][g:winBufferSwitchNow[win_getid()]])
        execute "b " . g:winBufferSwitchRecord[win_getid()][g:winBufferSwitchNow[win_getid()]]
    else 
        call remove(g:winBufferSwitchRecord[win_getid()], g:winBufferSwitchNow[win_getid()])
        if empty(g:winBufferSwitchRecord[win_getid()])
            return
        else
            call bufferHandle#nextBuffer()
        endif
    endif
endfunction

function! s:RecordBuf()
"    echoerr 'RecordBuf'
    call s:initWinBufferSwitchRecordDic()
    let bufferNoRecorded = 1
"    echo g:winBufferSwitchRecord[win_getid()]
    for idx in range(0,len(g:winBufferSwitchRecord[win_getid()])-1)
        if g:winBufferSwitchRecord[win_getid()][idx] == bufnr('%')
            let bufferNoRecorded = 0
            break
        endif
    endfor
    if bufferNoRecorded == 1
        call add( g:winBufferSwitchRecord[win_getid()], bufnr('%'))
"        echoerr '---------------' . bufnr('%')

        let g:winBufferSwitchNow[win_getid()] = len(g:winBufferSwitchRecord[win_getid()])-1
    endif

endfunction


"FIXME
"   g:winBufferSwitchRecord[win_getid()][g:winBufferSwitchNow[win_getid()]]
function! bufferHandle#detachWinBufRecord()
    if empty(g:winBufferSwitchRecord[win_getid()])
        return
    endif
    call remove( g:winBufferSwitchRecord[win_getid()],g:winBufferSwitchNow[win_getid()] ) 
    call bufferHandle#changeBuf()
endfunction

function! bufferHandle#showWinBufList()
    echo "\n"
    echo "\n"
    echohl Question | echo '---------------- <win buf list> ------------------------------' | echohl None
    echo "\n"
    "prevent the new windwo , show record fail
    call s:initWinBufferSwitchRecordDic()
    call s:RecordBuf()
    let now_bid = []
    for idx in range(0,len(g:winBufferSwitchRecord[win_getid()])-1)
        if bufexists(g:winBufferSwitchRecord[win_getid()][idx])
            call add(now_bid, g:winBufferSwitchRecord[win_getid()][idx])
        endif
    endfor
    let g:winBufferSwitchRecord[win_getid()] = now_bid
"    echoerr '----------------------'

    for idx in range(0,len(g:winBufferSwitchRecord[win_getid()])-1)
        let bufName = getbufinfo(g:winBufferSwitchRecord[win_getid()][idx])[0]['name']
        if bufName == ''
            let bufName = 'BID_' . g:winBufferSwitchRecord[win_getid()][idx] . '----NO_NAME_BUFFER----'
        endif
        let bufName_list = matchlist(bufName, '.*/\(.*\)')
        if get(bufName_list,1,'not_exist') != 'not_exist'
            let file = bufName_list[1]
        else 
            let file = bufName
        endif
        let num = idx + 1
        if bufwinnr(g:winBufferSwitchRecord[win_getid()][idx]) != -1
            echo '          @ ' . num . ' -> ' . file
        else
            echo '            ' . num . ' -> ' . file
        endif

    endfor
    echo "\n"
    echohl SpecialKey | echo '--------------------------------------------------------------' | echohl None
    return
endfunction

function! bufferHandle#changeBuf()
    if empty(g:winBufferSwitchRecord[win_getid()])
        return
    endif
    " avoid mistype in --buffer list--- window cause error
    if !has_key(g:winBufferSwitchRecord ,win_getid()) || !has_key(g:winBufferSwitchNow,win_getid())
        return
    endif

    let g:winBufferSwitchNow[win_getid()] = g:winBufferSwitchNow[win_getid()] - 1

    if g:winBufferSwitchNow[win_getid()] < 0 
        let g:winBufferSwitchNow[win_getid()] = len(g:winBufferSwitchRecord[win_getid()])-1
    endif
    if bufexists(g:winBufferSwitchRecord[win_getid()][g:winBufferSwitchNow[win_getid()]])
        execute "b " . g:winBufferSwitchRecord[win_getid()][g:winBufferSwitchNow[win_getid()]]
    else 
        call remove(g:winBufferSwitchRecord[win_getid()], g:winBufferSwitchNow[win_getid()])
        if empty(g:winBufferSwitchRecord[win_getid()])
            return
        else
            call bufferHandle#nextBuffer()
        endif
    endif

endfunction


"autocmd! WinEnter * call s:initWinBufferSwitchRecordDic()
"autocmd! winEnter,BufWinEnter * call s:RecordBuf()
"autocmd! winEnter,BufWinEnter * call s:RecordBuf()
autocmd! BufWinEnter * call s:RecordBuf()
autocmd! VimEnter * call s:loadAllBufToRecord()

function! s:loadAllBufToRecord()
    let lastBuf = bufnr('$')
    let currentListedBids = []
    for bid in range(1,lastBuf)
        if !buflisted(bid) 
            continue
        else
            call add(currentListedBids, bid)
        end
    endfor
    if len(currentListedBids) == 0 
        return
    endif
    for idx in range(1,len(currentListedBids)-1)
        call add(g:winBufferSwitchRecord[win_getid()],currentListedBids[idx])
    endfor

endfunction

let g:cursor_record = []
function! bufferHandle#cursor_record(operation)
    if(a:operation == 'delete')
        let g:cursor_record = []
        return
    endif
    let cursor_pos = getpos('.')
    let cursor_node = [cursor_pos[1],cursor_pos[2]]
    if (index(g:cursor_record,cursor_node) == -1 )
        call add(g:cursor_record, cursor_node)
        let g:cursor_record_index = len(g:cursor_record) - 1
    end
endfunction

function! bufferHandle#cursor_go(operation)
    if len(g:cursor_record) == 0 | return | endif
    if (a:operation == 'right')
        if (g:cursor_record_index == len(g:cursor_record) - 1)
            let g:cursor_record_index = 0
            call cursor(g:cursor_record[g:cursor_record_index])
        else
            let g:cursor_record_index = g:cursor_record_index + 1
            call cursor(g:cursor_record[g:cursor_record_index])
        endif
    endif
    if (a:operation == 'left')
        if (g:cursor_record_index == 0 )
            let g:cursor_record_index = len(g:cursor_record) - 1
            call cursor(g:cursor_record[g:cursor_record_index])
        else
            let g:cursor_record_index = g:cursor_record_index - 1
            call cursor(g:cursor_record[g:cursor_record_index])
        endif
    endif
endfunction





function! bufferHandle#comment(operation)
    let current_syntax = &syntax
    let cursor_pos     = getpos('.')
    if (
        \ current_syntax == 'tcsh' 
        \ || current_syntax == 'yaml'
        \ || current_syntax == 'python'
       \)
        let current_comment_tag = '#'
    endif
    if ( current_syntax == 'vim' )
        let current_comment_tag = '"'
    endif
    if(a:operation == 'comment')
            execute 'normal 0i' . current_comment_tag
            call cursor([cursor_pos[1],cursor_pos[2]])
    endif
    if(a:operation == 'uncomment')
            execute 'normal 0x'
            call cursor([cursor_pos[1],cursor_pos[2]])
    endif
    
endfunction

function! bufferHandle#git_diff()
    let file = getbufinfo('%')[0]['name']
    let filetype   = &filetype
"    let file = expand('%')
    let git_root = system('git rev-parse --show-toplevel')
    let git_root_list = matchlist(git_root,'\(.*\)\n')
    let path_list = matchlist(file, git_root_list[1].'/\(.*\)')
    if get(path_list,1,'not_exist') != 'not_exist'
        let file = path_list[1]
    endif
    execute 'diffthis'
    let temp_diff_file = file . '____GIT'
    execute 'vsp ' . temp_diff_file
    execute 'set buftype=nofile'
    execute 'set bufhidden=wipe'
    execute 'silent ' 'read ! ' . 'git show HEAD:' . file
    execute 'normal ggdd'
    exec "set ft=".filetype
    execute 'diffthis'
endfunction

function! bufferHandle#show_all_git_diff()
    let temp_git_all_diff_stuff = '---GIT_DIFF_ALL_STUFF---'
    if bufloaded(temp_git_all_diff_stuff) 
        execute 'bwipeout! ' . temp_git_all_diff_stuff
    endif
    execute '$tabnew!'.temp_git_all_diff_stuff
    execute 'silent read! git diff'
    execute 'set syntax=git'
    execute 'highlight git_diff_file ctermfg=red guifg=red'
    execute "syntax match git_diff_file '.*diff --git.*' "
    execute 'normal gg0'
    execute 'normal dd'
endfunction

function! bufferHandle#p4_diff()
    let file = getbufinfo('%')[0]['name']
    execute 'diffthis'
    let temp_diff_file = file . '____P4'
    execute 'vsp ' . temp_diff_file
    execute 'set buftype=nofile'
    execute 'set bufhidden=wipe'
    execute 'silent ' 'read ! ' . 'p4 print ' . file
    execute 'normal gg2dd'
    execute 'diffthis'

endfunction
function! bufferHandle#git_status()
    let temp_git_status = '---GIT_STATUS---'
    if bufloaded(temp_git_status) 
        execute 'bwipeout! ' . temp_git_status
    endif
    execute '$tabnew ' . temp_git_status

    execute 'highlight branch ctermfg=7 ctermbg=4 guifg=#ffffff guibg=#555555'
    execute "syntax match branch '.*On branch.*'"

    execute 'highlight wait_commit term=bold,reverse cterm=bold ctermfg=0 ctermbg=121 gui=bold guifg=bg guibg=LightGreen'
    execute "syntax match wait_commit 'Changes to be committed:'"

    execute 'highlight not_staged term=standout ctermfg=0 ctermbg=11 guifg=Black guibg=Yellow'
    execute "syntax match not_staged 'Changes not staged for commit:'"

    execute 'highlight untrack term=reverse cterm=bold ctermbg=9 gui=bold guibg=Red'
    execute "syntax match untrack 'Untracked files:'"

    execute 'highlight new ctermfg=green guifg=green'
    execute "syntax match new 'new file:'"
    execute 'highlight modified ctermfg=yellow guifg=yellow'
    execute "syntax match modified 'modified:'"
    execute 'highlight deleted ctermfg=red guifg=red'
    execute "syntax match deleted 'deleted:'"
"    execute "set filetype=git"
    setlocal buftype=nowrite
    setlocal bufhidden=delete
    execute 'silent read ! git status'
    execute 'normal ggdd'
    execute 'normal gg0i>>>>>>>  '
    execute 'normal ggA  <<<<<<<'
    execute 'normal o'
endfunction

let g:Runcmdcnt=0
function! Runcmd(cmd)
exec "e! __cmd__output__".g:Runcmdcnt
let g:Runcmdcnt=g:Runcmdcnt+1
setlocal bufhidden=delete
setlocal noswapfile
setlocal buftype=nowrite
exec "silent r ! ".a:cmd
endfunction
command! -nargs=+ Runcmd exec Runcmd(<q-args>)


function! bufferHandle#filter()
    execute 'normal mm'
    let @m = ''
    execute 'g//y M'
    execute "normal 'm"
    execute 'edit! ~/temp/--MATCH--'
    execute 'normal ggdG'
    execute 'silent put M'
    execute 'normal ggdddd'
endfunction
function! bufferHandle#getMatchLine()
    execute "let g:match_line=getline('.')"
    let @z=getline('.')
    execute "normal! \<C-6>"
    call search(g:match_line)
    let @m=":call search(g:match_line)\<cr>"
    execute "normal! zz"
endfunction

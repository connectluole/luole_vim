"  - -----------------------
"  - owner:   luole        -
"  - date:    2022/7/30    -
"  - version: 1.0          -
"  - -----------------------

"if ($USER != "luole")
"    set runtimepath=/home/luole/.vim,/home/luole/.vim/plugged/vim-easymotion,/home/luole/.vim/plugged/lightline.vim,/home/luole/.vim/plugged/indentLine,/home/luole/.vim/plugged/leaderF,/home/luole/.vim/plugged/nerdtree,/home/luole/.vim/plugged/supertab,/home/luole/.vim/plugged/tagbar,/home/luole/.vim/plugged/vim-fugitive,/home/luole/.vim/plugged/vim-surround,/home/luole/.vim/plugged/vim-dict,/home/luole/.vim/plugged/vim-quickui,/home/luole/.vim/plugged/quickmenu.vim,/home/luole/.vim/plugged/vim-startify,/home/luole/.vim/plugged/auto-pairs,/home/luole/.vim/plugged/vim-snippets,/home/luole/.vim/plugged/ultisnips,/home/luole/.vim/plugged/Leaderf-snippet,/home/luole/.vim/plugged/tabular,/home/luole/.vim/plugged/vim-markdown,/home/luole/.vim/plugged/vim-startuptime,/home/luole/.vim/plugged/xterm-color-table.vim,/home/luole/.vim/plugged/vim-floaterm,/home/luole/.vim/plugged/vim-which-key,/home/luole/.vim/plugged/vim-visual-multi,/home/luole/.vim/plugged/LeaderF-marks,/home/luole/.vim/plugged/duoduo,/home/luole/.vim/plugged/gruvbox,/home/luole/.vim/plugged/molokai,/home/luole/.vim/plugged/onedark.vim,/home/luole/.vim/plugged/vim-easymotion,/home/luole/.vim/plugged/lightline.vim,/home/luole/.vim/plugged/indentLine,/home/luole/.vim/plugged/leaderF,/home/luole/.vim/plugged/nerdtree,/home/luole/.vim/plugged/supertab,/home/luole/.vim/plugged/tagbar,/home/luole/.vim/plugged/vim-fugitive,/home/luole/.vim/plugged/vim-surround,/home/luole/.vim/plugged/vim-dict,/home/luole/.vim/plugged/vim-quickui,/home/luole/.vim/plugged/quickmenu.vim,/home/luole/.vim/plugged/vim-startify,/home/luole/.vim/plugged/auto-pairs,/home/luole/.vim/plugged/vim-snippets,/home/luole/.vim/plugged/ultisnips,/home/luole/.vim/plugged/Leaderf-snippet,/home/luole/.vim/plugged/tabular,/home/luole/.vim/plugged/vim-markdown,/home/luole/.vim/plugged/vim-startuptime,/home/luole/.vim/plugged/xterm-color-table.vim,/home/luole/.vim/plugged/vim-which-key,/home/luole/.vim/plugged/vim-visual-multi,/home/luole/.vim/plugged/LeaderF-marks,/home/luole/.vim/plugged/duoduo,/home/luole/.vim/plugged/gruvbox,/home/luole/.vim/plugged/molokai,/home/luole/.vim/plugged/onedark.vim,/home/luole/.vim/ftpplugin,/home/luole/.vim/plugged/vim-easymotion,/home/luole/.vim/plugged/lightline.vim,/home/luole/.vim/plugged/indentLine,/home/luole/.vim/plugged/indentLine/after,/home/luole/.vim/plugged/leaderF,/home/luole/.vim/plugged/nerdtree,/home/luole/.vim/plugged/supertab,/home/luole/.vim/plugged/tagbar,/home/luole/.vim/plugged/vim-fugitive,/home/luole/.vim/plugged/vim-surround,/home/luole/.vim/plugged/gruvbox,/home/luole/.vim/plugged/molokai,/home/luole/.vim/after,/home/luole/.vim/plugged/indentLine/after,/home/luole/.vim/plugged/ultisnips/after,/home/luole/.vim/plugged/tabular/after,/home/luole/.vim/plugged/vim-markdown/after,/home/luole/.vim/plugged/LeaderF-marks/after,/home/utils/vim-8.2.3582/share/vim/vim82,/home/luole/.vim/plugged/indentLine/after,/home/luole/.vim/plugged/ultisnips/after,/home/luole/.vim/plugged/tabular/after,/home/luole/.vim/plugged/vim-markdown/after,/home/luole/.vim/plugged/LeaderF-marks/after,$VIMRUNTIME
"endif

"======== plugin
call plug#begin('~/.vim/plugged')
    Plug 'itchyny/lightline.vim'
    Plug 'preservim/nerdtree'
    Plug 'Yggdroot/leaderF'
    Plug 'liuchengxu/vim-which-key'
    Plug 'Yggdroot/indentLine'
    Plug 'mhinz/vim-startify'
    Plug 'easymotion/vim-easymotion'
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'ervandew/supertab'
    Plug 'preservim/tagbar'
    Plug 'honza/vim-snippets'
    Plug 'SirVer/ultisnips'
    Plug 'skywind3000/Leaderf-snippet'
    Plug 'Yggdroot/LeaderF-marks'
    Plug 'voldikss/vim-floaterm'
    Plug 'mg979/vim-visual-multi'
    Plug 'preservim/vim-markdown'
    Plug 'guns/xterm-color-table.vim'
    Plug 'dstein64/vim-startuptime'

    Plug 'skywind3000/vim-dict'
    Plug 'skywind3000/asyncrun.vim'
"    Plug 'skywind3000/vim-quickui'
"    Plug 'skywind3000/quickmenu.vim'
"    Plug 'godlygeek/tabular'
"--- colorscheme
    Plug 'Yggdroot/duoduo'
    Plug 'morhetz/gruvbox'
    Plug 'tomasr/molokai'
    Plug 'joshdick/onedark.vim'
    Plug 'liuchengxu/space-vim-dark'
call plug#end()
"--- plugin config 
">>>>>>>>>>>>>>>> bufferHandle  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
nnoremap \          :call bufferHandle#Popup()<CR>
nnoremap <space>a   :execute 'edit! ' . system('head -1 ~/temp/VIM_FILE_HISTORY')<cr>
nnoremap <space>bw  :bwipeout!<CR>
nnoremap <silent> <space><space> 
nnoremap <c-h>      :call bufferHandle#prevBuffer()<CR>
nnoremap <c-l>      :call bufferHandle#nextBuffer()<CR>
nnoremap <space>d   :call bufferHandle#detachWinBufRecord()<CR>
nnoremap <space>l   :call bufferHandle#showWinBufList()<CR>

nnoremap <space>m   :call bufferHandle#filter()<cr>
nnoremap <space>M   :call bufferHandle#getMatchLine()<cr>
"git p4 diff with latess
nnoremap ,dp :call bufferHandle#p4_diff()<cr>
nnoremap ,dg :call bufferHandle#git_diff()<cr>
nnoremap ,dl :call bufferHandle#DiffTheBuffer()<CR>
nnoremap ,da :call bufferHandle#git_status()<CR>

nnoremap <silent>,c :call bufferHandle#comment('comment')<CR>
nnoremap <silent>,o :call bufferHandle#comment('uncomment')<CR>

vnoremap <silent>,c :call bufferHandle#comment('comment')<CR>
vnoremap <silent>,o :call bufferHandle#comment('uncomment')<CR>
nnoremap <silent> <A-m> :call bufferHandle#cursor_record('')<cr>
nnoremap <silent> <A-d> :call bufferHandle#cursor_record('delete')<cr>
nnoremap <silent> <A-,> :call bufferHandle#cursor_go('left')<cr>
nnoremap <silent> <A-.> :call bufferHandle#cursor_go('right')<cr>
">>>>>>>>>>>>>>>> leaderF >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
let g:Lf_StlColorscheme = 'powerline'
let mapleader           = ","
let g:Lf_WindowPosition = 'popup'
let g:Lf_ShowDevIcons = 0
let g:Lf_AutoResize     = 1
let g:Lf_PopupHeight    = 0.7
let g:Lf_PopupWidth     = 0.7
nnoremap   ,m   :Leaderf --nowrap mru<cr>
nnoremap   ,l   :Leaderf --nowrap line<cr>
nnoremap   ,s   :Leaderf snippet<cr>
nnoremap   ,g   :Leaderf --bottom rg<space>
nnoremap   ,L   :Leaderf --nowrap --cword line<cr>
nnoremap   ,G   :Leaderf --bottom --cword rg<space>
nnoremap   ,M   :LeaderfMarks<cr>
nnoremap   ,gr  :LeaderfRgRecall<cr>
nnoremap   ,gb  :Leaderf --bottom rg --all-buffers<space>
"nnoremap ,f :Leaderf --nowrap file<cr>
nnoremap ,b :Leaderf --nowrap buffer <cr>

">>>>>>>>>>>>>>>> NERDTree >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
nnoremap <space>n :NERDTree<cr>
nnoremap <space>N :NERDTreeClose<cr>
let g:NERDTreeSortOrder =  ['\/$', '*', '[[timestamp]]']    "sort by time
let NERDTreeChDirMode   =  2                                " this will change CWD when nerdtree root dir change

">>>>>>>>>>>>>>>> easymotion  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
map ~ <Plug>(easymotion-prefix)
map M <Plug>(easymotion-bd-w)
map S <Plug>(easymotion-bd-f)
map R <Plug>(easymotion-bd-jk)
"map U <Plug>(easymotion-k)
"map D <Plug>(easymotion-j)

">>>>>>>>>>>>>>>> indentLine  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
let g:indentLine_enabled = 0
nnoremap <space>il :IndentLinesToggle<cr>

">>>>>>>>>>>>>>>> lightline  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
set laststatus=2
set noshowmode
if !has('gui_running')
  set t_Co=256
endif
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [[ 'filename' ,'modified'  ],
    \            [ 'mode', 'paste' ] ] ,
    \   'right': [ [ 'percent' ],
    \              [ 'lineinfo' ],
    \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
    \ },
    \ 'component': {
    \   'A': '  '
    \ },
    \ 'mode_map': {
      \ 'n' : 'N',
      \ 'i' : 'I',
      \ 'R' : 'R',
      \ 'v' : 'V',
      \ 'V' : 'VL',
      \ "\<C-v>": 'VB',
      \ 'c' : 'C',
      \ 's' : 'S',
      \ 'S' : 'SL',
      \ "\<C-s>": 'SB',
      \ 't': 'T',
      \ },
\ }

">>>>>>>>>>>>>>>> supertab  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
let g:SuperTabDefaultCompletionType = "context"         "this make supertab complet refer to content
autocmd bufEnter * :hi Pmenu    ctermfg=black ctermbg=gray  guifg=black guibg=#8ac6fa
autocmd bufEnter * :hi PmenuSel ctermfg=7     ctermbg=4     guibg=black guifg=yellow
nnoremap ,w :set complete+=w<cr>

">>>>>>>>>>>>>>>> molokai  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
nnoremap <space>im :colorscheme molokai \| syntax on <cr>
nnoremap <space>io :colorscheme onedark \| syntax on <cr>

">>>>>>>>>>>>>>>> vim-dict  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
let g:vim_dict_dict = [
    \ '/home/luole/.vim/plugged/vim-dict/dict',
    \ ]
let g:vim_dict_config = {'html':'html,javascript,css', 'markdown':'text', 'yaml':'text'}
nnoremap <space>id :set complete+=k<cr>
">>>>>>>>>>>>>>>> startify  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"autocmd User StartifyReady :NERDTree
"autocmd User StartifyReady :normal l
let g:startify_bookmarks = [ 
    \  {'v': '~/.vimrc'},
    \  '~/.cshrc' 
    \  ]

let g:startify_change_to_dir = 0   " 0 mena no change
let g:startify_files_number = 3
let g:ascii = [
 \ '                                                                      ',
 \ '                                                                      ',
 \ '            VV          VVII          MMMM             ',
 \ '             VV        VV  II        MM  MM            ',
 \ '              VV      VV    II      MM    MM           ',
 \ '               VV    VV      II    MM      MM          ',
 \ '                VV  VV        II  MM        MM         ',
 \ '                 VVVV          IIMM          MM        ',
 \''                                                  
 \] 
let g:startify_lists = [
      \ { 'type': 'files',     'header': ['  --> Most Recent Used File']            },
      \ { 'type': 'dir',       'header': ['  --> Most Recent Used File in < '. getcwd() . ' >' ]},
      \ { 'type': 'sessions',  'header': ['  --> VIM Session']       },
      \ { 'type': 'bookmarks', 'header': ['  --> File/Dir Bookmark']      },
      \ { 'type': 'commands',  'header': ['  --> Commands']       },
      \ ]
let g:startify_custom_header = g:ascii
"let g:startify_custom_header = g:ascii + startify#fortune#boxed()
nnoremap <space>se :Startify<cr>
nnoremap <space>ss :SSave<space>
nnoremap <space>sd :SDelete<space>
">>>>>>>>>>>>>>>> ultisnips  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsExpandTrigger='<c-s>'

">>>>>>>>>>>>>>>> auto_pair   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
let g:AutoPairsShortcutJump='<M-w>'
let g:AutoPairsShortcutToggle='<M-q>'
let g:AutoPairs={'(':')', '[':']', '{':'}',"'":"'",'"':'"'}
"let g:AutoPairs={'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
let g:AutoPairs['<']='>'
">>>>>>>>>>>>>>>> which key  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
nnoremap <silent> <space> :WhichKey '<Space>'<CR>
nnoremap <silent> , :WhichKey ','<CR>

">>>>>>>>>>>>>>>>  multi cursor  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
let g:VM_mouse_mappings = 1
let g:VM_leader = {'default': ',', 'visual': ',', 'buffer': 'z'}
">>>>>>>>>>>>>>>>  floaterm >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
nnoremap <space>\ :FloatermToggle<cr>
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_wintype='popup'
">>>>>>>>>>>>>>>>  AsyncRun >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
nnoremap ,ar :AsyncRun<space>
nnoremap ,as :AsyncStop<cr>
nnoremap ,ao :copen<cr>
"======== map 
inoremap <A-h> <c-w>
inoremap <A-u> <c-u>
nnoremap <c-k> <c-]>
nnoremap <c-j> <c-t>
nnoremap <c-i> <esc>
nnoremap <space>in :set number!<cr>
nnoremap <space>iw :set wrap!<cr>
nnoremap <space>ii :set ignorecase!<cr>
nnoremap <space>ir :set relativenumber!<cr>
nnoremap <space>it :set tabstop=2 softtabstop=2 shiftwidth=2<cr>
nnoremap <space>iv :set virtualedit=all<cr>
nnoremap <space>is :syntax on<cr>
nnoremap <space>xc :w! /home/luole/temp/temp.csh<cr>:! tcsh %<cr>
nnoremap <space>xv :w! /home/luole/temp/temp.vim<cr>:source /home/luole/temp/temp.vim<cr>
let mapleader = ","

"nnoremap <leader>b :buffer<space>
"nnoremap <leader>z :mkview<cr>
nnoremap <space>st :set syntax=

nnoremap <space>T :terminal ++curwin<cr>

nnoremap <space>p :set cursorcolumn! cursorline!<cr>
nnoremap <silent> <space>w  :w!<cr>
nnoremap <silent> <space>q  :q!<cr>
nnoremap <space>e  :e!<space>
nnoremap <space>t  :$tabnew<space>
nnoremap <A-;> <esc>
inoremap <A-;> <esc>
vnoremap <A-;> <esc>
nnoremap <A-n> <c-f>L
nnoremap <A-p> <c-b>H
vnoremap <A-n> <c-f>L
vnoremap <A-p> <c-b>H
nnoremap <A-h> <c-w>h
nnoremap <A-l> <c-w>l
nnoremap <A-k> <c-w>k
nnoremap <A-j> <c-w>j
nnoremap <A-b> <c-w>2>
nnoremap <A-i> <c-w>2+
tnoremap <A-o> <c-w>N

nnoremap <space>r :source ~/.vimrc<cr>
nnoremap ' `


"   clipboard
function! Clipboard()
    exec "silent! edit! ~/temp/clipboard.txt"
    exec "normal ggdG"
    exec "put 0"
    exec "normal ggdd"
    exec "silent! w!"
    exec "silent! bp"
    exec "silent! bwipeout! ~/temp/clipboard.txt"
endfunction
nnoremap <A-c> :call Clipboard()<cr>

function! PrintClipboard()
    exec "silent! read ~/temp/clipboard.txt"
endfunction
nnoremap <A-v> :call PrintClipboard()<cr>

"   dir control
function! ChangeCwd()
    exec 'silent! !cdr | tee ~/temp/vim_cd.txt'
    let dir=system('cat ~/temp/vim_cd.txt')
    exec 'cd' . dir
    exec 'redraw!'
    echohl Function | echo "[CWD]  ".getcwd()  | echohl None
endfunction
"nnoremap <silent> <space>c :call ChangeCwd()<cr>
nnoremap <silent> <space>c :call ChangeCwd()<cr>
nnoremap <silent> <space>D :$tabnew ~/temp/record_dir.log<cr>

function! ChangeDirAlignToFile()
    if get(matchlist(getbufinfo(bufnr('%'))[0]['name'], '\(.*\)/.*'),1,'not_exist') != 'not_exist'
        let filePwd = matchlist(getbufinfo(bufnr('%'))[0]['name'], '\(.*\)/.*')[1]
        exec 'cd!' . filePwd 
        echohl Function | echo "[JumpTo]  " .filePwd | echohl None
    else
        echohl Function | echo "---NOT CHANGE DIR--- still in   ".getcwd()  | echohl None
    endif
endfunction
nnoremap <silent> <space>C :call ChangeDirAlignToFile()<cr>
nnoremap <silent> <space>. :echohl Function \| echo "[CWD]  ".getcwd()  \| echohl None <cr>

nnoremap <space>f :echohl Function \| echo ' '.getbufinfo(bufnr('%'))[0]['name'] \| echohl None <cr>

nnoremap ,dd :call bufferHandle#show_all_git_diff()<cr>

">>>>>>>>>>>>>>>> highlight  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"autocmd MenuPopup * :highlight LineNr term=bold cterm=NONE ctermfg=gray ctermbg=NONE gui=NONE guifg=gray guibg=NONE
"--tnlog
autocmd BufWinEnter *.tn.log*,*.runlog :highlight luole_red      ctermfg=red     guifg=red
autocmd BufWinEnter *.tn.log*,*.runlog :highlight luole_yellow   ctermfg=yellow  guifg=yellow
autocmd BufWinEnter *.tn.log*,*.runlog :highlight luole_green    ctermfg=green   guifg=green
autocmd BufWinEnter *.tn.log*,*.runlog :highlight luole_bold     cterm=BOLD      gui=BOLD

autocmd BufWinEnter *.tn.log*,*.runlog :syntax match luole_red     '(ERR_CRITICAL:.*_\d\d\d)\|exiting with status 1'
autocmd BufWinEnter *.tn.log*,*.runlog :syntax match luole_yellow  '(WARN:.*_\d\d\d)'
autocmd BufWinEnter *.tn.log*,*.runlog :syntax match luole_green   '.*EXEC EVENT.*'
autocmd BufWinEnter *.tn.log*,*.runlog :syntax match luole_bold    '.*exec_sequence.*TIMESLOT.*\|.*ENTER procedure.*\|shift_ir\|shift_dr'

autocmd BufWinEnter *.log :highlight luole_red     ctermfg=red guifg=red
autocmd BufWinEnter *.log :syntax match luole_red  '---->'
"======== basic setup 
" - basic
set cscopequickfix=s-,c-,d-,i-,t-,e-,f-             "used for csope
set nocompatible
set number
set mouse=a
colorscheme duoduo
"autocmd bufEnter * :highlight LineNr term=bold cterm=NONE ctermfg=gray ctermbg=NONE gui=NONE guifg=gray guibg=NONE
set hidden
set wildmenu
set wildmode=list:longest,full
set ruler
set ignorecase
set smartcase
set hlsearch
set incsearch
set nowrap
set showtabline=2
set scrolloff=2
syntax on
filetype on
set complete=.
set clipboard+=unnamed
set nobackup
set noswapfile
set laststatus=2
set fileencoding=utf-8
set encoding=utf-8
set t_Co=256
set vb t_vb=        " no bell
"set cursorcolumn cursorline
" - tab 
set autoindent
set smartindent
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
"- error fix
if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
endif
set linespace=4
set backspace=2
"- gui
autocmd GuiEnter * set t_vb=   " no blink screen
if has("gui_running")
    colorscheme duoduo
    autocmd InsertLeave * hi Cursor  guibg=green
    autocmd InsertEnter * hi Cursor  guibg=red
endif
set guioptions-=T
set guioptions-=m
"======== autocmd 
"autocmd BufRead * :loadview

"======== tab completion
set complete=.
"function! TabComplete()
"  if pumvisible()
"    return "\<C-P>"
"  endif
"  if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
"    return "\<Tab>"
"  elseif exists('&omnifunc') && &omnifunc != ''
"    return "\<C-X>\<C-O>"
"  else
"    return "\<C-P>"
"  endif
"endfunction
"inoremap <Tab> <C-R>=TabComplete()<CR>
"======== tab line config
"-- map
"nnoremap <silent> <space>1  :normal! 1gt<cr>
"nnoremap <silent> <space>2  :normal! 2gt<cr>
"nnoremap <silent> <space>3  :normal! 3gt<cr>
"nnoremap <silent> <space>4  :normal! 4gt<cr>
"nnoremap <silent> <space>5  :normal! 5gt<cr>
"nnoremap <silent> <space>6  :normal! 6gt<cr>
"nnoremap <silent> <space>7  :normal! 7gt<cr>
"nnoremap <silent> <space>8  :normal! 8gt<cr>
"nnoremap <silent> <space>9  :normal! 9gt<cr>
let g:previou_tab_num = 1
function! TabSwitch(tab_num)
    let g:previou_tab_num = tabpagenr()
    exec 'normal' . a:tab_num . 'gt'
endfunction
nnoremap <silent> <space>1 :call TabSwitch(1)<cr> 
nnoremap <silent> <space>2 :call TabSwitch(2)<cr> 
nnoremap <silent> <space>3 :call TabSwitch(3)<cr> 
nnoremap <silent> <space>4 :call TabSwitch(4)<cr> 
nnoremap <silent> <space>5 :call TabSwitch(5)<cr> 
nnoremap <silent> <space>6 :call TabSwitch(6)<cr> 
nnoremap <silent> <space>7 :call TabSwitch(7)<cr> 
nnoremap <silent> <space>8 :call TabSwitch(8)<cr> 
nnoremap <silent> <space>9 :call TabSwitch(9)<cr> 
nnoremap <silent> <space>; :call TabSwitch(g:previou_tab_num)<cr>
"-- func
autocmd bufEnter * :set tabline=%!MyTabLine()
function MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    let s .= '%' . (i + 1) . 'T'
    let s .= '  '
    let s .= i+1
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
    let s .= ' |'
  endfor
  highlight fillout term=reverse ctermbg=236
  let s .=  '%#fillout#'. "%#TabLineFill#%T" . '%#fillout#'
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999X X '
  endif
  return s
endfunction
function MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let file = getbufinfo(buflist[winnr-1])[0]['name']
  if (file == '')
      let file = 'NO NAME'
  endif
  let path_list = matchlist(file, '.*/\(.*\)')
  if get(path_list,1,'not_exist') != 'not_exist'
      let file = path_list[1]
  endif
  return file
endfunction

"========== alt key config =========
function! Terminal_MetaMode(mode)
    set ttimeout
    if $TMUX != ''
"        set ttimeoutlen=30
        set ttimeoutlen=5
    elseif &ttimeoutlen > 10 || &ttimeoutlen <= 0
"        set ttimeoutlen=80
        set ttimeoutlen=10
    endif
    if has('nvim') || has('gui_running')
        return
    endif
    function! s:metacode(mode, key)
        if a:mode == 0
            exec "set <M-".a:key.">=\e".a:key
        else
            exec "set <M-".a:key.">=\e]{0}".a:key."~"
        endif
    endfunc
    for i in range(10)
        call s:metacode(a:mode, nr2char(char2nr('0') + i))
    endfor
    for i in range(26)
        call s:metacode(a:mode, nr2char(char2nr('a') + i))
        call s:metacode(a:mode, nr2char(char2nr('A') + i))
    endfor
    if a:mode != 0
        for c in [',', '.', '/', ';', '[', ']', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    else
        for c in [',', '.', '/', ';', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    endif
endfunc
command! -nargs=0 -bang VimMetaInit call Terminal_MetaMode(<bang>0)
call Terminal_MetaMode(0)

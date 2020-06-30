if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup fedora
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add $PWD/cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin on

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"
set autoindent
set nu
color flattr

syntax on
" set number
filetype plugin on
set runtimepath^=~/.vim/bundle/ctrlp.vim

map <C-x> :bd<CR>
map <C-l> :bn<CR>
map <C-h> :bp<CR>
map ;t :TagbarToggle<CR>
map ;s :nohl<CR>
map ;do :1,$+1diffget<CR>
inoremap <silent> <C-l> <C-o>:update<C-o>:bn<CR>
inoremap <silent> <C-l> <C-o>:update<C-o>:bp<CR>
inoremap <silent> <C-S>          <C-O>:update<CR>
noremap  <silent> <C-S>          <C-O>:update<CR>
map <C-UP> <C-W><UP>
map <C-DOWN> <C-W><DOWN>
map <C-LEFT> <C-W><LEFT>
map <C-RIGHT> <C-W><RIGHT>
noremap  <silent> <C-p>          <C-O>:FZF<CR>

map gr :execute "grep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
let c = 1
while c <= 99
  execute "nnoremap " . c . "gb :" . c . "b\<CR>"
  let c += 1
endwhile

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3']]
"    \ ['black',       'SeaGreen3'],
"    \ ['darkmagenta', 'DarkOrchid3'],
"    \ ['Darkblue',    'firebrick3'],
"    \ ['darkgreen',   'RoyalBlue3'],
"    \ ['darkcyan',    'SeaGreen3'],
"    \ ['darkred',     'DarkOrchid3'],
"    \ ['red',         'firebrick3'],
"    \ ]

let g:rbpt_max = 9
let g:rbpt_loadcmd_toggle = 0

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
let g:cpp_class_scope_highlight = 1
set scrolloff=9
set tabstop=2
set shiftwidth=2
set expandtab
set ignorecase
set cursorline
"set cursorcolumn

" tagbar config
let g:tagbar_sort = 0
let g:tagbar_show_visibility = 1
let g:tagbar_autopreview = 0
let g:tagbar_previewwin_pos = ""
let g:tagbar_left = 1

"python3-devellet g:clang_library_path = '/usr/lib64/llvm/libclang.so'
"set listchars=eol:¬,tab:>·,trail:·,extends:>,precedes:<,space:~
set listchars=eol:¬,tab:>·,trail:·,extends:>,precedes:<
"set list

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
"set ruler		" show the cursor position all the time
set encoding=utf-8

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

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"
set autoindent
set smartindent
set nu
set relativenumber
set laststatus=2
set hlsearch

syntax on
filetype plugin on

" alt+t to open a new tab
map <silent> <M-t> :tabnew<CR> 

" ctrl+x to close a tab
map <C-x> :tabclose<CR>

" ctrl+l to move to the next tab
map <silent> <C-l> :tabnext<CR>

" ctrl+l to move to the previous tab
map <silent> <C-h> :tabprevious<CR>

" ctrl+q to toggle tagbar
map <C-q> :TagbarToggle<CR>

" alt+\ to hide highlighting(search results)
map <M-\> :nohl<CR>

" alt+g to ACK the worrd below the cursor
map <M-g> :Ack! --cpp <cword><CR>
map <M-h> :Ack! --cpp 

" ctrl+p to open FZF
noremap  <silent> <C-p>          :FZF<CR>

nnoremap n nzz
nnoremap N Nzz

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:rbpt_max = 9
let g:rbpt_loadcmd_toggle = 0

let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
    \   'separately': {
        \       'cmake': 0,
        \   }
        \}

let g:cpp_class_scope_highlight = 1
set scrolloff=9
set tabstop=8
set shiftwidth=8
set noexpandtab
set ignorecase
set cursorline
"set cursorcolumn

"set listchars=eol:¬,tab:>·,trail:·,extends:>,precedes:<,spac
"set listchars=tab:<->,trail:·,extends:>>,precedes:<<
set listchars=tab:<->,lead:·,trail:·
set list

call plug#begin()

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'morhetz/gruvbox'
Plug 'mileszs/ack.vim'

call plug#end()

let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_contrast_light = "hard"
let g:gruvbox_improved_strings=1
set background=dark
set background=light

"color flattr
color gruvbox

" tagbar config
let g:tagbar_sort = 0
let g:tagbar_show_visibility = 1
let g:tagbar_autopreview = 0
let g:tagbar_previewwin_pos = ""
let g:tagbar_left = 1

set mouse=

lua require'nvim-treesitter.configs'.setup{highlight={enable=true}, punctuation={guifg=None}}
noremap  <M-w>          :hi @punctuation guifg=None<CR>
hi @punctuation guifg=None

" Map leader
let mapleader = "-"

" Line's number
set number
" Lines will not wrap if longer than width window
set nowrap

set tabstop=4
set shiftwidth=4
set expandtab

set smartindent

let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 25

augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END

" Map
" Delete line in insert mode
inoremap <leader><c-d> <esc>ddi
" Comment a line for PHP file
autocmd FileType php let maplocalleader="-"
autocmd FileType php inoremap <buffer> <localleader>// <c-o>0//
autocmd FileType php inoremap <localleader><tab> <c-n>
autocmd FileType php,*.yaml,*.yml inoremap <localleader><c-v> <esc>pi

autocmd CursorHoldI php :write

augroup PHPControlStructureGroup
  autocmd!
  autocmd FileType php iabbrev <buffer> iff if () {}<left><left><left><left>
  autocmd FileType php iabbrev <buffer> foreachh foreach () {}<left><left><left><left>
augroup END

augroup PHPClassAbbrevGroup
  autocmd!
  autocmd FileType php iabbrev <buffer> pubb public
  autocmd FileType php iabbrev <buffer> privv private
  autocmd FileType php iabbrev <buffer> prott protected
  autocmd FileType php iabbrev <buffer> constructt public function __construct() {}<left>
  autocmd FileType php iabbrev <buffer> sett public function set(): self {}<left><left><left><left><left><left><left><left><left><left><left>
  autocmd FileType php iabbrev <buffer> gett public function get() {}<left><left><left><left><left>
augroup END

function SearchByContent(text)
    let cmd = "!grep -rnw . -e " . a:text
    execute cmd
endfunction

command -nargs=1 SearchText call SearchByContent(<f-args>)

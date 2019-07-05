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
" let g:netrw_browse_split = 4
let g:netrw_winsize = 25
let g:netrw_chgwin = 2

augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END

autocmd BufNewFile,BufRead *.twig set syntax=html

" Map
" Delete line in insert mode
inoremap <leader><c-d> <esc>ddi
" Comment a line for PHP file
autocmd FileType php let maplocalleader="-"
autocmd FileType php inoremap <buffer> <localleader>// <c-o>0//
autocmd FileType php inoremap <localleader><tab> <c-n>
autocmd FileType php,*.yaml,*.yml inoremap <localleader><c-v> <esc>pi
"autocmd FileType php,*.yaml,*.yml inoremap <localleader><c-z> <esc>ui
"autocmd FileType php setlocal makeprg=php\ -ln\ %
autocmd FileType php setlocal errorformat=%m\ in\ %f\ on\ line\ %l
autocmd FileType *twig,*html setlocal makeprg=tidy\ -eq\ %
autocmd CursorHoldI *.php write

"augroup auto_make_php
"    autocmd!
"    autocmd BufReadPost,BufWritePost *.php silent! make
"    autocmd BufReadPost,BufWritePost *.php redraw!
"    autocmd BufReadPost,BufWritePost *.php cope 5
"    autocmd BufReadPost,BufWritePost *.php wincmd k
"augroup END

"augroup auto_make_html
"    autocmd!
"    autocmd BufReadPost,BufWritePost *.html,*.twig silent! make
"    autocmd BufReadPost,BufWritePost *.html,*.twig redraw!
"    autocmd BufReadPost,BufWritePost *.html,*.twig cope 5
"    autocmd BufReadPost,BufWritePost *.html,*.twig wincmd k
"augroup END


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

function SearchByFilename(filename)
    let cmd = "cexpr system('find . -name " . a:filename . " -printf \"%p:1:1:%f\\n\"') | copen 5"
    execute cmd
endfunction

function SearchText(pattern, filename)
    let cmd = "vimgrep " . a:pattern . " " . a:filename . " | copen 5"
    execute cmd
endfunction

" command -nargs=1 SearchText call SearchByContent(<f-args>)
command -nargs=1 SearchFile call SearchByFilename(<f-args>)
command -nargs=+ SearchText call SearchText(<f-args>)

autocmd FileType php set colorcolumn=80
autocmd FileType php highlight ColorColumn ctermbg=lightgrey guibg=lightgrey

function CtagsGlobalSynch()
    let cmd = "!ctags -R"
    execute cmd
endfunction

function CtagsCurrentFile()
    let path = expand("%:p")
    let cmd = "!ctags " . path
    execute cmd
endfunction

command TagSynch call CtagsCurrentFile()
command GtagSynch call CtagsGlobalSynch()

autocmd BufWritePost php TagSynch

syntax on

" Map leader
let mapleader = "-"

" backspace
set bs=2

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

function SearchByFilename()
    call inputsave()
    let filename = input('Search file: ')
    let path = input('Where are you looking for: ')
    call inputrestore()

    let cmd = "cexpr system('find " . path . " -name " . filename . " -printf \"%p:1:1:%f\\n\"') | copen 10"
    redraw
    execute cmd
endfunction

function SearchText()
    call inputsave()
    let text = input('What are you looking for: ')
    let path = input('Where are you looking for: ')
    call inputrestore()

    let cmd = "vimgrep " . text . " " . path . "  | copen 10"
    execute cmd
endfunction

function CreatePHPFile()
    call inputsave()
    let path = input('Type file name: ')
    let pathString = string(path)
    call inputrestore()

    let filename = split(pathString, "/")[-1]
    let classname = fnamemodify(filename, ":r")
    let cmd = "call writefile(split('<?php\n\nclass " . classname . "\n{\n}', '\n'), " . pathString . ")"
    execute cmd
    execute "edit " . path
endfunction

command CreatePHP call CreatePHPFile()

" command -nargs=1 SearchText call SearchByContent(<f-args>)
command SearchFile call SearchByFilename()
command SearchText call SearchText()

autocmd FileType php set colorcolumn=80
autocmd FileType php highlight ColorColumn ctermbg=lightgrey guibg=lightgrey

function CtagsGlobalSynch()
    let cmd = "!ctags -R"
    execute cmd
endfunction

function CtagsCurrentFile()
    let path = expand("%:p")
    let cmd = "silent !ctags " . path
    execute cmd
endfunction

command TagSynch call CtagsCurrentFile()
command GtagSynch call CtagsGlobalSynch()

autocmd BufWritePost *.php :execute CtagsCurrentFile()


let g:debuggerPort = 9001

set statusline=%f         " Path to the file
set statusline+=%=        " Switch to the right side
set statusline+=%l        " Current line
set statusline+=/         " Separator
set statusline+=%L        " Total lines

autocmd FileType * inoremap <localleader><c-a-down> <esc>YPi


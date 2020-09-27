source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

inoremap { {}<Left>
inoremap {<CR> {<CR>}<Esc>O
inoremap {{ {
inoremap {} {}

nnoremap <F9> :!g++ -o %:r.out %<enter><enter>
nnoremap <F5> :!%:r.out<enter><enter>

:autocmd BufNewFile *.cpp 0r ~/Vim/templates/skeleton.cpp

set nu
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set rnu
    autocmd BufLeave,FocusLost,InsertEnter * set nornu
augroup END

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

" Settings
syntax on
set relativenumber
set number
set smarttab
set splitbelow
set splitright
set clipboard=unnamed
set laststatus=2
set scrolloff=5
set directory=.,$TEMP
" set textwidth=80
" set colorcolumn=+1
set backup
set backupdir=$HOME\Vim\backup
set directory=$HOME\Vim\tmp
set ai
set pastetoggle=<F2>
syntax on
set noundofile        " as well as undo files
set noerrorbells visualbell t_vb=
let g:netrw_liststyle=3
" set colorcolumn=80
set guifont=Powerline\ Consolas:h10
set encoding=utf-8
let g:airline_powerline_fonts=1

" ConEmu conflict with Vim check out
" Github issue https://github.com/Maximus5/ConEmu/issues/641
inoremap <Char-0x07F> <BS>
nnoremap <Char-0x07F> <BS>

" Specify .md files as markdown
au BufRead,BufNewFile *.md setlocal ft=markdown

" Configure tabstop softtabstop and expand or not by filetype
if has("autocmd")
  filetype on

  autocmd FileType vim setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType elm setlocal ts=4 sts=4 sw=4 expandtab

  " These highlight lines that extend past 80 chars
  " autocmd BufEnter * highlight OverLength ctermbg=red guibg=#592929
  " autocmd BufEnter * match OverLength /\%>80v.\+/

  " Turn off bells
  autocmd GUIEnter * set visualbell t_vb=

endif

" Leader customization
let mapleader=" "
map <Leader>ptt :Dispatch py.test %<cr>
map <Leader>pta :Dispatch py.test<cr>
map <Leader>rss :Dispatch bundle exec rspec %<cr>
map <Leader>rsa :Dispatch bundle exec rspec ./spec<cr>
map <Leader>c :ccl<cr>
map <Leader>gs :Gstatus<cr>
map <Leader>gc :Gcommit<cr>

set background=dark
"set background=light

" begin vim-plug
call plug#begin("~/.vim/plugged")

Plug 'janko-m/vim-test'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-rails'

Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'dag/vim-fish'

Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'brooth/far.vim'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'easymotion/vim-easymotion'

Plug 'gcavallanti/vim-noscrollbar'

Plug 'Valloric/YouCompleteMe'
Plug 'w0rp/ale'

Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'

Plug 'chrisbra/csv.vim'

call plug#end()
" end vim-plug

" gives us % for ruby code (do/end etc)
runtime macros/matchit.vim

" fish
set shell=/bin/bash

" VIM THINGS

set laststatus=2

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%<%f
set statusline+=\ %m
set statusline+=\ %#LineNr#
set statusline+=\ \ ⑂(
set statusline+=%#CursorColumn#
set statusline+=%{fugitive#head(6)}
set statusline+=%#LineNr#
set statusline+=)%=
set statusline+=\ %#CursorColumn#
set statusline+=\ %2l
set statusline+=%#LineNr#
set statusline+=:%2c
set statusline+=\ %#CursorColumn#
set statusline+=%{noscrollbar#statusline(9,'–','▓',['▐'],['▌'])}
set statusline+=%#CursorColumn#
set statusline+=%3p%%

" ALE
let g:ale_linters = {
 \ 'javascript': ['eslint'],
 \ 'ruby': [],
 \}
let g:ale_fixers = {
 \ 'javascript': ['eslint'],
 \}

" rails-vim
let g:rails_projections = {
 \ "features/*.feature": {
 \   "alternate": [
 \     "features/steps/{}.rb"
 \   ]
 \ },
 \ "features/steps/*.rb": {
 \   "alternate": [
 \     "features/{}.feature"
 \   ]
 \ }
 \ }

let mapleader=","
" format entire file
map <leader>= mzgg=G`z
" copy entire file to clipboard
command! Copy execute "! cat \"%\" | pbcopy"
set timeoutlen=250

" change & for "search for current word under cursor, don't move
nnoremap & #*cgn

" if a pattern contains an uppercase letter, it is case sensitive, otherwise,
" it is not
set ignorecase
set smartcase

" Use old regex engine, which is faster for ruby
set re=1

" Expand {a, b, c} to new lines
nmap <leader>e 0f{a<CR><Esc>vv:s/, /,\r/g<CR>/[} ]<CR>i,<CR><Esc>gv/}<CR>=
nmap <leader>r 0f(a<CR><Esc>vv:s/, /,\r/g<CR>/[)]<CR>i,<CR><Esc>gv/)<CR>=

" Expand stateless component to stateful one
nmap <leader>c 0cwclass<Esc>ea extends React.Component<Esc>llxxxa<CR>state = {<CR>}<CR><CR>render() {<CR>const { <Esc>/)<CR>C = this.props;<CR><Esc>k%k$%lxo}<Esc>V%=jo

set colorcolumn=80
set softtabstop=0 expandtab shiftwidth=2 smarttab
" clear trailing whitespace on write
autocmd BufWritePre * %s/\s\+$//e
nnoremap ; :

" csv.vim
filetype plugin on

" nerdtree
map <tab> :NERDTreeToggle<CR>
map <tab><tab> :NERDTreeFind<CR>
"let NERDTreeMapQuit='\q'

" YouCompleteMe
set completeopt-=preview

" vim-easymotion
map <Space> <Plug>(easymotion-w)

" vim-test
" write automatically when running tests
set autowrite
nnoremap t :TestNearest<CR>
nnoremap tf :TestFile<CR>
nnoremap ta :TestSuite<CR>
nnoremap tl :TestLast<CR>
nnoremap tg :TestVisit<CR>
let test#ruby#cucumber#executable = 'zeus spinach'
let test#javascript#jest#executable = 'yarn test'
let test#javascript#mocha#executable = 'yarn test'
" make test commands execute using quickfix window
" edit; Not using it because it doesn't work with byebug :(
let test#strategy = "basic"

" test mobile brine
nnoremap tb "byy:!yarn features -t '<C-r>=substitute(@b, '.*"\(.*\)".*' ,"\\1","")<CR>'<CR>
nnoremap tbf :!yarn features %<CR>
" test mobile cucumber
nnoremap tm :!yarn cucumber %\:<C-r>=line('.')<CR><CR>
nnoremap tmf :!yarn cucumber %<CR>
" test web spinach
nnoremap tw :!bundle exec spinach %\:<C-r>=line('.')<CR><CR>
nnoremap twf :!bundle exec spinach %<CR>

" vim-jsx
let g:jsx_ext_required = 0

" fzf.vim
nnoremap <C-P> :Files<CR>
" fzf for neighboring files & dirs
map <C-P><C-P> :Files %:h<CR>
map <C-P><C-U> :Files %:h:h<CR>
" use ag to fzf so it ignores .gitignore files
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>

" Colors
syntax on
highlight ColorColumn ctermbg=6
let g:solarized_termtrans = 1
colorscheme solarized
" Fix background color for iTerm ...
" https://github.com/altercation/solarized/issues/220#issuecomment-269930034

" Remap switching panes to omit the leader
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" More natural split opening
set splitbelow
set splitright

" Automatically resize panes when window gets resized
autocmd VimResized * wincmd =

" Line numbers
set number
set relativenumber

" Odd file syntax highlighting
autocmd BufRead,BufNewFile Fastfile set filetype=ruby
autocmd BufRead,BufNewFile Matchfile set filetype=ruby
autocmd BufRead,BufNewFile Appfile set filetype=ruby

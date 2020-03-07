set background=dark
" set background=light

" begin vim-plug
call plug#begin("~/.vim/plugged")

Plug 'prettier/vim-prettier'
Plug 'dingbat/vim-test'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-rails'

Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
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

Plug 'godlygeek/windowlayout'
Plug 'vim-scripts/bufmru.vim'

Plug 'terryma/vim-multiple-cursors'

call plug#end()
" end vim-plug

" multi cursor
let g:multi_cursor_exit_from_insert_mode = 0
" let g:multi_cursor_exit_from_visual_mode = 0

" undo close window
" remove bad default of space to something unused
let g:bufmru_switchkey = "<c-t>oeijaofij"
command! Q execute "vsplit" bufname(g:bufmru_bnrs[1])

" undo close tab
" from https://www.reddit.com/r/vim/comments/3ke941/undo_close_tab/cuxwxy1/

let s:close_tab_history = []

function! s:UndoCloseTab()
  if len(s:close_tab_history)
    tabnew
    call windowlayout#SetLayout(remove(s:close_tab_history, -1))
  endif
endfunction
command! UndoCloseTab call s:UndoCloseTab()

function! s:CloseTab()
  if tabpagenr('$') != 1
    call add(s:close_tab_history, windowlayout#GetLayout())
    tabclose
  endif
endfunction
command! CloseTab call s:CloseTab()

nnoremap Tx :<C-u>CloseTab<CR>
nnoremap Tu :<C-u>UndoCloseTab<CR>


" prettier
let g:prettier#config#prose_wrap = 'always'
autocmd BufWritePre *.md Prettier

" gives us % for ruby code (do/end etc)
runtime macros/matchit.vim

" fish
set shell=/bin/bash

" VIM THINGS

" Make control-D to close the window like it does in a shell / tmux
nnoremap <C-D> :q<CR>

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

set mouse=a

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

" vim-dispatch
let g:dispatch_quickfix_height=21
set errorformat=""

" vim-test
" write automatically when running tests
set autowrite
nnoremap t :TestNearest<CR>
nnoremap tf :TestFile<CR>
nnoremap ta :TestSuite<CR>
nnoremap tl :TestLast<CR>
nnoremap tg :TestVisit<CR>
let test#ruby#gherkin#framework = 'spinach -b'
let test#javascript#jest#executable = 'yarn jest'
let test#javascript#mocha#executable = 'yarn jest'
" make test commands execute using quickfix window
let test#strategy = "dispatch"
" close quickfix window shortcut
nnoremap <C-F> :ccl<CR>
" open current split into new tab (useful to see QF window full screen too)
nnoremap ts :tab split<CR>

" test rspec without plugin
nnoremap tr :!bundle exec rspec %\:<C-r>=line('.')<CR><CR>

" migrate down
nnoremap rmd :!bundle exec rake db:migrate:down VERSION='<C-r>=substitute(expand('%:t'),'_.*',"","")<CR>'<CR>
nnoremap rmr :!bundle exec rake db:migrate:redo VERSION='<C-r>=substitute(expand('%:t'),'_.*',"","")<CR>'<CR>
nnoremap rm :!bundle exec rake db:migrate<CR>

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

" Remap Y to be more consistent with D and C (copy till end of line)
nnoremap Y y$

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

" Move blocks of code around with alt-j/k
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

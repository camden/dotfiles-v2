" ----->
" Plugins
" ----->

call plug#begin('~/.vim/plugged')

" highlight code blocks in markdown
Plug 'jtratner/vim-flavored-markdown'

" additional text objects like 'delete around periods' = 'da.'
Plug 'wellle/targets.vim'

" comment with gc
Plug 'tpope/vim-commentary'

" async lint engine
Plug 'w0rp/ale'
let g:ale_fix_on_save = 1
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_sign_column_always = 1

" fuzzy finder - required by fzf.vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" motions for surrounding
Plug 'tpope/vim-surround'

" js syntax highlighting + indenting
Plug 'pangloss/vim-javascript'

" jsx syntax highlighting + indenting
Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0

call plug#end()

" ----->
" Options
" ----->

" syntax processing
syntax enable

" allow background unsaved files
set hidden

" backspace over autoindent, line breaks, start of insert (see :help 'backspace')
set backspace=indent,eol,start

" light background for light themes
set background=light

" enable scrolling in terminal vim
set mouse=a

" relative numbers, except for current line
set relativenumber
set number

" no beeps pls
set noerrorbells
set visualbell

" highlight current line
set cursorline

" visual autocomplete for command menu
set wildmenu

" search as characters are entered
set incsearch

set ignorecase          " case insensitive search unless 
set smartcase           " search includes a capital letter

" indentation
set shiftwidth=2
set tabstop=2 " number of visual spaces per tab
set softtabstop=2 " number of spaces in tab when editing
set expandtab " tabs are spaces

" set central swp file location
set directory=~/.vim/swap//

" disable attention for swap files
set shortmess+=A

" show status bar
set laststatus=2

" show filepath, modified flag, filename in status bar
set statusline=%t%m%=%f

" https://stackoverflow.com/a/526940
" file completion
set wildmode=longest,list,full
set wildmenu

" ----->
" Colors
" ----->

" make the signcolumn transparent
highlight clear SignColumn

" ----->
" Key Mappings
" ----->

" set leader to spacebar
let mapleader = "\<space>"

" when searching, center result in screen
nnoremap n nzz
nnoremap N Nzz

" alternate file
nnoremap <leader>r <c-^>

" find files! 
nnoremap <leader><space> :Files<CR>

" move between splits
map <leader>h :wincmd h<cr>
map <leader>j :wincmd j<cr>
map <leader>k :wincmd k<cr>
map <leader>l :wincmd l<cr>

" move visual-line-wise by default
nnoremap j gj
nnoremap k gk

" ----->
" Autocmds
" ----->

augroup MainGroup
    autocmd!

    " disable auto commenting (new line after being on line w/ a comment)
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

    " json indentation
    autocmd Filetype json setlocal shiftwidth=2 tabstop=2 softtabstop=2

    autocmd Filetype js,javascript,jsx,javascript.jsx setlocal shiftwidth=2 tabstop=2 softtabstop=2

    " check if any buffers were changed every time we change buffers
    au FocusGained,BufEnter * :checktime
augroup end

command! TrimWhitespace :%s/\s\+$//e
command! AlignAll :norm gg=G''

" from https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

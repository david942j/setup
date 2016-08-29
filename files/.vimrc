set number
set mouse=a
syntax on
set ts=2
set softtabstop=2
set expandtab
set shiftwidth=2
au FileType Makefile set noexpandtab
" au BufNewFile *.rb 0r ~/.default.rb
set ruler
set backspace=2
set ic
set ru
set hlsearch
set incsearch
set cursorline
colorscheme ron
set laststatus=2
set statusline=\ %{HasPaste()}%<%-15.25(%f%)%m%r%h\ %w\ \ 
set statusline+=\ \ \ [%{&ff}/%Y] 
set statusline+=\ \ \ %<%20.30(%{hostname()}:%{CurDir()}%)\ 
set statusline+=%=%-10.(%l,%c%V%)\ %p%%/%L
function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return '[PASTE]'
    else
        return ''
    endif
endfunction

set t_Co=256
set autoread
set showmatch
set showmode
set nobackup
autocmd FileType c,cpp,cc  set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
nmap <leader>p :set paste!<BAR>set paste?<CR>



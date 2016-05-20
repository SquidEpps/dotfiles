set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'godlygeek/csapprox'
Plugin 'ajh17/Spacegray.vim'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'henrik/vim-indexed-search'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-surround'
Plugin 'kchmck/vim-coffee-script'
"Plugin 'vim-scripts/YankRing.vim'
Plugin 'leafgarland/typescript-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on

colorscheme spacegray

set mouse=a
set ttymouse=xterm2

set nocp ls=2 cul nu hls t_Co=256 ts=3 sts=0 sw=0 ar acd ai si bs=2 noet scs ic is sm sc so=9 siso=9 udf udir=~/.vim/undodir wmnu wim=longest:full,full dir=~/.vim/swapfiles//

silent call system('if [ ! -d ' . &udir . ' ]; then mkdir -p ' . &udir . '; fi;')
silent call system('if [ ! -d ' . &dir . ' ]; then mkdir -p ' . &dir . '; fi;')

au BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
au BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
au BufNewFile,BufRead .bash_aliases* call SetFileTypeSH("bash")

map <C-_> <Plug>NERDCommenterToggle
map! <C-_> <C-O><Plug>NERDCommenterToggle

map <ESC>[D <C-Left>
map <ESC>[C <C-Right>
map! <ESC>[D <C-Left>
map! <ESC>[C <C-Right>

nnoremap <C-L> :nohls<CR>:syn sync fromstart<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR><C-O>:syn sync fromstart<CR>

nnoremap Y y$

"visual search mappings
function! s:VSetSearch()
	let temp = @@
	norm! gvy
	let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
	let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>

noremap <C-n> :NERDTreeFocusToggle<CR>
inoremap <C-n> <Esc>:NERDTreeFocusToggle<CR>

nnoremap <silent> * *N
nnoremap <silent> <C-Right> :tabnext<CR>
nnoremap <silent> <C-Left> :tabprevious<CR>
nnoremap <silent> <C-t> :tabnew<CR>
inoremap <silent> <C-Right> <Esc>:tabnext<CR>
inoremap <silent> <C-Left> <Esc>:tabprevious<CR>
inoremap <silent> <C-t> <Esc>:tabnew<CR>

imap <silent> <Down> <ESC>gji
imap <silent> <Up> <ESC>gki
nmap <silent> <Down> gj
nmap <silent> <Up> gk
vmap <silent> <Down> gj
vmap <silent> <Up> gk

imap <C-u> <ESC><C-u><cr>i
imap <C-d> <ESC><C-d><cr>i


if exists("g:colors_name")
	if g:colors_name == 'spacegray'
		hi clear CursorLine
		hi CursorLine ctermbg=235
		hi CursorLineNr ctermbg=235
		hi Comment ctermfg=245
	endif
endif

function! SyntaxItem()
	return synIDattr(synID(line("."),col("."),1),"name")
endfunction

set statusline=%12(%l/%L%)\ \ %#StatusLineFile#\ %<%f\ %*\ \ %#StatusLineModified#%m%*\ %r\ %h%=%y\ [%{&encoding}]\ [%{&ff}]\ %40([%{SyntaxItem()}]%)\ (0x%04B)\ %3(#%n%)\
hi StatusLineFile cterm=bold ctermfg=DarkBlue ctermbg=64
hi StatusLineModified cterm=bold ctermbg=DarkRed ctermfg=White

let g:airline_powerline_fonts = 1
let g:airline_theme = 'bubblegum'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '│'

function! AirlineInit()
	let g:airline_section_a = airline#section#create_left(['mode', '%12(%l/%L%)', 'crypt', 'paste', 'capslock', 'iminsert'])

    "let g:airline_section_x = airline#section#create_right(['tagbar', 'filetype'])
    "let g:airline_section_y = airline#section#create_right(['ffenc'])
    "let g:airline_section_z = airline#section#create(['windowswap', '%3p%%'.spc, 'linenr', ':%3v '])

	let g:airline_section_x = airline#section#create_right(['%{SyntaxItem()}', '0x%04B'])
	let g:airline_section_z = airline#section#create_right(['tagbar', 'filetype'])
endfunction
autocmd VimEnter * call AirlineInit()

let NERDTreeShowHidden = 1

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

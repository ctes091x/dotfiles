"https://qiita.com/morikooooo/items/9fd41bcd8d1ce9170301
set fenc=utf-8
set nobackup
set noswapfile
set autoread
set hidden
set showcmd

set number
set cursorline
"set cursorcolumn
set virtualedit=onemore
set smartindent
"set visualbell
set showmatch
set laststatus=2
set wildmode=list:longest
nnoremap j gj
nnoremap k gk
syntax enable

set list listchars=tab:\▸\-
set expandtab
set tabstop=2
set shiftwidth=2
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
" set clipboard=unnamed,autoselect
nmap <Esc><Esc> :nohlsearch <CR><Esc>

set mouse=a
set ttymouse=sgr

call plug#begin()
" Plug 'preservim/nerdtree'
  Plug 'lambdalisue/vim-fern'
  Plug 'lambdalisue/nerdfont.vim'
  Plug 'lambdalisue/fern-renderer-nerdfont.vim'
  Plug 'lambdalisue/vim-fern-git-status'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'tpope/vim-fugitive'
" Plug 'vim-denops/denops.vim'
" Plug 'vim-skk/skkeleton'
  Plug 'tomasiser/vim-code-dark'
" Plug 'vim-denops/denops-helloworld.vim'
  Plug 'tyru/skk.vim'
call plug#end()

"https://qiita.com/youichiro/items/b4748b3e96106d25c5bc
let g:airline#extensions#tabline#enabled = 1

"" vim-airline
" ステータスラインに表示する項目を変更する
let g:airline#extensions#default#layout = [
  \ [ 'a', 'b', 'c' ],
  \ ['z']
  \ ]
let g:airline_section_c = '%t %M'
let g:airline_section_z = get(g:, 'airline_linecolumn_prefix', '').'%3l:%-2v'
" 変更がなければdiffの行数を表示しない
let g:airline#extensions#hunks#non_zero_only = 1

" タブラインの表示を変更する
" let g:airline_theme = 'codark'
" let g:airline_theme = 'simple'
let g:airline#extensions#tabline#enabled = 1 " タブラインを表示
let g:airline_powerline_fonts = 1            " Powerline Fontsを利用

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_symbols.crypt = '🔒'		"暗号化されたファイル
let g:airline_symbols.branch = ''		"gitブランチ

" let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline#extensions#tabline#show_buffers = 1
" let g:airline#extensions#tabline#show_splits = 0
" let g:airline#extensions#tabline#show_tabs = 1
" let g:airline#extensions#tabline#show_tab_nr = 0
" let g:airline#extensions#tabline#show_tab_type = 1
" let g:airline#extensions#tabline#show_close_button = 0

" let g:airline#extensions#branch#enabled = 0
" let g:airline#extensions#readonly#enabled = 0

set ttimeoutlen=50

" set termguicolors
" colorscheme codedark
colorscheme habamax
" colorscheme daybreak
nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=30<CR>
let g:fern#renderer = 'nerdfont'
let g:fern#default_hidden=1

"let g:denops#deno='/home/ctes091x/.deno/bin/deno'
"call skkeleton#config({ 'globalDictionaries': [['~/.skk/SKK-JISYO.L', 'euc-jp']] })
"imap <C-j> <Plug>(skkeleton-enable)
"cmap <C-j> <Plug>(skkeleton-enable)

let skk_large_jisyo = '~/.skk/SKK-JISYO.L'
let skk_auto_save_jisyo = 1

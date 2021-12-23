
"  (                                                                                                                     
"  )\ )                    (                  (                                                         (                
" (()/(  )      (          )\ )   (    (   (  )\               (        )   (      )                    )\ )  (   (  (   
"  /(_))/((    ))\  (     (()/(  ))\  ))\  )(((_)(     (      ))\  (   /((  )\    (       (   (    (   (()/(  )\  )\))(  
" (_)) (_))\  /((_) )\ )   ((_))/((_)/((_)(()\   )\    )\ )  /((_) )\ (_))\((_)   )\  '   )\  )\   )\ ) /(_))((_)((_))\  
" / __|_)((_)(_))  _(_/(   _| |(_)) (_))   ((_) ((_)  _(_/( (_))  ((_)_)((_)(_) _((_))   ((_)((_) _(_/((_) _| (_) (()(_) 
" \__ \\ V / / -_)| ' \))/ _` |/ -_)/ -_) | '_| (_-< | ' \))/ -_)/ _ \\ V / | || '  \() / _|/ _ \| ' \))|  _| | |/ _` |  
" |___/ \_/  \___||_||_| \__,_|\___|\___| |_|   /__/ |_||_| \___|\___/ \_/  |_||_|_|_|  \__|\___/|_||_| |_|   |_|\__, |  

" Run nerdtree on autostart
set guifont=Iosevka 
set tabstop=1
set shiftwidth=4
" set softtabstop=4
set expandtab
set title
set smartindent
set t_Co=256 " Enable 256 colours support.
set noswapfile
set termguicolors
set ignorecase
set encoding=UTF-8
set number relativenumber
set mouse=a
syntax on
set clipboard=unnamedplus " Copy all from neovim to x clipboard (i use xclip)
set autoread "Autoread file changes
set noshowmode
set noruler
set laststatus=0
set noshowcmd
set cmdheight=1
set background=dark
set nocompatible
"set cursorline
set showmatch


" ----------------------------------Plugins--------------------------------------

call plug#begin('~/.config/nvim/vim-plug/plugged')

    " Utilities
    Plug 'preservim/nerdtree'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
       \ 'do': 'bash install.sh',
       \ }
    Plug 'ryanoasis/vim-devicons' 
    Plug 'chrisbra/Colorizer' " A plugin to color colornames and codes
    Plug 'dense-analysis/ale' " Syntax checker
    Plug 'sheerun/vim-polyglot' " A collection of language packs for Vim.
    Plug 'PhilRunninger/nerdtree-buffer-ops' " This is a NERDTree plugin that highlights all visible nodes that are open in Vim.
    Plug 'Xuyuanp/nerdtree-git-plugin' " A plugin of NERDTree showing git status flags.
    Plug 'mhinz/vim-startify' " This plugin provides a start screen for Vim and Neovim.
    Plug 'mg979/vim-visual-multi', {'branch': 'master'} " It's called vim-visual-multi in analogy with visual-block, but the plugin works mostly from normal mode.
    Plug 'pechorin/any-jump.vim' " Go to definition. Use :AnyJump on it.
    Plug 'kana/vim-altr'  " Altern between files
    Plug 'andymass/vim-matchup' " Mmtch-up is a plugin that lets you highlight, navigate, and operate on sets of matching text.

    " Colorschemes
    Plug 'sainnhe/edge' " Edge themme
    Plug 'morhetz/gruvbox' " Gruvbox colorscheme
    Plug 'kyoz/purify', { 'rtp': 'vim' } " Purify
    Plug 'mhartington/oceanic-next' " Oceanic next
    Plug 'rakr/vim-one' " vim-one theme
    Plug 'dracula/vim', { 'as': 'dracula' }  " Dracula theme
    Plug 'sonph/onehalf', { 'rtp': 'vim' } " Onehalf theme
    Plug 'tomasr/molokai' " Molokai theme
    Plug 'joshdick/onedark.vim' " One dark theme
    Plug 'ayu-theme/ayu-vim' " Ayu theme

call plug#end()

" ----------------------------------Plugins config--------------------------------------
let g:airline_powerline_fonts = 1 " Enable powerline fonts to Airline
let g:airline#extensions#tabline#enabled = 1 " Smarter tab line
let g:airline_statusline_ontop=1 " Airline in top

let g:webdevivons_enabled_statrtify = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" vim-matchup var
let g:loaded_matchit = 1

" ALE configs
let g:ale_completion_enabled=1
set omnifunc=ale#completion#OmniFunc
set completeopt=menu,menuone,preview,noselect,noinsert
let g:ale_sign_error = '>> '
let g:ale_sign_warning = 'ww '

" Use tab completion
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

function! ConditionalPairMap(open, close)
  let line = getline('.')
  let col = col('.')
  if col < col('$') || stridx(line, a:close, col + 1) != -1
    return a:open
  else
    return a:open . a:close . repeat("\<left>", len(a:close))
  endif
endf
inoremap <expr> ( ConditionalPairMap('(', ')')
inoremap <expr> { ConditionalPairMap('{', '}')
inoremap <expr> [ ConditionalPairMap('[', ']')
inoremap <expr> " ConditionalPairMap('"', '"')
inoremap <expr> < ConditionalPairMap('<', '>')

function! Autostart()
    autocmd VimEnter * colorscheme purify
    autocmd VimEnter * NERDTree
"    autocmd VimEnter * Startify
    autocmd VimEnter * ColorHighlight
    autocmd VimEnter * DoMatchParen
    let g:colorizer_auto_color = 1
    let g:airline_theme='dracula'
endfunction

call Autostart()

" Showing the number of errors and warnings
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? 'OK' : printf(
        \   '%d⨉ %d⚠ ',
        \   all_non_errors,
        \   all_errors
        \)
endfunction
set statusline+=%=
set statusline+=\ %{LinterStatus()}

let g:ale_linters = {
    \'python':['eslint'],
    \'Java': ['eslinit'],
\}


" ----------------------------------Shortcuts--------------------------------------
let mapleader = ","
set timeoutlen=500 " Wait it to enter commands
noremap <Leader>s :w <CR>
noremap <Leader>q :q <CR>
nmap <Leader>r :NERDTreeRefreshRoot<CR>
noremap <silent> <C-t> :NERDTree <CR>
noremap <silent> <C-k> :NERDtreeClose <CR>
noremap <silent> <C-f> :NERDTreeFind<CR>
noremap <silent> <leader> <j> :AnyJump <CR>
" When you only have a single error in a rather long file, it’s sometimes annoying to find the correct line.
nmap <silent> <C-e> <Plug>(ale_next_wrap) 
" Alternate between files
nmap <leader>a <Plug>(altr-forward)
nmap <leader>A <Plug>(altr-back)

let g:startify_custom_header = [
    \ '',
    \'                                          ⣿⣿⣷⡁⢆⠈⠕⢕⢂⢕⢂⢕⢂⢔⢂⢕⢄⠂⣂⠂⠆⢂⢕⢂⢕⢂⢕⢂⢕⢂',
    \'                                          ⣿⣿⣿⡷⠊⡢⡹⣦⡑⢂⢕⢂⢕⢂⢕⢂⠕⠔⠌⠝⠛⠶⠶⢶⣦⣄⢂⢕⢂⢕',
    \'                                          ⣿⣿⠏⣠⣾⣦⡐⢌⢿⣷⣦⣅⡑⠕⠡⠐⢿⠿⣛⠟⠛⠛⠛⠛⠡⢷⡈⢂⢕⢂',
    \'                                          ⠟⣡⣾⣿⣿⣿⣿⣦⣑⠝⢿⣿⣿⣿⣿⣿⡵⢁⣤⣶⣶⣿⢿⢿⢿⡟⢻⣤⢑⢂',
    \'                                          ⣾⣿⣿⡿⢟⣛⣻⣿⣿⣿⣦⣬⣙⣻⣿⣿⣷⣿⣿⢟⢝⢕⢕⢕⢕⢽⣿⣿⣷⣔',
    \'                                          ⣿⣿⠵⠚⠉⢀⣀⣀⣈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣗⢕⢕⢕⢕⢕⢕⣽⣿⣿⣿⣿',
    \'                                          ⢷⣂⣠⣴⣾⡿⡿⡻⡻⣿⣿⣴⣿⣿⣿⣿⣿⣿⣷⣵⣵⣵⣷⣿⣿⣿⣿⣿⣿⡿',
    \'                                          ⢌⠻⣿⡿⡫⡪⡪⡪⡪⣺⣿⣿⣿⣿⣿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃',
    \'                                          ⠣⡁⠹⡪⡪⡪⡪⣪⣾⣿⣿⣿⣿⠋⠐⢉⢍⢄⢌⠻⣿⣿⣿⣿⣿⣿⣿⣿⠏⠈',
    \'                                          ⡣⡘⢄⠙⣾⣾⣾⣿⣿⣿⣿⣿⣿⡀⢐⢕⢕⢕⢕⢕⡘⣿⣿⣿⣿⣿⣿⠏⠠⠈',
    \'                                          ⠌⢊⢂⢣⠹⣿⣿⣿⣿⣿⣿⣿⣿⣧⢐⢕⢕⢕⢕⢕⢅⣿⣿⣿⣿⡿⢋⢜⠠⠈',
    \'                                          ⠄⠁⠕⢝⡢⠈⠻⣿⣿⣿⣿⣿⣿⣿⣷⣕⣑⣑⣑⣵⣿⣿⣿⡿⢋⢔⢕⣿⠠⠈',
    \'                                          ⠨⡂⡀⢑⢕⡅⠂⠄⠉⠛⠻⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢋⢔⢕⢕⣿⣿⠠⠈',
    \'                                          ⠄⠪⣂⠁⢕⠆⠄⠂⠄⠁⡀⠂⡀⠄⢈⠉⢍⢛⢛⢛⢋⢔⢕⢕⢕⣽⣿⣿⠠⠈',  
    \'                                          Ya mate kudasai, oniiichaaan!!',
\]


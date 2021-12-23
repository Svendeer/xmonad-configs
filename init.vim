
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
set tabstop=4
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
    Plug 'eagletmt/ghcmod-vim' " for haskell
    Plug 'Shougo/vimproc'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'pearofducks/ansible-vim'
    "install and use neomake linting
    Plug 'neomake/neomake'

    " Colorschemes
    Plug 'sainnhe/edge' " Edge themme
    Plug 'morhetz/gruvbox' " Gruvbox colorscheme
    Plug 'kyoz/purify', { 'rtp': 'vim' } " Purify
    Plug 'mhartington/oceanic-next' " Oceanic next
    Plug 'rakr/vim-one' " vim-one theme
    Plug 'sonph/onehalf', { 'rtp': 'vim' } " Onehalf theme
    Plug 'tomasr/molokai' " Molokai theme
    Plug 'joshdick/onedark.vim' " One dark theme
    Plug 'ayu-theme/ayu-vim' " Ayu theme
    Plug 'dracula/vim', {'as': 'dracula'} " Dracula theme.

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

let g:colorizer_auto_color = 1
let g:airline_theme='edge'

function! Autostart()
    autocmd VimEnter * colorscheme dracula
    autocmd VimEnter * NERDTree
    " autocmd VimEnter * Startify
    autocmd VimEnter * ColorHighlight
    autocmd VimEnter * DoMatchParen
    " let g:colorizer_auto_color = 1
    " let g:airline_theme='oceanicnext'
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
    \'sh': ['shell'],
    \'python': ['pylint', 'pyflakes', 'mypy'],
    \'Java': ['javac'],
    \'haskell': ['ghc', 'hlint'],
    \'cpp': ['cc', 'cpplint'],
    \'c': ['cc', 'cppcheck'],
\}

" ----------------------------------Shortcuts--------------------------------------
let mapleader = ","
set timeoutlen=500 " Wait it to enter commands
noremap <silent> <C-s> :w <CR>
noremap <silent> <C-q> :q <CR>
noremap <silent> <C-t> :NERDTree <CR>
noremap <silent> <C-k> :NERDTreeClose <CR>
noremap <silent> <C-f> :NERDTreeFind<CR>
noremap <silent> <leader> <f> :NERDTreeRefreshRoot<CR>
noremap <silent> <leader> <j> :AnyJump <CR>
noremap <silent> <C-y> :Startify <CR>

" When you only have a single error in a rather long file, it’s sometimes annoying to find the correct line.
nmap <silent> <C-e> <Plug>(ale_next_wrap) 
" Alternate between files
nmap <leader>a <Plug>(altr-forward)
nmap <leader>A <Plug>(altr-back)

" From COC. Taken from repo: https://github.com/neoclide/coc.nvim
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

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


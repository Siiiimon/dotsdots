" set mapleader to space-key
let mapleader = " "

" escape key remap
inoremap jj <esc>

" fzf setting (auto generated)
set rtp+=/usr/local/opt/fzf

" disable wrapping
set nowrap

" vim-plug
call plug#begin()

" -- visuals --
" zen mode
Plug 'junegunn/goyo.vim'

" Color scheme
Plug 'mhartington/oceanic-next'

" -- utilities --
" fuzzy searcher (files, file contents, etc.)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git Integration
Plug 'tpope/vim-fugitive'
" git changes in the gutter
Plug 'airblade/vim-gitgutter'

" Indenting Plugin
Plug 'godlygeek/tabular'

" Auto Parentheses/Brackets/etc.
Plug 'raimondi/delimitmate'

" -- Language Plugins --
" General Diagnostics
Plug 'folke/trouble.nvim'

" auto completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" C++
Plug 'bfrg/vim-cpp-modern'

" Lua
Plug 'euclidianAce/BetterLua.vim'

call plug#end()

" == Plugin Settings ==
" coc
set encoding=utf-8
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
""  set signcolumn=number
"else
""  set signcolumn=yes
"endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Goyo
" set width
let g:goyo_width = 120

" Colors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
if (has("termguicolors"))
	set termguicolors
endif

" Theme
syntax enable
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext

" Line numbers
set nu rnu

" show gutter as seperate row
set signcolumn=yes:1

" == Commands/Templates ==

" disable Coc in terrier files
augroup CocGroup
    autocmd!
    autocmd BufNew,BufRead * execute "CocDisable"
    " autocmd BufNew,BufEnter *.lua execute "silent! CocEnable"
augroup end

" == Keybindings ==

" fzf: file search
map <leader>p :Files<CR>

" goyo: toggle 
map <leader>z :Goyo<CR>

" gitgutter: toggle
map <leader>d :GitGutterToggle<CR>

" line numbers
map <leader>l :set nu! rnu!<CR>

" open netrw
map <leader>e :Ex<CR>
map <leader>se :Sex<CR>
map <leader>ve :Vex<CR>

" trouble
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>

" coc: Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" coc: GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" coc: Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" coc: Toggle
nnoremap <leader>c :CocToggle<CR> 

function! CocToggle()
    if g:coc_enabled
        CocDisable
    else
        CocEnable
    endif
endfunction
command! CocToggle :call CocToggle()

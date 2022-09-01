set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set exrc "source possbile .vimrc at starting folder
set relativenumber
set nu
set nohlsearch
set hidden
set smartcase
set ignorecase
set incsearch
set scrolloff=8
set nowrap
set timeout timeoutlen=300
let mapleader=" "
let maplocalleader=" "
"change indentation in webdev
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType scss setlocal shiftwidth=2 tabstop=2 softtabstop=2
syntax on

call plug#begin('~/.vim/plugged')
Plug 'gruvbox-community/gruvbox'

" completion and linting
Plug 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile' }
let g:coc_global_extensions = [
    \ 'coc-tsserver',
    \ 'coc-json',
    \ 'coc-css',
    \ 'coc-pyright',
    \ 'coc-sh',
    \ 'coc-pairs',
    \ 'coc-emmet',
    \ 'coc-html',
    \ 'coc-java',
    \ 'coc-java-debug',
    \ 'coc-vimtex'
    \ ]
" ----------------------

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" syntax highlighting for webdev
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'

Plug 'preservim/nerdtree'

" VimTex Plugin vor LaTex
Plug 'lervag/vimtex'

" comment stuff out
Plug 'tpope/vim-commentary'

Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'kyazdani42/nvim-web-devicons'

Plug 'ThePrimeagen/vim-be-good'
call plug#end()

let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'


if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

colorscheme gruvbox
highlight Normal ctermbg=NONE

" vimtex settings
let g:vimtex_view_method = 'zathura'
let g:vimtex_view_forward_search_on_start = 0
let g:vimtex_compiler_latexmk_engines = {'_': '-lualatex'}

" keybindings
inoremap jj <esc>
nnoremap <leader>p "*p
vnoremap <leader>p "*p
nnoremap <silent> <C-f> :silent !tmux neww tmuxsessionizer<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" insert new line when using auto parenthesis
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" better formatting for vim-commentary, comments without space after comment
" tag
autocmd FileType * :let b:commentary_format = &commentstring

" java keybindings
augroup Java
    autocmd Filetype java set makeprg=javac\ -g\ %
    set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
    nnoremap <leader>8 :w<CR>:make<CR>:cwindow<CR> 
    nnoremap <leader>9 :!echo <C-r>=expand('%:r')<CR> \| xargs java<CR>
augroup END

lua << END
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox_dark',
    component_separators = '',
    section_separators = '',
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
END

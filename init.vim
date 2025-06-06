"nvim config file 
"VimL


set nu
set autoindent
filetype plugin indent on
set smarttab
" set listchars=tab:\|\ 
" set list
set relativenumber
set shiftwidth=4 
set tabstop=4
let mapleader="."

call plug#begin()

"colorschmes
Plug 'ellisonleao/gruvbox.nvim'
Plug 'https://github.com/fcpg/vim-orbital'
Plug 'https://github.com/catppuccin/nvim'
Plug 'https://github.com/rebelot/kanagawa.nvim'
Plug 'https://github.com/nyoom-engineering/nyoom.nvim'
Plug 'bluz71/vim-nightfly-colors'
Plug 'rose-pine/neovim'
Plug 'https://github.com/EdenEast/nightfox.nvim'
Plug 'https://github.com/sainttttt/flesh-and-blood'
Plug 'https://github.com/pineapplegiant/spaceduck'
Plug 'https://github.com/tiagovla/tokyodark.nvim'
Plug 'https://github.com/zootedb0t/citruszest.nvim'
Plug 'https://github.com/ajmwagar/vim-deus'
Plug 'https://github.com/vim-scripts/C64.vim'
Plug 'https://github.com/folke/tokyonight.nvim'
Plug 'https://github.com/savq/melange-nvim'
Plug 'ARM9/arm-syntax-vim'
Plug 'https://github.com/yorumicolors/yorumi.nvim'
Plug 'sam4llis/nvim-tundra' " vim-plug
Plug 'https://github.com/ferdinandrau/lavish.nvim'

"Plug 'https://github.com/vim-airline/vim-airline'
" Plug 'https://github.com/xolox/vim-notes'
" Plug 'https://github.com/xolox/vim-misc'
" Plug 'tpope/vim-fugitive'
Plug 'lervag/vimtex'
Plug 'lervag/vimtex', { 'tag': 'v2.15' }
Plug 'https://github.com/nvim-lualine/lualine.nvim'
Plug 'https://github.com/preservim/nerdtree'
Plug 'https://github.com/nvim-treesitter/nvim-treesitter'
" Plug 'nvim-treesitter/playground'
" Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'rstacruz/vim-closer'
Plug 'https://github.com/mbbill/undotree'

" LSP Support
Plug 'neovim/nvim-lspconfig'
" Plug 'puremourning/vimspector'
" " Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'saadparwaiz1/cmp_luasnip'

"Autocompletion
Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v3.x'}

Plug 'https://github.com/williamboman/mason.nvim'
Plug 'https://github.com/williamboman/mason-lspconfig.nvim'
" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'w0rp/ale'

" Plug 'https://github.com/ErichDonGubler/lsp_lines.nvim'

" texpresso (latex thing)

" Plug 'https://github.com/jake-stewart/multicursor.nvim'

call plug#end()

let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_method = 'latexrun'

autocmd VimEnter * TSEnable highlight
colorscheme nightfly 


highlight Comment ctermfg=none guifg=#407040

let b:ale_linters = {'python': ['flake8']} 

"custom commenting-out of things 
autocmd FileType vhdl setlocal commentstring=--\ %s
autocmd FileType assembly setlocal commentstring=\;\ %s

"undotree
nnoremap <leader>u :UndotreeToggle<CR>

set undofile 

" Find files using Telescope 
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" doing stuff faster
nnoremap <C-s> :w<cr>
nnoremap <Space>w :w<cr>
nnoremap <Space>s :wq<cr>
nnoremap <Space>qq :q!<cr>

nnoremap <C-t> :NERDTreeToggle<CR>

" moving between split windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" resizing split windows
nnoremap <C-Up> :resize -2<cr>
nnoremap <C-Down> :resize +2<cr>
nnoremap <C-Left> :vertical resize +2<cr>
nnoremap <C-Right> :vertical resize -2<cr>

" next/prev buffer
nnoremap <S-l> :bnext<cr>
nnoremap <S-h> :bprevious<cr>

" hold onto line indent in visual mode
xnoremap > >gv
xnoremap < <gv

xnoremap <leader>c "+y

" moving text
xnoremap <A-j> :move '>+1<CR>gv=gv
xnoremap <A-k> :move '<-2<CR>gv=gv
xnoremap "p", "_dP

" opening nerd quickly
nnoremap <leader>e :NERDTreeToggle<cr>

" search and replace quicker
nnoremap ss :%s/

nnoremap ":", :<C-f>

nnoremap <leader>fr :browse oldfiles<cr>

au BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7

lua <<EOF
vim.o.undofile = true
require('lualine').setup()
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  formatting = {
    fields = { "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
}

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('lspconfig').pylyzer.setup({})
require'lspconfig'.jdtls.setup({})

	
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
    lsp_zero.default_setup,
  },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "tex",
    callback = function()
        vim.cmd("LspStop")
    end
})

EOF

local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
  Plug('catppuccin/nvim', { ['as'] = 'catppuccin' })
  Plug('nvim-lualine/lualine.nvim')
  Plug('nvim-tree/nvim-web-devicons')
  Plug('lewis6991/gitsigns.nvim')
  Plug('romgrk/barbar.nvim')
  --Plug('nvim-tree/nvim-tree.lua')
  Plug('lambdalisue/vim-nerdfont')
  Plug('lambdalisue/vim-fern')
  Plug('lambdalisue/fern-renderer-nerdfont.vim')
  Plug('lambdalisue/vim-fern-git-status')
  Plug('lambdalisue/glyph-palette.vim')
  Plug('nvim-lua/plenary.nvim')
  Plug('Julian/lean.nvim')
vim.call('plug#end')

vim.cmd.colorscheme('catppuccin-mocha')
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.autochdir = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.autoindent = true
vim.opt.smartindent = true

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16, -- ~60fps
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
      },
    }
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
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

vim.cmd('let g:fern#renderer="nerdfont"')
vim.cmd([[
  augroup my-glyph-palette
    autocmd! *
    autocmd FileType fern call glyph_palette#apply()
    autocmd FileType nerdtree,startify call glyph_palette#apply()
  augroup END
]])

vim.api.nvim_create_autocmd("FileType", {
  pattern = "fern",
  command = "setlocal nonumber norelativenumber",
})


vim.g.mapleader = " "
vim.cmd('nnoremap <Leader>e :Fern . -reveal=% -drawer -toggle -width=30<CR>')

require('lean').setup{ mappings = true }

-- -- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
-- 
-- -- optionally enable 24-bit colour
-- vim.opt.termguicolors = true
-- 
-- -- empty setup using defaults
-- -- require("nvim-tree").setup()
-- 
-- -- OR setup with some options
-- require("nvim-tree").setup({
--   sort = {
--     sorter = "case_sensitive",
--   },
--   view = {
--     width = 30,
--   },
--   renderer = {
--     group_empty = true,
--   },
--   filters = {
--     dotfiles = true,
--   },
-- })
-- 
-- vim.cmd.nnoremap('<Leader>e :NvimTreeToggle<Enter>')


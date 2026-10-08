return {
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
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
    },
  },

  {
    'romgrk/barbar.nvim',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      -- Move to previous/next
      { '<A-,>', '<Cmd>BufferPrevious<CR>' },
      { '<A-.>', '<Cmd>BufferNext<CR>' },
      -- Re-order to previous/next
      { '<A-<>', '<Cmd>BufferMovePrevious<CR>' },
      { '<A->>', '<Cmd>BufferMoveNext<CR>' },
      -- Goto buffer in position...
      { '<A-1>', '<Cmd>BufferGoto 1<CR>' },
      { '<A-2>', '<Cmd>BufferGoto 2<CR>' },
      { '<A-3>', '<Cmd>BufferGoto 3<CR>' },
      { '<A-4>', '<Cmd>BufferGoto 4<CR>' },
      { '<A-5>', '<Cmd>BufferGoto 5<CR>' },
      { '<A-6>', '<Cmd>BufferGoto 6<CR>' },
      { '<A-7>', '<Cmd>BufferGoto 7<CR>' },
      { '<A-8>', '<Cmd>BufferGoto 8<CR>' },
      { '<A-9>', '<Cmd>BufferGoto 9<CR>' },
      { '<A-0>', '<Cmd>BufferLast<CR>' },
      -- Pin/unpin buffer
      { '<A-p>', '<Cmd>BufferPin<CR>' },
      -- Close buffer
      { '<A-c>', '<Cmd>BufferClose<CR>' },
      -- Magic buffer-picking mode
      { '<C-p>',   '<Cmd>BufferPick<CR>' },
      { '<C-s-p>', '<Cmd>BufferPickDelete<CR>' },
      -- Sort automatically by...
      { '<Leader>bb', '<Cmd>BufferOrderByBufferNumber<CR>' },
      { '<Leader>bn', '<Cmd>BufferOrderByName<CR>' },
      { '<Leader>bd', '<Cmd>BufferOrderByDirectory<CR>' },
      { '<Leader>bl', '<Cmd>BufferOrderByLanguage<CR>' },
      { '<Leader>bw', '<Cmd>BufferOrderByWindowNumber<CR>' },
    },
  },

  { 'lewis6991/gitsigns.nvim', event = { 'BufReadPre', 'BufNewFile' } },
}

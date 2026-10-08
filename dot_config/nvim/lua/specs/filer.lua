return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    -- neo-tree 自身が遅延読み込みする
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      {
        '<Leader>e',
        -- fern の `Fern . -reveal=%` と同じく、開くたびに cwd を root にする
        function()
          require('neo-tree.command').execute({
            toggle = true,
            reveal = true,
            position = 'left',
            dir = vim.fn.getcwd(),
          })
        end,
        desc = 'Neo-tree (cwd)',
      },
    },
    opts = {
      window = {
        width = 30,
      },
      filesystem = {
        -- ディレクトリを開いたときは oil に任せる
        hijack_netrw_behavior = 'disabled',
        -- autochdir でバッファを移るたびに root が変わらないようにする
        bind_to_cwd = false,
      },
    },
  },

  {
    'stevearc/oil.nvim',
    -- ディレクトリバッファを乗っ取るので起動時に読む
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
}

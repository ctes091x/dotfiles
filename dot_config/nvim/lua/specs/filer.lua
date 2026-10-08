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
        window = {
          mappings = {
            -- fern と同じく h で閉じる・l で開く
            -- h: 展開中のディレクトリなら閉じ、それ以外は親ディレクトリを閉じる
            ['h'] = 'close_node',
            -- l: ファイルなら開き、閉じたディレクトリなら展開する(fern の open-or-expand)
            ['l'] = function(state)
              local node = state.tree:get_node()
              if node.type == 'directory' then
                if not node:is_expanded() then
                  require('neo-tree.sources.filesystem').toggle_directory(state, node)
                end
              else
                state.commands['open'](state)
              end
            end,
          },
        },
      },
      -- fern の hide_cursor と同じく、neo-tree 上ではカーソルを透明にする
      -- https://github.com/neovim/neovim/issues/3688#issuecomment-574544618
      event_handlers = {
        {
          event = 'neo_tree_buffer_enter',
          handler = function()
            vim.opt.guicursor:append('a:NeoTreeHiddenCursor/lCursor')
          end,
        },
        {
          event = 'neo_tree_buffer_leave',
          handler = function()
            vim.opt.guicursor:remove('a:NeoTreeHiddenCursor/lCursor')
          end,
        },
      },
    },
    config = function(_, opts)
      local function set_hl()
        vim.api.nvim_set_hl(0, 'NeoTreeHiddenCursor', { strikethrough = true, blend = 100 })
      end
      set_hl()
      -- colorscheme の切り替えで消えないようにする
      vim.api.nvim_create_autocmd('ColorScheme', { callback = set_hl })
      require('neo-tree').setup(opts)
    end,
  },

  {
    'stevearc/oil.nvim',
    -- ディレクトリバッファを乗っ取るので起動時に読む
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
}

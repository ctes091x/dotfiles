return {
  { 'nvim-lua/plenary.nvim', lazy = true },

  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  {
    'obsidian-nvim/obsidian.nvim',
    ft = 'markdown',
    cmd = 'Obsidian',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    keys = {
      { '<Leader>od', '<Cmd>Obsidian dailies<CR>', silent = true },
      { '<Leader>oq', '<Cmd>Obsidian quick_switch<CR>', silent = true },
    },
    opts = {
      -- 旧来の ObsidianXxx 形式のコマンドを無効化（`:Obsidian xxx` に統一）
      legacy_commands = false,

      -- frontmatter の自動付与・自動整形を無効化
      frontmatter = {
        enabled = false,
      },

      -- Obsidianの保管庫（Vault）へのパスを指定（複数指定も可能）
      workspaces = {
        {
          name = "personal",
          path = "~/Documents/Obsidian",
        },
      },

      -- 毎日のノート（Daily Notes）を使う場合の設定
      daily_notes = {
        folder = "diary",
        date_format = "%Y/%m/%Y-%m-%d",
      },

      -- 新規ノート作成時の挙動
      completion = {
        min_chars = 2,
      },
    },
  },
}

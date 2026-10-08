return {
  'saghen/blink.cmp',
  -- タグ付きリリースを使うと、ファジーマッチ用のビルド済みバイナリが落ちてくる
  version = '1.*',
  event = { 'InsertEnter', 'CmdlineEnter' },
  opts = {
    -- <C-n>/<C-p> で選択、<C-y> で確定、<C-e> で閉じる(Vim 標準の補完と同じ)
    keymap = { preset = 'default' },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    completion = {
      -- 候補を選ぶと横にドキュメントを出す
      documentation = { auto_show = true },
    },
    -- 引数入力中に関数のシグネチャを出す
    signature = { enabled = true },
  },
}

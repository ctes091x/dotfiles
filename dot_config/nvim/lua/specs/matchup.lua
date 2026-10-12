-- 対応する開閉タグ・キーワードのハイライトと移動(% / g% / [% / ]% / z%)
--   HTML / Astro / TSX のタグは tree-sitter(vim-matchup 同梱のクエリ)で、
--   LaTeX の \begin{} / \end{} は ftplugin の b:match_words で対応をとる
--   本体の matchparen と matchit はこれで置き換わる
return {
  'andymass/vim-matchup',
  -- 遅延読み込みすると最初のバッファで本体の matchparen が先に動くので、起動時に読む
  lazy = false,
  init = function()
    -- 相手が画面外にあるとき、既定ではステータスラインを書き換えて表示するが、lualine と喧嘩するのでポップアップにする
    vim.g.matchup_matchparen_offscreen = { method = 'popup' }
    -- カーソル移動のたびに同期で探すと大きいファイルで重いので、少し遅らせる
    vim.g.matchup_matchparen_deferred = 1
  end,
}

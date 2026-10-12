-- tree-sitter によるハイライト・インデント・折り畳み
--   Neovim 本体に同梱のパーサーは c / lua / markdown / vim / vimdoc / query だけなので、
--   Astro や TSX などは nvim-treesitter(main ブランチ)で入れる
--   パーサーのビルドに tree-sitter CLI が要る: `sudo pacman -S tree-sitter-cli`
local parsers = {
  'astro', 'typescript', 'tsx', 'javascript',
  'css', 'scss', 'html', 'json', 'yaml',
}
-- 折り畳みにだけ使う言語
--   LaTeX は本体の regex ハイライト(数式の conceal など)のほうが良いので、ハイライトは切り替えない
--   latex は grammar.js から生成するので、ビルドに node も要る
local fold_only = { 'latex' }

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  -- main ブランチは遅延読み込みに対応していない
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local ts = require('nvim-treesitter')
    if vim.fn.executable('tree-sitter') == 1 then
      -- 入っていれば何もしない。非同期で入る
      ts.install(vim.list_extend(vim.deepcopy(parsers), fold_only))
    end

    -- ここで入れた言語だけ有効にする(C や Lua などは今まで通り)
    local fts = {}
    for _, lang in ipairs(parsers) do
      vim.list_extend(fts, vim.treesitter.language.get_filetypes(lang))
    end
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('treesitter_start', { clear = true }),
      pattern = fts,
      callback = function(ev)
        -- パーサーがまだ入っていなければ従来の regex ハイライトのまま
        if pcall(vim.treesitter.start, ev.buf) then
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })

    -- 折り畳みは、パーサーと folds.scm の両方がある言語すべてで tree-sitter に任せる
    --   HTML / Astro はタグ単位、LaTeX は \chapter / \section と環境単位、Markdown は見出し単位で畳める
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('treesitter_fold', { clear = true }),
      callback = function(ev)
        local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
        if not lang or not vim.treesitter.language.add(lang) then
          return
        end
        if not vim.treesitter.query.get(lang, 'folds') then
          return
        end
        -- fold 系はウィンドウローカルなので、このバッファを表示しているウィンドウに設定する
        for _, win in ipairs(vim.fn.win_findbuf(ev.buf)) do
          vim.wo[win][0].foldmethod = 'expr'
          vim.wo[win][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        end
      end,
    })
  end,
}

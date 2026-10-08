-- tree-sitter によるハイライト・インデント
--   Neovim 本体に同梱のパーサーは c / lua / markdown / vim / vimdoc / query だけなので、
--   Astro や TSX などは nvim-treesitter(main ブランチ)で入れる
--   パーサーのビルドに tree-sitter CLI が要る: `sudo pacman -S tree-sitter-cli`
local parsers = {
  'astro', 'typescript', 'tsx', 'javascript',
  'css', 'scss', 'html', 'json', 'yaml',
}

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
      ts.install(parsers)
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
  end,
}

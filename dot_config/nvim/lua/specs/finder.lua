-- telescope 本体の spec は obsidian.lua にある。ここではキーマップだけ足す(lazy.nvim が同名 spec をマージする)
-- autochdir で cwd がファイルのディレクトリになるので、検索はリポジトリのルートから行う
local function root()
  return vim.fs.root(0, '.git') or vim.fn.getcwd()
end

local function builtin(name)
  return function()
    require('telescope.builtin')[name]({ cwd = root() })
  end
end

return {
  'nvim-telescope/telescope.nvim',
  keys = {
    { '<Leader>ff', builtin('find_files'), desc = 'ファイル検索 (repo)' },
    { '<Leader>fg', builtin('live_grep'), desc = 'grep (repo)' },
    { '<Leader>fs', builtin('grep_string'), desc = 'カーソル下の語で grep (repo)' },
    { '<Leader>fb', function() require('telescope.builtin').buffers() end, desc = 'バッファ' },
    { '<Leader>fd', function() require('telescope.builtin').diagnostics() end, desc = '診断一覧' },
    { '<Leader>fr', function() require('telescope.builtin').lsp_references() end, desc = 'LSP: 参照' },
  },
}

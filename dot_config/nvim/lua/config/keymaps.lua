-- プラグインに依存しないキーマップ
-- プラグインのキーマップは各 spec の `keys` に書く
local map = vim.keymap.set
local opts = { silent = true }

map('n', '<Esc><Esc>', '<Cmd>nohlsearch<CR><Esc>', opts)
map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)

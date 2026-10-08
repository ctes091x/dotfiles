-- leader は lazy.nvim の読み込みより前に設定する
vim.g.mapleader = " "

require("config.options")
require("config.keymaps")
require("config.lazy")

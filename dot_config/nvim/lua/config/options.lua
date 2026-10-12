vim.opt.number = true
vim.opt.cursorline = true
vim.opt.autochdir = true
vim.opt.clipboard = 'unnamedplus'

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.o.wildmode = "list:longest,full"

vim.opt.conceallevel = 1

-- 折り畳み: 方法(foldexpr)は tree-sitter のパーサーがある言語だけ specs/treesitter.lua で設定する
-- 開いた時点では何も畳まない。zc / zo / za で個別に、zM / zR で全体を開閉する
vim.opt.foldlevelstart = 99
-- 畳んだ行は 1 行目をハイライト付きでそのまま表示し、後ろを '-' で埋めない
vim.opt.foldtext = ''
vim.opt.fillchars:append({ fold = ' ' })

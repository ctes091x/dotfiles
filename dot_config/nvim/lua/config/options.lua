vim.opt.number = true
vim.opt.cursorline = true
vim.opt.autochdir = true
vim.opt.clipboard = 'unnamedplus'

-- ssh 先(orange など)は X がなく xclip が使えないので、OSC 52 で手元の端末のクリップボードに送る
-- 'clipboard' を設定していると OSC 52 は自動では選ばれないため明示する
-- 貼り付けは OSC 52 で読まず最後にコピーした内容を返す(zellij などを挟むと読み取りが返ってこない)
-- 手元のクリップボードから入れるときは端末の貼り付け(foot なら Ctrl+Shift+V)を使う
if vim.env.SSH_TTY and not vim.env.TMUX then
  local send = require('vim.ui.clipboard.osc52').copy('+')
  local copied = { { '' }, 'v' }
  local function copy(lines, regtype)
    copied = { lines, regtype }
    send(lines, regtype)
  end
  local function paste()
    return copied
  end
  vim.g.clipboard = {
    name = 'OSC 52 (copy only)',
    copy = { ['+'] = copy, ['*'] = copy },
    paste = { ['+'] = paste, ['*'] = paste },
  }
end

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

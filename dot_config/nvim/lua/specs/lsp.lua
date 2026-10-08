-- LSP の構成
--   言語サーバー本体: mason.nvim が ~/.local/share/nvim/mason に入れる(clangd は pacman のものを使う)
--   クライアント:     Neovim 本体の vim.lsp
--   サーバーごとの設定: nvim-lspconfig の lsp/*.lua(vim.lsp.config で上書きできる)
return {
  {
    'mason-org/mason.nvim',
    -- :Mason を開かなくても、起動時に mason の bin を PATH に足す必要がある
    lazy = false,
    opts = {},
  },

  {
    'mason-org/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = {
      -- 足りなければ起動時に mason で入れる。入っているものは自動で vim.lsp.enable される
      ensure_installed = { 'astro', 'tailwindcss', 'ts_ls' },
    },
    config = function(_, opts)
      -- K / grn / grr / gra などは Neovim 本体が既定で張る。定義ジャンプだけ足す
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = 'LSP: 定義へ移動' })
        end,
      })
      -- 0.11 から行末のエラー表示が既定で無効になったので戻す
      vim.diagnostic.config({ virtual_text = true })

      -- 競プロ用: compile_commands.json がないファイルでも bits/stdc++.h や C++23 の機能を解釈させる
      vim.lsp.config('clangd', {
        init_options = { fallbackFlags = { '-std=gnu++23' } },
      })
      vim.lsp.enable('clangd')

      require('mason-lspconfig').setup(opts)
    end,
  },
}

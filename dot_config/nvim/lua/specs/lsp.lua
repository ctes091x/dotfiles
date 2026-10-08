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
    config = function(_, opts)
      require('mason').setup(opts)
      -- mason-lspconfig の ensure_installed で扱えないものをここで入れる
      --   stylelint_lsp には stylelint-lsp(旧)と stylelint-language-server(公式)の 2 つが対応していて、
      --   lspconfig の cmd が使うのは後者
      --   prettierd は LSP ではないので mason-lspconfig の対象外(conform.nvim から使う。specs/format.lua)
      local registry = require('mason-registry')
      registry.refresh(function()
        for _, name in ipairs({ 'stylelint-language-server', 'prettierd' }) do
          local ok, pkg = pcall(registry.get_package, name)
          if ok and not pkg:is_installed() and not pkg:is_installing() then
            pkg:install()
          end
        end
      end)
    end,
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
      ensure_installed = { 'astro', 'tailwindcss', 'ts_ls', 'eslint', 'cssls' },
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

      -- Web(Astro + Tailwind + ESLint + Stylelint)向け。mikuec.com の .vscode/settings.json に合わせている
      -- tailwind-variants の tv({ ... }) の中もクラス名として補完する
      vim.lsp.config('tailwindcss', {
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                { [[tv\(([^)]*)\)]], [[{?\s?[\w].*:\s*?["'`]([^"'`]*).*?,?\s?}?]] },
              },
            },
          },
        },
      })
      -- pnpm のリポジトリでは、eslint-plugin-astro が eslint-plugin-jsx-a11y を見つけられず
      -- `Key "jsx-a11y": Expected an object` で落ちる。直接依存していないパッケージは
      -- node_modules/.pnpm/node_modules にしか置かれず、CLI では .bin/eslint のシムが NODE_PATH で補っているため、
      -- 言語サーバーにも同じ NODE_PATH を渡す(それ以外は nvim-lspconfig の lsp/eslint.lua の cmd と同じ)
      vim.lsp.config('eslint', {
        cmd = function(dispatchers, config)
          local cmd = 'vscode-eslint-language-server'
          local env
          if (config or {}).root_dir then
            local local_cmd = vim.fs.joinpath(config.root_dir, 'node_modules/.bin', cmd)
            if vim.fn.executable(local_cmd) == 1 then
              cmd = local_cmd
            end
            local hoisted = vim.fs.joinpath(config.root_dir, 'node_modules/.pnpm/node_modules')
            if vim.fn.isdirectory(hoisted) == 1 then
              local node_path = vim.env.NODE_PATH
              env = { NODE_PATH = (node_path and node_path ~= '') and (hoisted .. ':' .. node_path) or hoisted }
            end
          end
          return vim.lsp.rpc.start({ cmd, '--stdio' }, dispatchers, { env = env })
        end,
      })
      -- Tailwind v4 の @theme / @apply / @custom-variant などを未知の at-rule として警告しない
      vim.lsp.config('cssls', {
        settings = {
          css = { lint = { unknownAtRules = 'ignore' } },
          scss = { lint = { unknownAtRules = 'ignore' } },
        },
      })
      -- 既定では css / postcss しか検査しないので、scss と .astro の <style> も対象にする
      vim.lsp.config('stylelint_lsp', {
        settings = {
          stylelint = { validate = { 'css', 'postcss', 'scss', 'astro' } },
        },
      })

      require('mason-lspconfig').setup(opts)
    end,
  },
}

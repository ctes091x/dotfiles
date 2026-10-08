-- 保存時の整形
--   VS Code の formatOnSave + codeActionsOnSave(source.fixAll.eslint / stylelint)と同じ順で、
--   ESLint・Stylelint の自動修正 → Prettier の順に走らせる
local prettier_fts = {
  'javascript', 'javascriptreact', 'typescript', 'typescriptreact',
  'astro', 'vue', 'css', 'scss', 'html', 'json', 'jsonc', 'yaml',
}

return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  cmd = 'ConformInfo',
  keys = {
    { '<Leader>cf', function() require('conform').format({ async = true }) end, desc = '整形' },
  },
  opts = function()
    local by_ft = {}
    for _, ft in ipairs(prettier_fts) do
      -- prettier は起動だけで 2 秒ほどかかる(tailwind プラグイン込み)ので、常駐する prettierd を優先する
      by_ft[ft] = { 'prettierd', 'prettier', stop_after_first = true }
    end
    return {
      formatters_by_ft = by_ft,
      formatters = {
        -- prettier の設定ファイルがあるプロジェクトでだけ整形する(他人のリポジトリを勝手に全行書き換えない)
        -- どちらもプロジェクトの node_modules にある prettier を使う
        prettierd = { require_cwd = true },
        prettier = { require_cwd = true },
      },
    }
  end,
  config = function(_, opts)
    local conform = require('conform')
    conform.setup(opts)

    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim_create_augroup('format_on_save', { clear = true }),
      callback = function(ev)
        if vim.b[ev.buf].disable_autoformat or vim.g.disable_autoformat then
          return
        end
        -- コマンドは各 LSP の on_attach がバッファに作る(nvim-lspconfig の lsp/eslint.lua, stylelint_lsp.lua)
        local cmds = vim.api.nvim_buf_get_commands(ev.buf, {})
        for _, name in ipairs({ 'LspEslintFixAll', 'LspStylelintFixAll' }) do
          if cmds[name] then
            pcall(vim.cmd[name])
          end
        end
        conform.format({ bufnr = ev.buf, timeout_ms = 5000, lsp_format = 'never' })
      end,
    })

    -- 一時的に止めたいとき用
    vim.api.nvim_create_user_command('FormatToggle', function(args)
      local scope = args.bang and vim.g or vim.b
      scope.disable_autoformat = not scope.disable_autoformat
      vim.notify(('保存時の整形 (%s): %s'):format(
        args.bang and 'global' or 'buffer',
        scope.disable_autoformat and 'off' or 'on'
      ))
    end, { bang = true, desc = '保存時の整形を切り替える(! で全体)' })
  end,
}

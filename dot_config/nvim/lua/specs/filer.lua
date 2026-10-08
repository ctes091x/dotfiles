return {
  {
    'lambdalisue/vim-fern',
    cmd = 'Fern',
    dependencies = {
      'lambdalisue/vim-nerdfont',
      'lambdalisue/fern-renderer-nerdfont.vim',
      'lambdalisue/vim-fern-git-status',
      'lambdalisue/glyph-palette.vim',
    },
    keys = {
      { '<Leader>e', '<Cmd>Fern . -reveal=% -drawer -toggle -width=30<CR>', silent = true },
    },
    init = function()
      -- fern の読み込み前に設定しておく
      vim.g['fern#renderer'] = 'nerdfont'
      vim.g['fern#hide_cursor'] = true
      -- vim.g["fern#default_hidden"] = 1

      local group = vim.api.nvim_create_augroup('my-glyph-palette', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        group = group,
        pattern = { 'fern', 'nerdtree', 'startify' },
        callback = function() vim.fn['glyph_palette#apply']() end,
      })
      vim.api.nvim_create_autocmd('FileType', {
        group = group,
        pattern = 'fern',
        command = 'setlocal nonumber norelativenumber',
      })
    end,
  },

  {
    'stevearc/oil.nvim',
    -- ディレクトリバッファを乗っ取るので起動時に読む
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
}

return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  -- lazy.nvim 上だと既定で導入済みプラグインを検出して integration を有効にする
  -- barbar などの配色が vim-plug 時代と変わるので切り、旧既定で効いていたものだけ指定する
  -- (catppuccin 058e83d で default_integrations と show_end_of_buffer が廃止された)
  opts = {
    auto_integrations = false,
    integrations = {
      gitsigns = true,
      telescope = { enabled = true },
      neotree = true,
    },
    -- show_end_of_buffer = false 相当: `~` を背景色にして隠す
    custom_highlights = function(colors)
      return { EndOfBuffer = { fg = colors.base } }
    end,
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)
    vim.cmd.colorscheme('catppuccin-mocha')
  end,
}

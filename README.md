# dotfiles
ctes091x's dotfiles

```bash
# install chezmoi
sh -c "$(curl -fsLS get.chezmoi.io/lb)"
# or `yay -S chezmoi`

# init and apply
chezmoi init ctes091x
chezmoi apply

# install Vim / Neovim plugins
vim -c PlugInstall
nvim -c PlugInstall
```


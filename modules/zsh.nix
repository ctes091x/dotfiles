{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "re5et";
    };
    plugins = [
      {
        name = "zsh-autosuggestions";
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
        src = pkgs.zsh-autosuggestions;
      }
    ];
    setOptions = [
      "correct"
    ];
    shellAliases = {
      ":q" = "exit";
      ls = "ls --color=tty";
      la = "ls -a";
      ll = "ls -la";
    };
  };
}

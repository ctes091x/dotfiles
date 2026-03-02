{ pkgs, ... }:

{
  programs.zellij = {
    enable = true;
    extraConfig = ''
      show_startup_tips false
      pane_frames false
    '';
  };
}

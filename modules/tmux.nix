{ pkgs, ... }:

{
  catppuccin.tmux = {
    enable = true;
    extraConfig = ''
      set -g @catppuccin_status_modules "application session uptime cpu battery"
      set -g @catppuccin_window_status_style "rounded"
    '';
  };

  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      cpu
      battery
    ];
    extraConfig = ''
      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-left ""
      set -g status-right "#{E:@catppuccin_status_application}"
      set -agF status-right "#{E:@catppuccin_status_cpu}"
      set -ag status-right "#{E:@catppuccin_status_session}"
      set -ag status-right "#{E:@catppuccin_status_uptime}"
      set -agF status-right "#{E:@catppuccin_status_battery}"
      run-shell ${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux
      run-shell ${pkgs.tmuxPlugins.battery}/share/tmux-plugins/battery/battery.tmux
      set -g mouse on
      set -g default-terminal "tmux-256color"
      set -ga terminal-overrides ",*:Tc"
      bind -n M-f popup -E -d '#{pane_current_path}'
      bind c new-window -c '#{pane_current_path}'
      bind v split-window -h -c '#{pane_current_path}'
      bind h split-window -v -c '#{pane_current_path}'
    '';
  };
}

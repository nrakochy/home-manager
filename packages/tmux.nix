{ config, ... }:

{
  xdg.configFile."tmux".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.config/home-manager/dotfiles/tmux";
}

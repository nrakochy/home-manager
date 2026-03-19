{ config, ... }:

{
  xdg.configFile."starship.toml".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.config/home-manager/dotfiles/starship/starship.toml";
}

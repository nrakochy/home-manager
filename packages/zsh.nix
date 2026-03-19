{ config, ... }:

{
  home.file.".zshrc".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.config/home-manager/dotfiles/zsh/zshrc";
}

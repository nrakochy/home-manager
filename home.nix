{ username, homeDirectory, ... }:
{
  homeStateVersion = "24.05";
  home.username = username;
  home.homeDirectory = homeDirectory;
  nixpkgs.config = {
    allowUnfree = true;
  };
  fonts.fontConfig.enable = true;
}

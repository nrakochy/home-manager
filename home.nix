{ username, homeDirectory, ... }:
{
  home.stateVersion = "24.05";
  home.username = username;
  home.homeDirectory = homeDirectory;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  nixpkgs.config = {
    allowUnfree = true;
  };
}


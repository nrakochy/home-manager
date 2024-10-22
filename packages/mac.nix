{ pkgs, ... }:

{
  imports = [ ./common.nix ];
  home.packages = with pkgs; [
    stats
    tableplus
  ];
}


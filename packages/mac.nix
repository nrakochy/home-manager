{ pkgs, ... }:

{
  home.packages = with pkgs; [
    stats
    raycast
    tableplus
  ];
}


{
  description = "ftw";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, home-manager, flake-utils, ... }:

  flake-utils.lib.eachDefaultSystem (system:
     let pkgs = nixpkgs.legacyPackages.${system}; in
     { 
       packages.homeConfigurations = {
         workMac = home-manager.lib.homeManagerConfiguration {
           inherit pkgs;

           modules = [
             ./home.nix
             ./packages/mac.nix
           ];

           extraSpecialArgs = {
             username = "nrakochy";
             homeDirectory = "/Users/nrakochy";
             outputName = "workMac";
           };
         };
       };
    });
}

# schelleped over from https://github.com/jcpsimmons/home-manager/blob/master/packages/common.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # GUI Applications
    vscode
    obsidian

    # Shell
    neovim
    tmux
    zsh
    oh-my-zsh
    zsh-autocomplete
    zsh-autosuggestions
    zsh-syntax-highlighting
    tldr
    jq
    devenv

    # File Ops Tools
    tree
    git
    unzip
    ripgrep
    fzf
    bat
    entr
    duf

    # Process Handling
    btop
    killall

    # Networking
    gping
    speedtest-cli
    dog

    # Lang Specific
    stylua
    gopls
    go
    bun
    deno
    cargo
    pipx
    python3
    nodePackages_latest.typescript-language-server
    vscode-langservers-extracted
    emmet-language-server
    tailwindcss-language-server

    # Networking
    lsof
    nmap

    # Nix-Related
    nix-prefetch-git
    nil
    nixd
    nixpkgs-fmt

    # Misc
    ponysay
    gh
    typst
    (nerdfonts.override { fonts = [ "BigBlueTerminal" "JetBrainsMono" ]; })
  ];
}

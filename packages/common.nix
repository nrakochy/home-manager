# schelleped over from https://github.com/jcpsimmons/home-manager/blob/master/packages/common.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # GUI Applications
    vscode
    obsidian

    # containers
    colima
    amazon-ecr-credential-helper

    # Shell
    neovim
    tmux
    zsh
    zsh-autocomplete
    zsh-autosuggestions
    zsh-syntax-highlighting
    tldr
    jq
    devenv

    # File Ops Tools
    bat
    duf
    entr
    fzf
    git
    gh
    ripgrep
    tree
    unzip

    # Process Handling
    btop
    killall
    bottom

    # Networking
    dog
    gping
    kubectl
    speedtest-cli
    lsof
    nmap

    # Lang Specific
    stylua
    gopls
    go
    graphviz
    bun
    deno
    cargo
    pipx
    python3
    nodePackages_latest.typescript-language-server
    vscode-langservers-extracted
    emmet-language-server
    tailwindcss-language-server

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

# schelleped over from https://github.com/jcpsimmons/home-manager/blob/master/packages/common.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # GUI Applications
    vscode
    obsidian

    # containers
    amazon-ecr-credential-helper
    colima
    docker
    docker-compose

    #ci
    circleci-cli

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
    speedtest-cli
    lsof
    nmap

    # kubernetes
    helmfile-wrapped

    (wrapHelm kubernetes-helm {
        plugins = with pkgs.kubernetes-helmPlugins; [
          helm-secrets
          helm-diff
          helm-s3
        ];
      })

    k9s
    kind
    kubectl
    kubectx # kubectl ns switcheroo
    kube-linter
    kube-score
    popeye 
    terraform 
    tilt # hot-reloading
    stern # multi-pod color + aggregator

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
    tsx

    # Nix-Related
    nix-prefetch-git
    nil
    nixd
    nixpkgs-fmt

    # Misc
    ponysay
    gh
    typst
  ];
}

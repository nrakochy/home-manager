# schelleped over from https://github.com/jcpsimmons/home-manager/blob/master/packages/common.nix
{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.fira-mono
    nerd-fonts.fira-code
    starship

    # AI
    opencode
    #claude-code
    #claude-monitor

    # GUI Applications
    obsidian

    # containers
    amazon-ecr-credential-helper
    colima
    docker
    docker-compose

    # release
    vhs
    ffmpeg

    #ci
    circleci-cli

    # gcloud
    google-cloud-sdk


    # sourcegraph
    src-cli

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
    ## grcp
    buf
    duf
    entr
    fzf
    git
    gh
    fd
    poppler
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
    grpcurl

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
    kubeseal
    eksctl # amazon 
    kube-linter
    kube-score
    popeye 
    terraform 
    tilt # hot-reloading
    stern # multi-pod color + aggregator

    #go
    go
    gopls
    pprof


    # Lang Specific
    stylua
    graphviz
    bun
    rustup
    jdk17
    maven
    jfrog-cli
    azure-cli
    python3
    typescript
    typescript-language-server
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
  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {};
  };
}

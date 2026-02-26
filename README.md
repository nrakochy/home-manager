# Home manager

1. Install nix ([source](https://determinate.systems/oss/))

```nix
curl --proto '=https' --tlsv1.2 -sSf -L \
  https://install.determinate.systems/nix | sh -s -- install
```

1. `git clone` to `~/.config`
2.

```bash
nix run home-manager -- switch --flake '.#workMac' -b bak
```

1. :moneybag:

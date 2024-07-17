## Home manager

1. Install nix ([source](https://determinate.systems/oss/))

```nix
curl --proto '=https' --tlsv1.2 -sSf -L \
  https://install.determinate.systems/nix | sh -s -- install
```

2. `git clone` to `~/.config`
3. `nix run home-manager -- switch --flake '.#yourOutputMachineName' -b bak`
4. :moneybag:

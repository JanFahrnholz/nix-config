# Minimal Nix Darwin configuration

## Installation
1. Install the Nix package Manager from https://nixos.org/download/
2. Create and enter the folder for Nix Darwin ```mkdir -p ~/.config/nix-darwin &&
   cd ~/.config/nix-darwin```
3. Move the content of this repo into this folder
4. Run ``sed -i '' "s/simple/$(scutil --get LocalHostName)/" flake.nix``
5. Run ``sed -i '' "s/USER_POSITION/$(whoami)/" flake.nix``
6. Replace ``system = "x86_64-darwin";`` in the [flake.nix](flake.nix) with your Architecture (Intel = ``x86_64-darwin``, Arm = ``aarch64-darwin``)
7. Run ``nix run nix-darwin -- switch --flake ~/.config/nix-darwin``

## Usage
After modifying the configuration, please run this command to apply the changes
```shell
  darwin-rebuild switch --flake ~/.config/nix-darwin
```
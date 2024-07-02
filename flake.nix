{
  description = "Ambimax Nix Darwin configuration base";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    nix-darwin = {
        url = "github:LnL7/nix-darwin";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#MacBook-Pro-von-Jan
    darwinConfigurations."MacBook-Pro-von-Jan" = nix-darwin.lib.darwinSystem (let

            user = "jf";
            system = "x86_64-darwin";

        in {
            specialArgs = {
                inherit user;
            };
            modules = [
                #Base Setup
                {
                    nix.settings.experimental-features = [ "nix-command" "flakes" ];
                    nixpkgs.hostPlatform = system;
                    nixpkgs.config.allowUnfree = true;
                    system = {
                        stateVersion = 4;
                        configurationRevision = self.rev or self.dirtyRev or null;
                    };
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users."${user}".home = {
                        stateVersion = "23.05";
                        username = "${user}";
                        homeDirectory = nixpkgs.lib.mkForce "/Users/${user}";
                    };
                    services.nix-daemon.enable = true;
                }
                home-manager.darwinModules.home-manager


                # Configurations
                ./base.nix
                ./zsh.nix
            ];
        }
    );

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."MacBook-Pro-von-Jan".pkgs;
  };
}

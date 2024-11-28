{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nixpkgs, darwin, nix-homebrew }: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .
    darwinConfigurations = {
      "Jans-MacBook" = darwin.lib.darwinSystem {
        modules = [
          ./configuration.nix
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;

              # User owning the Homebrew prefix
              user = "jankleine";
            };
          }
        ];
      };
    };

    # Expose the package set, including overlays, for convenience:
    darwinPackages = self.darwinConfigurations."Jans-MacBook".pkgs;
  };
}

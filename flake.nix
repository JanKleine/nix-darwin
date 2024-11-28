{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, darwin, nix-homebrew, home-manager }: {
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
	  home-manager.darwinModules.home-manager
	  {
	    home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users = {
              jankleine = import ./home.nix;
            };
          }
        ];
      };
    };

    # Expose the package set, including overlays, for convenience:
    darwinPackages = self.darwinConfigurations."Jans-MacBook".pkgs;
  };
}

{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # lix = {
    #   url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
    #   flake = false;
    # };
    # lix-module = {
    #   url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.lix.follows = "lix";
    # };
    systems.url = "github:nix-systems/default-linux";
    # ghostty.url = "github:ghostty-org/ghostty";
    # helix.url = "github:helix-editor/helix";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    wallpapers = {
      url = "github:saylesss88/wallpapers2";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    # lix,
    # lix-module,
    treefmt-nix,
    systems,
    ...
  } @ inputs: let
    # system = "x86_64-linux";
    pkgs = import nixpkgs {
      system = "x86_64-linux";
    };
    inherit (pkgs.stdenv.hostPlatform) system;
    host = "magic";
    username = "jr";
    lib = pkgs.lib // home-manager.lib;
    forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        }
    );
    getTreefmtEval = system: treefmt-nix.lib.evalModule pkgsFor.${system} ./lib/treefmt.nix;
    myLib = import ./lib/default.nix {inherit (nixpkgs) lib;};
    nixosModules = import ./nixos;
    homeManagerModules = import ./home;
    # overlays = import ./lib/overlay.nix {inherit (inputs) devour-flake;};
    caches = {
      nix.settings = {
        builders-use-substitutes = true;
        substituters = [
          "https://cache.nixos.org"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        ];
      };
    };
  in {
    inherit lib;
    # Formatter for nix fmt
    formatter = forEachSystem (pkgs: (getTreefmtEval pkgs.system).config.build.wrapper);
    # Style check for CI
    # This creates checks.x86_64-linux.style etc.
    checks = forEachSystem (pkgs: {
      style = (getTreefmtEval pkgs.system).config.build.check self;
      # You can also expose specific custom checks like this:
      # no-todos = (getTreefmtEval pkgs.system).config.checks.no-todos.check self;
    });
    # Development shell
    devShells.${system}.default = import ./lib/dev-shell.nix {
      inherit inputs;
    };
    nixosConfigurations.${host} = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      pkgs = pkgsFor.${system};
      specialArgs = {
        inherit inputs host username myLib;
      };
      modules = [
        ./hosts/${host}/configuration.nix
        home-manager.nixosModules.home-manager
        # lix-module.nixosModules.default
        nixosModules # add all modules from ./nixos
        caches
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "bak";
          home-manager.users.jr = ./hosts/${host}/home.nix;
          home-manager.extraSpecialArgs = {
            inherit inputs host username myLib homeManagerModules;
          };
        }
      ];
    };
  };
}

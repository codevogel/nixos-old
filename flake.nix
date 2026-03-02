{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mnw.url = "github:Gerg-L/mnw";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    elephant.url = "github:abenz1267/elephant";

    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };

    gazelle.url = "github:Zeus-Deus/gazelle-tui";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      stylix,
      mnw,
      sops-nix,
      nixos-wsl,
      ...
    }@inputs:
    {

      packages.x86_64-linux =
        let
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };

          mnwPackages = import ./modules/shared/mnw/mnw.nix {
            inherit
              pkgs
              mnw
              self
              inputs
              ;
          };
        in
        mnwPackages;

      nixosConfigurations.home-nest = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs self; };
        modules = [
          ./hosts/home-nest/configuration.nix
          stylix.nixosModules.stylix
          sops-nix.nixosModules.sops
        ];
      };

      nixosConfigurations.work-nest = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs self; };
        modules = [
          ./hosts/work-nest/configuration.nix
          stylix.nixosModules.stylix
          sops-nix.nixosModules.sops
        ];
      };

      nixosConfigurations.work-nest-wsl = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs self; };
        modules = [
          ./hosts/work-nest/wsl/configuration.nix
        ];
      };
    };
}

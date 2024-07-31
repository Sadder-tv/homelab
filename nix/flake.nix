{
  description = "Homelab Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs, ... } @ inputs: let
    system = "x86_64-linux";
  in {
    nixosConfigurations = let
      base_args = {
        system = system;
        specialArgs = inputs;
      };
    in {
      hl1 = nixpkgs.lib.nixosSystem {
        inherit (base_args) system specialArgs;
        modules = [
          ./hosts/hl-docker/configuration.nix
        ];
      };
    };
  };

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
  };
}
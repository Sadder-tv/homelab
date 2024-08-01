{
  description = "Homelab Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, disko, ... } @ inputs: let
    system = "x86_64-linux";
    docker-nodes = [1];
    kube-nodes = [1 2 3];
  in {
    nixosConfigurations = builtins.listToAttrs (map (node: let
      name = "hl-docker-${toString node}";
    in {
      name = name;
      value = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { node = node; hostName = name; } // inputs;
        modules = [
          disko.nixosModules.disko
          ./base.nix
          ./hl-docker.nix
          ./disko-config.nix
          ./hardware-configuration.nix
        ];
      };
    }) docker-nodes) // builtins.listToAttrs (map (node: let
      name = "hl-kube-${toString node}";
    in {
      name = name;
      value = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { node = node; hostName = name; } // inputs;
        modules = [
          disko.nixosModules.disko
          ./base.nix
          ./hl-kube.nix
          ./disko-config.nix
          ./hardware-configuration.nix
        ];
      };
    }) kube-nodes);
  };

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
  };
}
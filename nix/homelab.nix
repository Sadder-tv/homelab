{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.homelab;
in {
  options.homelab.networking = {
    enable = mkEnableOption "Enable Homelab Networking";
    ipv4 = mkOption {
      type = types.int;
      example = "2";
      description = "IPv4 Address";
    };
    interface = mkOption {
      type = types.str;
      example = "ens33";
      description = "Interface";
    };
    subnet = mkOption {
      type = types.str;
      example = "192.168.0";
      description = "Subnet";
    };
  };

  config = mkIf cfg.networking.enable {
    networking = {
      useDHCP = false;

      interfaces.${cfg.networking.interface} = {
        useDHCP = false;
        ipv4.addresses = [
          {
            address = "${cfg.networking.subnet}.${builtins.toString cfg.networking.ipv4}";
            prefixLength = 24;
          }
        ];
      };

      defaultGateway = {
        address = "${cfg.networking.subnet}.1";
        interface = cfg.networking.interface;
      };
      nameservers = [ "1.1.1.1" "1.0.0.1" ];
    };
  };
}
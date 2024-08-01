{ hostName, node, ... }:

{
  imports = [ ];
  networking.hostName = hostName;
  homelab.networking.ipv4 = node + 2;

  virtualisation.docker = {
    enable = true;
    logDriver = "json-file";
    storageDriver = "btrfs";
  };
}
{ hostName, ... }:

{
  imports = [ ];

  networking.hostName = hostName;

  virtualisation.docker = {
    enable = true;
    logDriver = "json-file";
    storageDriver = "btrfs";
  };
}
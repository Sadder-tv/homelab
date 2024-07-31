{ ... }:

{
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "us";
  };

  users.users.rubsad = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];

    openssh.authorization.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIENnDoNMmH7MxgsrOytlzELNP/MyzF2agU59IdJ3gj/0 rubsad@DESKTOP-4OOJ8CP"
    ];
  };

  services.openssh.enable = true;

  networking = {
    useDHCP = false;

    defaultGateway.address = "192.168.64.1";
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
  };
}
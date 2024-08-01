{ pkgs, ... }:

{
  imports = [ ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "us";
  };

  users.users.rubsad = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];

    hashedPassword = "$6$Z.kJrAYuqy3X7wY6$UHXTpuYoBRg593PBTmjuEMZ1q6glnfclw3HlGbb9cCh58fm02otg85as2xBKI60ETjtG/YCSa2ISxw4BpBofS1";

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIENnDoNMmH7MxgsrOytlzELNP/MyzF2agU59IdJ3gj/0 rubsad@DESKTOP-4OOJ8CP"
    ];
  };

  users.users.root = {
    hashedPassword = "$6$Z.kJrAYuqy3X7wY6$UHXTpuYoBRg593PBTmjuEMZ1q6glnfclw3HlGbb9cCh58fm02otg85as2xBKI60ETjtG/YCSa2ISxw4BpBofS1";

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIENnDoNMmH7MxgsrOytlzELNP/MyzF2agU59IdJ3gj/0 rubsad@DESKTOP-4OOJ8CP"
    ];
  };

  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";

  environment.systemPackages = with pkgs; [
    git
    dig
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  
  networking.firewall.enable = false;

  system.stateVersion = "24.05";
}
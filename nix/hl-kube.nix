{ hostName, node, ... }:

{
  imports = [ ];

  networking.hostName = hostName;
  homelab.networking.ipv4 = node + 2 + 1;

  services.k3s = {
    enable = true;
    role = "server";
    tokenFile = /var/lib/rancher/k3s/server/token;
    extraFlags = toString ([
      "--write-kubeconfig-mode 0644"
      "--disable servicelb"
      "--disable traefik"
      "--disbale local-storage"
    ]);
    clusterInit = node == 1;
    serverAddr = if node == 1 then "" else "https://hl-kube-1:6443";
  };
}
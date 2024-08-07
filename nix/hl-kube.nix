{ hostName, node, ... }:

{
  imports = [ ];

  networking.hostName = hostName;

  services.k3s = {
    enable = true;
    role = "server";
    token = "sdasdfkhjasikfdhdsajkf";
    #tokenFile = /var/lib/rancher/k3s/server/token;
    extraFlags = toString ([
      "--write-kubeconfig-mode 0644"
      "--disable servicelb"
      "--disable traefik"
      "--disable local-storage"
      "--tls-san 192.168.20.9"
    ]);
    clusterInit = node == 1;
    serverAddr = if node == 1 then "" else "https://hl-kube-1:6443";
  };
}
{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wget
    git
    unzip
    uwufetch
    neofetch
    htop
  ];
}
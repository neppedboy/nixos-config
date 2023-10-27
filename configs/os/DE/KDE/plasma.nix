{ config, pkgs, lib, ... }:

{

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.desktopManager.plasma5.enable = true;
  programs.dconf.enable = true;


  ## SDDM
  services.xserver = {
      enable = true;
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        theme = "${import ../../../../beauty/sddm/sddm.nix {inherit pkgs lib;}}";
        settings = {
          General = {InputMethod = "";};
        };
      };
    };

   
  environment.systemPackages = with pkgs; [
    libsForQt5.spectacle
    libsForQt5.sddm
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugins 
    libsForQt5.qt5.qtquickcontrols2   
    libsForQt5.qt5.qtgraphicaleffects
  ];


}


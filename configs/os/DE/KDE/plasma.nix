{ config, pkgs, ... }: {

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.desktopManager.plasma5.enable = true;
  programs.dconf.enable = true;


  ## SDDM
    services.xserver = {
    enable = true;
    displayManager = {
      sddm.enable = true;
      # sddm.theme = "${import ./sddm/sddm.nix { inherit pkgs; }}";
    };
 };


  # qt5 = { 
  #    enable = true; 
  #   style = lib.mkForce "gtk2"; 
  #   platformTheme = lib.mkForce "gtk2"; 
  # };
   
  environment.systemPackages = with pkgs; [
    libsForQt5.spectacle
    libsForQt5.sddm
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugins 
    libsForQt5.qt5.qtquickcontrols2   
    libsForQt5.qt5.qtgraphicaleffects
  ];


}


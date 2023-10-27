{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [

    # braindamage moment
    veracrypt
    bitwarden 
    # v2ray
    # qv2ray
    firewalld
    firewalld-gui

    gnome.gnome-disk-utility
    gnome.gnome-software
    gnome.gnome-font-viewer
    
  ];
}
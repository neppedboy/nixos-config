{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    mangohud
    protonup-qt
    winetricks
    protontricks
    lutris
    prismlauncher
    bottles
    rpcs3
  ];

programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  
  programs.gamemode.enable = true;
}
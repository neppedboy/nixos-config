{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
  # Broken
  # (discord.override {  
  #    withVencord = true;   
  # })
  # Also broken because of older version
  # vesktop
    discord
    telegram-desktop
    brave
    firefox
    youtube-music
    
    spicetify-cli
    spotify
    
    anydesk
    corectrl
    thunderbird
    obs-studio
    qbittorrent
  ];

  
}
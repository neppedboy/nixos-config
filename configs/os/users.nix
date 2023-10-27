{ config, pkgs, ... }: {

# Superuser account
  users.users.superuser = {
    isNormalUser = true;
    description = "A super user";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      brave
      kate
    ];
  };

}
